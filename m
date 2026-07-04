Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E471E9906;
	Sat,  4 Jul 2026 05:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783143839; cv=fail; b=DVm3M+QbMKpU07/q1bfLdxBHmVznryR0b61w/lQfv4sjb/7CFEM8CZQjLvbE0U5Gu2U1pibLORSI4uWWJxcIqOwkQXJ95cFejlagyoLwDNbqqav9+JXqWg97ZHTK+eVi4KYFgR/1+HA9kdUPdSpbfe/1njM0xYijAMTzFjy4EzA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783143839; c=relaxed/simple;
	bh=BsIvuvrQF/vb5ZhlxMfCOxuDwK1Usgr/FgPw4PbKmAM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tGzubh9Lm1/WJ58q6Z0SaS/emddr/iZrMKqlueqdImG8GBcz9C36/9rNWVpBjUT4qJlnPuXms02Vo/WRWVkAEjYRiI1riTBUc3mZpBnBA0zeOgKGA306wvVuaxD8UxwJ8fvXn/5dPK74u+u/lYgMb0KyG5utw4BNfqGN2VbiGRw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i2CZUEEs; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i2CZUEEs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783143837; x=1814679837;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=BsIvuvrQF/vb5ZhlxMfCOxuDwK1Usgr/FgPw4PbKmAM=;
  b=i2CZUEEsX1+irrE9wDDd39/bs6Bv0vAAVXZYLJE+jrwBqoj04UgEfes7
   jxCXM1V/cQ7skupISLL/8gl8Ya2Om1wQDU8AfHsBosEKVNnkN/0v9mcss
   rgTL65jKj3IhfNlDam0BBgmXi9+KBZi5IBOrr3DvVJa9Wx+00yu5hQ3am
   d9JV/E7uRtjSTwTh2XSfNIgi2of5Jky6Lry8FjlSqjNb+R0sB+Q7c8LAr
   OXcwj3Y9rRc/1FyGNuBjAYPm9W4+Mj7sKXrRV+SIKdK4lOU4jk8MaleUm
   HdO2cdUh+kUokiLxEtU8sO9I2XEJc7BQCT28i+662+6PMrAuAmEpHkWKD
   A==;
X-CSE-ConnectionGUID: U8c8BFLqTv25C+uRecQOzQ==
X-CSE-MsgGUID: fHVRtZflSBGxQ+GIElk3Cw==
X-IronPort-AV: E=McAfee;i="6800,10657,11836"; a="109418107"
X-IronPort-AV: E=Sophos;i="6.25,147,1779174000"; 
   d="scan'208";a="109418107"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2026 22:43:57 -0700
X-CSE-ConnectionGUID: Rba/UW8FRTaS4KF8bixmNA==
X-CSE-MsgGUID: IJgfSGAcRKSN4k03WDPONw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,147,1779174000"; 
   d="scan'208";a="283330496"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2026 22:43:57 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 3 Jul 2026 22:43:56 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Fri, 3 Jul 2026 22:43:56 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.41) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 3 Jul 2026 22:43:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q1j520EkDkJYFC4DZzkGp/7wV2iR1FjppgACtSgtIi2cUxk7QDrfrWW7Ut2MSRLqLWfLF7LEa1TF8rFvx3XIp6794tXctXoHhakZjnWsaAdLIVFxy5AVXeASGWETNHs9K+YpO0gCamE9Czi5MNcHEjAZBVt0zveibdppGnD0l6MRtuAl7Y+u7BXqjy2qvfcA9AgNNc9Q+f4M6W/EKLrHhUm/YtT4dSbUpJwpVyzfy/1YH+fIRKLuTZCy+xJWTc0BjJWWgLZwOd8jn3Y2nXcISrYUXUNpc6HkHiCoptl389T5VoZ35g7f60T53SuVwElwbJIsCOoqmJvIQK8Roqy2ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NLnhmGQCBuN7FlkbooS6ylbsFEjbrpdFhQIgLDlp3ds=;
 b=MZZVUaBzuWvamoTYeJRIxlerXdhJAs3pF2Qu+k34JtR6A/8dpEMbnsEnouDYMAQp9Xw3KR4Y6XyoPj28EZikE0EbGipUtvp8ZrhsnopVdnYw6BJlhbz3eB/w0x//oS4nk0Flm2MpZoYBYV+fCl2E7XegIKrZNzmJHjauOhdm1HZ0T2EURZ44OpZDXt/OToNwY1doGVGzaP3IBvB70YOCkR38h9ILUdB1pwYniWEYB5NaBL3skPUQzINXOa+qQGFfEU3hDoabOlZ1Amo7cU4yVNeprzkQlHnGbCi6gPJcgUqFsSYSgJcSC8NDZMhBHOeVZr64ip/ptlunIB54cwFw0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com (2603:10b6:a03:3b9::19)
 by SJ5PPFBC9025319.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::84e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Sat, 4 Jul
 2026 05:43:49 +0000
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e]) by SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e%4]) with mapi id 15.21.0181.010; Sat, 4 Jul 2026
 05:43:49 +0000
Date: Fri, 3 Jul 2026 22:43:42 -0700
From: Peter Fang <peter.fang@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC: "seanjc@google.com" <seanjc@google.com>, "djbw@kernel.org"
	<djbw@kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, "Li, Xiaoyao"
	<xiaoyao.li@intel.com>, "Hansen, Dave" <dave.hansen@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "Hunter, Adrian"
	<adrian.hunter@intel.com>, "kas@kernel.org" <kas@kernel.org>,
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>, "Xu, Yilun"
	<yilun.xu@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Mehta, Sohil" <sohil.mehta@intel.com>,
	"Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "Maloor, Kishen"
	<kishen.maloor@intel.com>, "yilun.xu@linux.intel.com"
	<yilun.xu@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v2 16/17] KVM: TDX: Add in-kernel Quote generation
Message-ID: <20260704054342.GB2169894@pedri>
References: <20260618081355.3253581-1-yilun.xu@linux.intel.com>
 <20260618081355.3253581-17-yilun.xu@linux.intel.com>
 <aj1tFuwZWdPGfUoG@google.com>
 <20260629100301.GA1743876@pedri>
 <akMQ3J6fK3DUBsPH@google.com>
 <23a9173f6e278ca7dfedce3374626c6ea3e1b47a.camel@intel.com>
 <6a445e4be6b12_3a3568100db@djbw-dev.notmuch>
 <akVNdxCzk-n4bgMv@google.com>
 <9df36c49e6be69dd9eece71f70a404a84b1563ab.camel@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9df36c49e6be69dd9eece71f70a404a84b1563ab.camel@intel.com>
X-ClientProxiedBy: SJ2P220CA0002.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5da::10) To SJ0PR11MB5645.namprd11.prod.outlook.com
 (2603:10b6:a03:3b9::19)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5645:EE_|SJ5PPFBC9025319:EE_
X-MS-Office365-Filtering-Correlation-Id: f987de1d-ec30-4055-4a45-08ded98f360c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|7416014|22082099003|18002099003|11063799006|56012099006|6133799003|4143699003;
X-Microsoft-Antispam-Message-Info: vPwRiEsGu9s1QcLtgdxRv4HKC9quye7g1wc/P5QSpKlYl7dTwrJ/6Mf+8RBA0hlZxFkPvQgGNq7aQCQPMHsOZGGjLi+PgYsWBPzhm38wyFWdx3clpoJ1oX/RXL6rKgwIrUpZJxFEmUidJvH9uBu+gvVKWn7/901VgK9RKbRkuzukH2nCi8pv+CusVLX+GsME/0Ag/tgQ0T0SRllGr6FFtqOAT18agL8DUk61juBg2vQn37iiyK1ub3EK2CnW4BPdx1/4i4Rbre//4pfkGo9SqZXMiy1wpaUjVVMmAH5uJXi4wc3FGUV+jnDS6zyxh/Urkib386CjiuomcP6dBgWsvRBDTM5KDuK+e9pq848WW12iwUrj3S44fk2RvedC5uF9d3EojxFeHt8r8/1ZLe6+AZgNpWuAd+bJzQNI4GMa3zgLh7C+NfOMz5LaMicwxpThxGbxhJ7zi/0Ak4hD8CBEAiyyWIeSe72fefswj6RtxsUDbecGCzWZzSYj+fxlcAbl/dwDkUtz6Hwku/IAhwPvALKVojsVkkPmeqCKB9EYU31GBPb6xyxAMPRUjNsPrA2g3L01tVSWLVLiNy1dGECksJ/TW5GHhAnhzrMslxLj7cwLvBUpp/VCoawQe386+7qJ/752QSM0ywxQKwm/2nRCU6qpKjGh3LyF+i91c8PGVa8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5645.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(7416014)(22082099003)(18002099003)(11063799006)(56012099006)(6133799003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VENDR1FDMXk1QWdoRzBsL2o1TFdFallkTTRxaCtXWTFPL0FZQWUrdk00eVFX?=
 =?utf-8?B?V2xuRlZNdnRmTG93dTBMREZEMkFaZGxtY2ZmZitjVnozaDMzeEtTQWNsSVNE?=
 =?utf-8?B?eC9ITTFtY25scFBucDU5TXZpVnNEb01adkpvdm1pZmUzRTltblFERk5OWnA0?=
 =?utf-8?B?bGhLSzVsUm9YdDI2NEt6U3pPamduVW5TUVkrRDJXRTdzZG4wV1ZiWk9RcGgr?=
 =?utf-8?B?RWpUZStMUng0Y3JYZ3M3ZitiK0d6SkpSYzFFbTdXbEhobzhqVzFxaEppZC9t?=
 =?utf-8?B?OVI4Y21GZW9EdEpOSjFrUWFCL3pKOTFXNTBoTWxjOHA1alBSK2tOZ3doMXhJ?=
 =?utf-8?B?Mm9iQlEyc1E0WmcyT1JsZW10anRpay80SXQrTHNxZ0xhNDRlOGZobk9KTTFu?=
 =?utf-8?B?T050b0dycncwMUNMcVAyd0llVFplZVM1bnBJV1FNR1JLNVo0eGQ2dUpQOEpx?=
 =?utf-8?B?OTJzejF3c1p6U1B2OWxTK1pnRjg2Nm9MRkR3dDdpZDFlZmJ0VUZlOEx3cjJT?=
 =?utf-8?B?QStrMS81S3JHbzR2MVRNbGlBUjdpR00yM3ByY0Fma0xWbTNrSEhqNFNtOFFH?=
 =?utf-8?B?bHJuT3hRNFNmVzZoenZKSXBCcDJaM3VZcG16d1Flci9mS045d0J3SStZbTJR?=
 =?utf-8?B?ZWo3ekM0MmZEWDJlSzZvUHNDRmk5S1luSk96bytGdjV3ZXVlQktiQlFaNFVt?=
 =?utf-8?B?aFlBdkNQbVFETUpBM1dHNTBrQk01dnlLOGNsTnVXak5CRG5ZWWhheEFpWjdk?=
 =?utf-8?B?ZG1uNDUrcDZTditiVXBPU0VwTGhTU0dWVGlOS25yelYydlpOQ0Zzd0lnSDdR?=
 =?utf-8?B?U2xFRmRhOHlHNU5IK2RHQkl2OWlGRHg1SjRLNURObzVHRjNBVVBsY1hzOEpC?=
 =?utf-8?B?TGNzTUpRNkh3VC9JOEk2T1U0OUVCMDR6dmYyamVjZmN4RmpxaEJyRG53K1N3?=
 =?utf-8?B?VkdIRE1KdEIyL2VGMVdjeHA5NEprTVBJM1ZsVWZRT2hPRDl0NHdGUFNBZVpJ?=
 =?utf-8?B?TmJUaFJ6ZkhxalVURmlnOU94RXluSHBwczJYL0I2VnpGQllkWXlUYzVIOC9H?=
 =?utf-8?B?UWlPWGJmUCsydHppL3JoOE4yZTNWVHFweXBETnVlWmxZZDV0QkxVUUlDdlNZ?=
 =?utf-8?B?VU9FYVhicFFuSmM0Z2NkVExzZnFCZHJmbThXT1NwQ3F3MTFKa25zYjlwSlRa?=
 =?utf-8?B?NjgvSng5ZVV3dDIzMFA2VnhKWkxRWWZucFF5VEtudzFpQnV2U0Jlc0x5Q3FP?=
 =?utf-8?B?VlREcnU3MXpTWFRORHVQMW9SNkV2aC9pY2pKZTNBM1NlTk9nVGtPZjlqOGE2?=
 =?utf-8?B?emJkOXpKbWtnYjhEVnhESHdYeDF4Z0d3WFdMcXJoUkI5dCtUUUVNL1NINkpS?=
 =?utf-8?B?Uys4L3locDNBZEtrbEFkbVcyRXdlM0xaTXJibWxQK3c2UmlhdXRBaWlYemFz?=
 =?utf-8?B?YW1XWTB4QlhuRTkyWHRhRUNVY0MyekpQbzBDbzNYbjhIckZkdlFDVEJ5WjVK?=
 =?utf-8?B?dzkzVkI3QWlDaXhMZ3ArdEZsRDFaRmlUYndkakRVTUthNFd5aUJNL0NTcXZO?=
 =?utf-8?B?cTRwQ2dlWjN5YWRqMEUrY2dibzc0RGcvNHZuSGxyVStnNkNseWpqYkliaW9I?=
 =?utf-8?B?VDZIZUgreEZESFhWRWtpN1poZHlOMGpVcGZlQWc3Sm9DV1BHMkFuM3FPMklp?=
 =?utf-8?B?M055UkJQUVFBdjFuV3ROQ1VLQ09Wb0g2NXlCdkdGdDY5UDZVb3dBcTE5K3pj?=
 =?utf-8?B?cjVPQUVDaGxsRVI1V25nc2RoVlI5K1V3b1U5NVFrMHpTZXo3VERReC9qbWJn?=
 =?utf-8?B?UGVjNzRHL0ExUXR4OVdUWkUvR3hYY1Y2Wmtia3ptR1psQ25MVWtKVDF4Tk5O?=
 =?utf-8?B?d3ZIVTRnUitycENPWHY4eGVoMXF5NzZvUHJxZTVZK3RDaFZwMENiWFpQS1JV?=
 =?utf-8?B?SmhxNWxqMGhzSnpwM1BnNTBNMmk1bkVkZ3ROMmwvcmNwalFjclZGTXpJbzZk?=
 =?utf-8?B?TUhJKzh6NXJMV2N1emdrR292WGZNR3o0dWxqMFRNSWNaY1NyK1BUc1pXZ0E5?=
 =?utf-8?B?TmF6WVI1U2U2bFdHZFNMRGl5WWJCZDVtMUVKNUhacE00N3F5YkMvUENsb3Zs?=
 =?utf-8?B?bWF3aHlMcTFzaENEWUd0NWpDRkxMU0xtaU5zMndma2ZSMDVBbFEvY0MwODY0?=
 =?utf-8?B?TmlDTE1vdXZEUDJ0cndtVS9Lb1MxbHY1d0tKMWZTWDJVdnJPR3dpbWV1bUFl?=
 =?utf-8?B?dlJkRFRldmtlQU9FZW51SUJJWHVGcDFqK1JmczFFeGVBVDRFMnJ3cmVjM1dJ?=
 =?utf-8?B?RHFaaG1zOFJRMDl3bncweXBFeFdRUklUOXdUdHB3Si84WFBQLzlWUT09?=
X-Exchange-RoutingPolicyChecked: p1mz8GFUtQ26mQFKGAcbiOvynkPT8lZIFiV0Lr00yi+RdyjvZkD7dgXiECgJwi1OzrzHB2x14hRBu3ir2xdcd59lkaHvxUFZ1M0FLOPIy7kN7jT9O9mUirKWRN7B/ATTbUnmMvG1vSNtEvd+zvoe13ogXht3QsrYggd3c6f8NhlDKdI4V8X+Tg4/NXuyHs1rOj8JQOPRCZuYQKwpNXPUS+l6+ekO0WLGy00KFWHCXYe8zcg2/whSZUrvU0+8ZZ3Ba+dD3RWGYm1CbNWJDusURxaPL+vuVNIg7UuH6nPZlu6mexZpjWjqXmmb8xLCTqyOlmnjsooYX8ezVeugQ1PK/w==
X-MS-Exchange-CrossTenant-Network-Message-Id: f987de1d-ec30-4055-4a45-08ded98f360c
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2026 05:43:49.1976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D9QECi3IBFGAQ+0w2KSZBrrXEH73ZFUAWmdiJCG8Lweo66BoBJN7Kst91musjjILyCvXDynKIglhLPxgHZusoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFBC9025319
X-OriginatorOrg: intel.com

On Wed, Jul 01, 2026 at 11:45:53AM -0700, Edgecombe, Rick P wrote:
> On Wed, 2026-07-01 at 10:25 -0700, Sean Christopherson wrote:
> > > > That is a good question. The answer is partly historical reasons, but I
> > > > think the pros/cons don’t really move the needle too much.
> > > > 
> > > > The main benefit of doing it with the host in the loop is that the guest
> > > > side TDVMCALL quoting interface can stay the same. There is also a wrinkle
> > > > in that there is a limited HW resource involved in the quoting,
> > 
> > What is this magical resource?
> 
> It's a HW crypto thing. I'll let Peter explain more.

It's called S3M (Secured Startup Services). There was once a public
document about it, but it was removed for some reason. It basically
provides a number of boot and security services through dedicated HW.
Attestation is one of them. This is part of our plan to develop new
attestation schemes without using SGX.

There was a lot of internal debate about how this HW should be managed.
We decided to let the TDX module handle it and sort of hide it from the
host kernel and only expose it as SEAMCALLs. It however impacted how the
quoting SEAMCALLs look, so apologies for not calling out these factors.

> 
> > 
> > > > so we want to do these operations one at a time. Having a mutex on the
> > > > host is the KISS way of accomplishing some level of fairness for DOS
> > > > prevention.
> > 
> > At the risk of unintentionally causing effecitvely DoS by introducing a
> > system-wide lock.
> 
> The DoS that people are interested in trying to prevent is a TD getting starved
> of quotes forever. So the lock is supposed to give some eventual fairness.
> Eventually the guest gets its quote even if it has to wait.
> 
> If instead contention throws a BUSY code to the guest, the guest spins trying.
> That wouldn't have the guarantees.
> 
> So I think the two options are: have some lock in the TDX module, or have a lock
> of some sort in the host. I think actually a waiting lock in the TDX module is
> possible. But I think there are tradeoffs besides where the extra code is. If
> it's in Linux we get a lot more control, lockdep, etc.
> 
> BTW the "historical reasons" part I mentioned involves a past effort to create
> configurable host controlled policies around managing these resources. So part
> of the simplification is doing a simple eventually fair global lock instead of
> something more complicated.

Yeah my bad for not including a lot more background. There were several
design aspects that influenced this implementation. I'll do a better job
of explaining them in the next version, but basically:

  1. Performance requirements: For this first implementation, the
     priority is to not starve a legit guest from getting a quote, even
     when there's a malicious guest DoSing the host. A mutex is sort of
     a "fair enough queue" for this problem. A guest's authenticity can
     only be verified after the quote is generated.

  2. HW limitation: The TDX module implements different attestation
     schemes, some of which use the S3M during TDH.QUOTE.GET. This
     limits the amount of concurrency this SEAMCALL supports and is also
     part of why we chose a mutex for TDH.QUOTE.GET. (The shared buffer
     in core TDX doesn't seem great, so I will improve it.)

  3. Host policies: Preserving the GetQuote GHCI also allows the host to
     participate in the quoting process, e.g. add host-controlled
     policies or fetch host-side quote information. It's a bit similar
     to SEV-SNP's KVM_EXIT_SNP_REQ_CERTS [1]. This series does not
     implement host policies though.


Ultimately, there are ways to push more of this into the module, and the
current design is kind of a tradeoff between the complexities of the
work needed in the guest, the host, and the TDX module. Like Rick said,
there were past versions that required way more work in the host and the
guest, such as managing the S3M, new GHCI calls, etc.

[1] Commit fa9893fadbc2 ("KVM: Introduce KVM_EXIT_SNP_REQ_CERTS for SNP
certificate-fetching"

> 
