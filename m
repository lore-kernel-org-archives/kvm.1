Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE5B1E4AF;
	Tue, 28 Jul 2026 00:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785197891; cv=fail; b=nADiVgMmS8YbAh6cEm2m6wGruBOwvk+i54KOVCgwQg15rgDyQTEfBMxNmUTWupaHbXBg0CTNDNiFds0w2ZWx7qWCGToFd77weqVInh3BbdDcJmU0iDs1NMzULQWdvY6B44npuM0soumZ8zB7VZSwod9zumPm1Syd+06HyyHkLBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785197891; c=relaxed/simple;
	bh=5/+3QLWpjt0Kfrp+3aAIjJd/9O97D3gKgo3jX+/nOlA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WF2mo+EG6jpV/2udQqIQPZk5Wj8scuoTSct5Qhr4JTTKEF4NsaRrRugUuQHeN56QBi9ThKQsbr8IP9kEfPLG0L5HvxVaCMVO7WiahMSPrf0tEBBIhJjYlFMHTUcv0oT6Y0Lyk3gQYT0H0E6Tg1ApyM6+T20QogzLRKZwy4tZHuw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kfiMlXVv; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kfiMlXVv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785197889; x=1816733889;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=5/+3QLWpjt0Kfrp+3aAIjJd/9O97D3gKgo3jX+/nOlA=;
  b=kfiMlXVvyQC0fKex1z+hJj6auZIHRAL9GMtc2qAhXx7ux0rci77zULKS
   mrE71o3BvYmAa2nkI5lqtuMWbSddStzLaf/kARIZQgo6yAPnkaStAiFin
   /F9YNmYkdBKFgRqf2FV5/5+dAlmZZeEyRIIu8iDtOvHbIaF3njomPOgWB
   CItJa72wonwiv10kh7/WH89+rw5b9BMWGLnyx8L0pqfz7Jw41bD9dpvfh
   6D3xsyrhdA7apdomPrZ8fYZjkWiMJFv82MUBvtqW0A1FeoDFg7s/Gejw9
   LGkL1C4sshcIgSxlJtuVRV9Hw1oDPRtUZmnKyG8A5K6Dy+RDgVSSkBRtC
   A==;
X-CSE-ConnectionGUID: bLcUjzEgQoyIkf9klPQjMQ==
X-CSE-MsgGUID: tWvnVDDCSgOHP6+uMa2Jkg==
X-IronPort-AV: E=McAfee;i="6800,10657,11858"; a="73312288"
X-IronPort-AV: E=Sophos;i="6.25,189,1779174000"; 
   d="scan'208";a="73312288"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 17:18:07 -0700
X-CSE-ConnectionGUID: uRg+bcHDTaKuLlU5OPqjBA==
X-CSE-MsgGUID: k+9TA7udS1+SM87v8spTOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,189,1779174000"; 
   d="scan'208";a="297779894"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 17:18:07 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 27 Jul 2026 17:18:06 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 27 Jul 2026 17:18:06 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.31) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 27 Jul 2026 17:18:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ikf6uvZavvH9WvgYhMSZLWr7n76OD7fv7TbNzhA3Yt5ht+a8Y5ED9BXC7ewemaA5yLdSWnBrcmPNEwkxJD/scnMpAFeHBxkbtoH/rV4b0eua7xyPWtr11U9jlUnlW38T3mavgfZlXOnPU5KwwadxeCZNzdKUTdVRunI8Z27yo5lf+YSJabLPA1p4RV25bnpEkLmbq0ZLPUrrVtk29LPQpu0UQ5hEAu94AtiASDf/fAx/XyZM3DRnBO3ySvFITHKb4J2BHbTGKMJiwj+xw5Adjbj8+GE9LaWsGBHZH1JFVmiybVbNg6vV59y1JPX16ebyHLon689rzP6J19x1LweWHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5/+3QLWpjt0Kfrp+3aAIjJd/9O97D3gKgo3jX+/nOlA=;
 b=opTlU7BvEzlTQhbJ/Ad93RHLBOQJFXKNEC2eCoZY/SA0+EbtnAraU4w42MCSSNh8/ByYJzKP5pJSEien6v6T6g3JyT2l+sP37FjRTcgX5ngvd0PykuYd2potkJLU7eekAJ+RcxwVysBzW+YgVaGnP8Q8Hn42SWMGAkFFADUvMjw/LvWWKagqGSI9n3zKuzgRhTWyDYS0NsU1ZlMvqpB/q0R2I6NB0Ka49OxOuI7QpKpQmL7NFhLAxyZCcrcZM0P9wfcDxhEYbvZ5oUbgEnL1YNg2hRNWOTj2Lm/MO43NbX9Apkk5d5dLEnGWe0C03sRb2cY1NYdGxuo6mGii885+6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5702.namprd11.prod.outlook.com (2603:10b6:8:21::10) by
 IA4PR11MB9372.namprd11.prod.outlook.com (2603:10b6:208:568::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 00:18:01 +0000
Received: from DM8PR11MB5702.namprd11.prod.outlook.com
 ([fe80::a973:3a5a:91e8:49b9]) by DM8PR11MB5702.namprd11.prod.outlook.com
 ([fe80::a973:3a5a:91e8:49b9%7]) with mapi id 15.21.0245.012; Tue, 28 Jul 2026
 00:18:01 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "seanjc@google.com"
	<seanjc@google.com>
CC: "Wang, Zhong" <wangzhong.c0ss4ck@bytedance.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "zdi-disclosures@trendmicro.com"
	<zdi-disclosures@trendmicro.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "bestswngs@gmail.com" <bestswngs@gmail.com>,
	"shixuanqing.11@bytedance.com" <shixuanqing.11@bytedance.com>
Subject: Re: [PATCH v3] KVM: x86: Cancel delayed I/O APIC EOI handling before
 destroying vCPUs
Thread-Topic: [PATCH v3] KVM: x86: Cancel delayed I/O APIC EOI handling before
 destroying vCPUs
Thread-Index: AQHdHezIj0MAKbfWsk2XLavhbDPU9baCETwA
Date: Tue, 28 Jul 2026 00:18:01 +0000
Message-ID: <2240a9184a6f454b86d5ff67a31dec3fd416b7b8.camel@intel.com>
References: <20260727171718.543491-1-seanjc@google.com>
In-Reply-To: <20260727171718.543491-1-seanjc@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5702:EE_|IA4PR11MB9372:EE_
x-ms-office365-filtering-correlation-id: 18c2fa74-37b9-4b48-9aa2-08deec3daf86
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|6133799003|22082099003|18002099003|10067099003|11063799006|56012099006|38070700021;
x-microsoft-antispam-message-info: O6oS8dGyHMpYw6rMLehmYnbgF/trjRcBJbzTFrn1dPwSjnJvU1KoPld5+JH/f+V8xuH6MAK8i2R+uxLzBe5Ap2UIPDGf1kvrffbOoaqh3nXAEy3potq2V92EH6jnWEtabCIhkt2QbJqrpgnTPl7hKgAd8DVuYz67m2YwFevdEFuSEn5BPkW46zmBPUnUOKNo7bwKqtjThxfuhW4WOIxMbgQshAQMw6I5/egxcjpbtk6p5fdIGgrgjMYFufiZ48iToHoGV9OuUNQu2E0BtuXnr0ttX3dOk6TyWVgKSwV9NXY8ceHk7jo/rP5ZuBSrXhKmGna4KFKtJ5J1bRFbvhLFusFqFfiLTleeGW8LsMzvFvaml8SZGhqePy0GRQHHs+WjyVxlCqEUrrPQHsBh7LbATqSiOUc40Mzo4oYR6SxdINqGH95xSZn4OkSzndg8Yn2IYRl5EEOh4D+osixx6O+cql0um9c/DfXPphSL46vpOiw2q3v6aYOf6QhjkSFYdj3qEzurM2HoU4hfQ6dcL0vEeeHl4WA08D+cDZ6yDJdp7OLVgllvGzRYrzMOPvO1i/UFY60GCqgmTQ7HX6D/nCeDX+eHc4UYVA6EB2qch6t+N+De5bFU/t3tr+r8GP1xiAiI+VpbIm+h/iIMxc290G6LU1aAhuNwhlU0fxhUuIVlVZbGXKxZmwsiok65vx/gIHDNFsbeO3hkbyVyZTk4GF1SsRQeRiTf3YfMLWRfpLxKDiw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5702.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(6133799003)(22082099003)(18002099003)(10067099003)(11063799006)(56012099006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VndnQ0VQYnVJbGdRWFBreGYzODdVL0grU1pNdTg1bFdJRmM3RFg4RE50MkQ2?=
 =?utf-8?B?Njg0dm0zZ2duVXRrZTdHU0ZYZ2FCd0tDK3UzWmJJVkhSOTZBdEtja3h0Y1Y0?=
 =?utf-8?B?d2FJeFdicFRpZDNIdGtTY0R1TTlVbWU1MFJZM2RRUWxoYXFIbG5MV1lrWmZl?=
 =?utf-8?B?b0lJOU9WU1k1VUR1L3hNWXhZUHQwam9GSUdMRThBanJVOHNnTUhyRGdrZ2pH?=
 =?utf-8?B?SzFMeFg0blhqRThsaHlHaTZ6blYvUWJFWmVLL25EY2oxUE9NbUNZOTN2RXhl?=
 =?utf-8?B?Umt1azBzc3c0TU1aU05QNUxxMVpRMFY3K1RYQkxuSDZLRHdueTd1bGlXa0tH?=
 =?utf-8?B?dmU4MFY4akRod0pMRlFLdjR4MjRhRkZEWnpNa0pIbG54bXFNQWJSWG5NSS9x?=
 =?utf-8?B?SEFZMWE4bzBMMi9yY041L25KVThpbDFIai8rOFo3NUt6WUMyQVM5aWRlZnRt?=
 =?utf-8?B?TzdHTkhrejZrd1VRWkRlcnpIaENXNXFOeG9YbnlEV2h6bnd4Sy9TVmhWblFH?=
 =?utf-8?B?U2xOa3h0cFhTYkFFd29JbDJRc0dzZlplYUZ4Z1lZL0pEOVZ6bE5oYnNyUlY5?=
 =?utf-8?B?Wm41b1NpMWpFOFRWZSs1Z3JVbjVNVkFRTnNnb0RhMjA5c1phQ0dXaFlxTlNN?=
 =?utf-8?B?YjBDWWFUY3FMMitINXRkUmQxUVpTL0J5QkF6MDBRM2dldUwzM3ZnckE1STBY?=
 =?utf-8?B?V3V0L2JqNkNkbngxUzU2aUpDTC9CcFE5ek1qejNKZ0VtenFxRTNmWnhyVnJU?=
 =?utf-8?B?RDBQTThVUTNhVHcwWk5zOGVSNjhIME5mb0JLOHFjZGRsYm8wait1MzVlTHVY?=
 =?utf-8?B?dFgwSTNpSU4vSk5BeTcxejY1VmZhV1BsUlV5ME9IREFFWjc3K2YyWFZhM3RE?=
 =?utf-8?B?WE5USVgvMllOQnhYTGs3WXZWZCtiWnMxWDlHR0xXMFl1MldLRTFiemU5TEpE?=
 =?utf-8?B?QzF2YjZHRHdmMDJxZ0JYN3NheFJYL1NFNW5IMDlLU2V3V3RFWmVBZ00ralQ0?=
 =?utf-8?B?MVc1M2JXVnFDMzhQTE1taUJ6TmFTUS9yYW1qVFVFdStsT0ZUSEkwTXU5TUdv?=
 =?utf-8?B?L0JneXR2N3Vlc3VoWDJFdjczT3VJOXpTUDBDRitvUFcwTWF0aVlqenlKMCtG?=
 =?utf-8?B?UFM0K2xvTldqcC9oT0xyT0lkWThqL0RjL2dZWVN0MDU2T2NNTzVGQ3JEbkg4?=
 =?utf-8?B?V1BYOWkybXVMZ1huNFlyWDlua0E2RUFKYWpRbTB3dWZEK3gyUjFrTjdOOFJ4?=
 =?utf-8?B?Q2tHbnVvKzN1MWp5OXpDeW9qOGo1SlJGQTA0eUgyL0VpZ0VYbC9XSS9nREhM?=
 =?utf-8?B?bVNDR280YjZkdnEzclY3WkRsbXJHZVdiejdyT1MvNnRrdHdXOHlrRlI3bjNp?=
 =?utf-8?B?cFEzMlhtUS9GNGVGUHo1QWhsSU5PNmtQZ2cvOTFGWEljcnR2M0ZkZW1BOUVo?=
 =?utf-8?B?UVFTdmpaaVpmYUVXanh4eEc2bGJWWmQxN1hva3o2dWV1dDZ3KzFhOGF6dXF5?=
 =?utf-8?B?dkpLemVXb01SL0ZqTUhhTTdjMHFUZGNrRmFzc2VCOVJtSlp2ZDBIdXJLZjdv?=
 =?utf-8?B?a0U5b3ZGVlZwRU1VcnJIR0JSdkNiSll4SzFCemM0Z0FzenVZVXdEcUM4bndl?=
 =?utf-8?B?c2tCR1E0RlZqWHJBUzFBdUpWMGsxaHRheFRpWnlnQnF3Z28wVzYyMGtUMFhu?=
 =?utf-8?B?VFArVGt4UHA2akRKYTdZZTZsMEhRb2xldE11bm50bmo3VkVHR2RGSUQ1RDhK?=
 =?utf-8?B?M1ZOa2FlNkhmOGJ0UjREM2FVQjJBRUg0K01nWVc2SFJ3WVBwbWlCU01TQlBK?=
 =?utf-8?B?Y2RMbkkyY0prZjI4MGlQSEN1cllDYUowakhRZ09OYWxHUnJNUTBUWVFrdCth?=
 =?utf-8?B?RFBqVlZRU0YrdkkrcjNpd1NjQXlXVUZ4V1dta3g2OTFtMGxsWnkyN3hZc3JS?=
 =?utf-8?B?ZjJvdzhvcWRGNm9oSHZFMXRheVhraWxyV3NsZ2pRMll1Zzc1ZlJ5bnJzenhu?=
 =?utf-8?B?Q09nQVVtek9rcmhlelBVdGFramZmTXBCeFEvTzgvbWZVMHNMM240NFREYytY?=
 =?utf-8?B?TUo2d1E5ZkpUWElZSHp5MDhReW9jbThGSThVczh5cXlOaGc0T250ZU40d1kr?=
 =?utf-8?B?c2NoOW5Cdm95TTAxTDJlRXZEcituMUFYVi9tSWxMakJVSzEvbDdmZGdCODlQ?=
 =?utf-8?B?TlZXY3pTa1VTYnVlb3h6WEtMeUpXS2hyaFdNbms2d1E1VG1GL3licjFsYU54?=
 =?utf-8?B?aHlBbHZVc2NDMFh5TkxxQk5aaGFFSm45SWJWRDVxZlc2NXV6MjZCZm9IeG03?=
 =?utf-8?B?TFJNcTBGeDJkZ2k4L2RrMnRPbjJpQUQ2bWkxMEtpZUZkZzhuN3RWUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E139776FEAF25B4CB8759E0CD8FF66A4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: bZyJIhLazT3+sZ1GwpVnjROOZfEs4LN9lbOIl1qX0LuBcjGIsHC+F7p+u9UjSgFaRDBwqUo0bA63G2WPqWsmFjjYvmceeY7/0WC0+fbvMjih46Z9BRnuNZ8cGbd1YZH0pQ1ziW1oBDnxXojSGJcyJXTQU9nF8Qrm2wX7ehrJTbaLF2DGcvNJhDOM7bYE/N2C2RMIX1AqaU/pJpPO1pzaPAzGWfyKp8F8yw0woGG1v9/iL9o0wWwGCjaSrsPjaVyGU/yWufoz2qa3iKwkQ+ClQHI3QvFXjiVTpzAv3IXgIcjfNCjQhIeAOCD52w78hRH+/g/Fwu2z2HAKBDvJLnaceg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5702.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18c2fa74-37b9-4b48-9aa2-08deec3daf86
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2026 00:18:01.4048
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3nem5WZei7cW7GmVnni+2fUwuOxUSWlKldGwSXVmDADW2LeD3Ys23uUb4W5P3p59r7OejXK4pZG1RmRSsfGClw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9372
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI2LTA3LTI3IGF0IDEwOjE3IC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBGcm9tOiBXZWltaW5nIFNoaSA8YmVzdHN3bmdzQGdtYWlsLmNvbT4NCj4gDQo+IENh
bmNlbCAoYW5kIGZsdXNoKSB0aGUgSS9PIEFQSUMncyBkZWxheWVkIEVPSSBoYW5kbGluZyB3b3Jr
IGR1cmluZyB0aGUNCj4gInByZSBWTSBkZXN0cm95IiBwaGFzZSwgYmVmb3JlIHZDUFVzIGFyZSBk
ZXN0cm95ZWQsIGFzIHByb2Nlc3NpbmcgdGhlIEVPSQ0KPiBicm9hZGNhc3Qgd2lsbCBpbmplY3Qg
YW5vdGhlciBJUlEgaWYgdGhlIGxpbmUgaXMgYXNzZXJ0ZWQsIGkuZS4gd2lsbCB0cnkNCj4gdG8g
ZGVsaXZlciBhbiBJUlEgdG8gdGhlIHRhcmdldCB2Q1BVKHMpLiAgQ2FuY2VsaW5nIHRoZSB3b3Jr
IGFmdGVyIHZDUFVzDQo+IGFyZSBkZXN0cm95ZWQgbGVhZHMgdG8gVUFGIGlmIHRoZSBkZWxheWVk
IHdvcmsgaXMgcHJvY2Vzc2VkIGFmdGVyIHZDUFVzIGFyZQ0KPiBkZXN0cm95ZWQuDQo+IA0KPiAg
IEJVRzogS0FTQU46IHNsYWItdXNlLWFmdGVyLWZyZWUgaW4gX19rdm1faXJxX2RlbGl2ZXJ5X3Rv
X2FwaWNfZmFzdCsweDliZi8weGEyMCBhcmNoL3g4Ni9rdm0vbGFwaWMuYzoxMjUwDQo+ICAgUmVh
ZCBvZiBzaXplIDggYXQgYWRkciBmZmZmODg4MDQ5OWFiZWEwIGJ5IHRhc2sga3dvcmtlci8xOjIv
MTIxOA0KPiANCj4gICBDUFU6IDEgVUlEOiAwIFBJRDogMTIxOCBDb21tOiBrd29ya2VyLzE6MiBO
b3QgdGFpbnRlZCA3LjEuMC1yYzcgIzUgUFJFRU1QVChsYXp5KQ0KPiAgIEhhcmR3YXJlIG5hbWU6
IFFFTVUgVWJ1bnR1IDI1LjEwIFBDIHYyIChpNDQwRlggKyBQSUlYLCArIDEwLjEgbWFjaGluZSwg
MTk5NiksIEJJT1MgMS4xNi4zLWRlYmlhbi0xLjE2LjMtMiAwNC8wMS8yMDE0DQo+ICAgV29ya3F1
ZXVlOiBldmVudHMga3ZtX2lvYXBpY19lb2lfaW5qZWN0X3dvcmsNCj4gICBDYWxsIFRyYWNlOg0K
PiAgICA8VEFTSz4NCj4gICAgX19kdW1wX3N0YWNrIGxpYi9kdW1wX3N0YWNrLmM6OTQNCj4gICAg
ZHVtcF9zdGFja19sdmwrMHgxMDAvMHgxOTAgbGliL2R1bXBfc3RhY2suYzoxMjANCj4gICAgcHJp
bnRfYWRkcmVzc19kZXNjcmlwdGlvbiBtbS9rYXNhbi9yZXBvcnQuYzozNzgNCj4gICAgcHJpbnRf
cmVwb3J0KzB4MTM5LzB4NGFkIG1tL2thc2FuL3JlcG9ydC5jOjQ4Mg0KPiAgICBrYXNhbl9yZXBv
cnQrMHhlNC8weDFkMCBtbS9rYXNhbi9yZXBvcnQuYzo1OTUNCj4gICAgX19rdm1faXJxX2RlbGl2
ZXJ5X3RvX2FwaWNfZmFzdCsweDliZi8weGEyMCBhcmNoL3g4Ni9rdm0vbGFwaWMuYzoxMjUwDQo+
ICAgIF9fa3ZtX2lycV9kZWxpdmVyeV90b19hcGljKzB4ZDgvMHhiZjAgYXJjaC94ODYva3ZtL2xh
cGljLmM6MTM0NQ0KPiAgICBrdm1faXJxX2RlbGl2ZXJ5X3RvX2FwaWMgYXJjaC94ODYva3ZtL2xh
cGljLmg6MTI5DQo+ICAgIGlvYXBpY19zZXJ2aWNlKzB4MzA4LzB4NTkwIGFyY2gveDg2L2t2bS9p
b2FwaWMuYzo0OTINCj4gICAga3ZtX2lvYXBpY19lb2lfaW5qZWN0X3dvcmsrMHgxM2MvMHgxOTAg
YXJjaC94ODYva3ZtL2lvYXBpYy5jOjUzMg0KPiAgICBwcm9jZXNzX29uZV93b3JrKzB4YTU5LzB4
MTlhMCBrZXJuZWwvd29ya3F1ZXVlLmM6MzMxNA0KPiAgICBwcm9jZXNzX3NjaGVkdWxlZF93b3Jr
cyBrZXJuZWwvd29ya3F1ZXVlLmM6MzM5Nw0KPiAgICB3b3JrZXJfdGhyZWFkKzB4NWViLzB4ZTUw
IGtlcm5lbC93b3JrcXVldWUuYzozNDc4DQo+ICAgIGt0aHJlYWQrMHgzNzAvMHg0NTAga2VybmVs
L2t0aHJlYWQuYzo0MzYNCj4gICAgcmV0X2Zyb21fZm9yaysweDcyYi8weGQzMCBhcmNoL3g4Ni9r
ZXJuZWwvcHJvY2Vzcy5jOjE1OA0KPiAgICByZXRfZnJvbV9mb3JrX2FzbSsweDFhLzB4MzAgYXJj
aC94ODYvZW50cnkvZW50cnlfNjQuUzoyNDUNCj4gICAgPC9UQVNLPg0KPiANCj4gTm90ZSwgdGhl
IFZNIGlzIHVucmVhY2hhYmxlIG9uY2Uga3ZtX2Rlc3Ryb3lfdm0oKSBzdGFydHMsIGFuZCBzY2hl
ZHVsaW5nDQo+IG5ldyB3b3JrIHZpYSBrdm1faW9hcGljX3NlbmRfZW9pKCkgY2FuIG9ubHkgYmUg
ZG9uZSB2aWEgS1ZNX1JVTiwgaS5lLg0KPiByZXF1aXJlcyBhIGxpdmUgdkNQVS4NCj4gDQo+IEFs
dGVybmF0aXZlbHksIEtWTSBjb3VsZCBzaW1wbHkgZGVzdHJveSB0aGUgSS9PIEFQSUMgZHVyaW5n
IHRoZSAicHJlIiBwaGFzZQ0KPiBvZiBWTSBkZXN0cnVjdGlvbiwgYnV0IHRoYXQgZ2V0cyBtb3Jl
IHRoYW4gYSBiaXQgc2tldGNoeSBhcyBLVk0gZXhwZWN0cyB0aGUNCj4gSS9PIEFQSUMgdG8gZXhp
c3QgaWYgaW9hcGljX2luX2tlcm5lbCgpIGlzIHRydWUsIGFuZCBuZXN0ZWQgdmlydHVhbGl6YXRp
b24NCj4gaW4gcGFydGljdWxhciBoYXMgYSBiYWQgaGFiaXQgb2YgdG91Y2hpbmcgVk0tc2NvcGUg
c3RhdGUgZHVyaW5nIHZDUFUNCj4gZGVzdHJ1Y3Rpb24uICBFLmcuIGF0dGVtcHRpbmcgdG8gZnJl
ZSB0aGUgUElDIGR1cmluZyB0aGUgcHJlIHBoYXNlIHdvdWxkDQo+IGxlYWQgdG8gYSBOVUxMIHBv
aW50ZXIgZGVyZWZlcmVuY2UgaW4ga3ZtX2NwdV9oYXNfZXh0aW50KCksIGFuZCBpdCdzIG5vdA0K
PiBoYXJkIHRvIGltYWdpbmUgdGhlIEkvTyBBUElDIGhhdmluZyBhIHNpbWlsYXIgZmxhdy4NCj4g
DQo+IEZpeGVzOiAxN2JjZDcxNDQyNjMgKCJLVk06IHg4NjogRnJlZSB2Q1BVcyBiZWZvcmUgZnJl
ZWluZyBWTSBzdGF0ZSIpDQo+IFJlcG9ydGVkLWJ5OiA8emRpLWRpc2Nsb3N1cmVzQHRyZW5kbWlj
cm8uY29tPg0KPiBSZXBvcnRlZC1ieTogWmhvbmcgV2FuZyA8d2FuZ3pob25nLmMwc3M0Y2tAYnl0
ZWRhbmNlLmNvbT4NCj4gUmVwb3J0ZWQtYnk6IFh1YW5xaW5nIFNoaSA8c2hpeHVhbnFpbmcuMTFA
Ynl0ZWRhbmNlLmNvbT4NCj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gU2lnbmVkLW9m
Zi1ieTogV2VpbWluZyBTaGkgPGJlc3Rzd25nc0BnbWFpbC5jb20+DQo+IENvLWRldmVsb3BlZC1i
eTogU2VhbiBDaHJpc3RvcGhlcnNvbiA8c2VhbmpjQGdvb2dsZS5jb20+DQo+IFNpZ25lZC1vZmYt
Ynk6IFNlYW4gQ2hyaXN0b3BoZXJzb24gPHNlYW5qY0Bnb29nbGUuY29tPg0KPiANCg0KUmV2aWV3
ZWQtYnk6IEthaSBIdWFuZyA8a2FpLmh1YW5nQGludGVsLmNvbT4NCg==
