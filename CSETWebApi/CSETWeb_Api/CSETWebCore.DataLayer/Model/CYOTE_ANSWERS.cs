﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
#nullable disable
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace CSETWebCore.DataLayer.Model
{
    public partial class CYOTE_ANSWERS
    {
        public int Assessment_Id { get; set; }
        public int Observable_Id { get; set; }
        [Key]
        public int Answer_Id { get; set; }
        public int Path_Id { get; set; }
        public int Option_Id { get; set; }
        public bool Selected { get; set; }

        [ForeignKey("Assessment_Id")]
        [InverseProperty("CYOTE_ANSWERS")]
        public virtual ASSESSMENTS Assessment { get; set; }
        [ForeignKey("Observable_Id")]
        [InverseProperty("CYOTE_ANSWERS")]
        public virtual CYOTE_OBSERVABLES Observable { get; set; }
        [ForeignKey("Option_Id")]
        [InverseProperty("CYOTE_ANSWERS")]
        public virtual CYOTE_OPTIONS Option { get; set; }
        [ForeignKey("Path_Id")]
        [InverseProperty("CYOTE_ANSWERS")]
        public virtual CYOTE_PATHS Path { get; set; }
    }
}