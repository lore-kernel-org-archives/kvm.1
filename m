Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B166385D8B;
	Wed,  8 Jul 2026 23:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783552898; cv=fail; b=icnDsgAozonKy5N+rpmA0LycCFiWL7yo+WHCFLU/1B2gUM2bDrDJNv2oibE4engLIvA7BDfWV74OF5DyWEd0S2u+lS6TNqbAO7uplHTbJh5JC7gx3tNfxHzGAnwAVqWEOcyDNaTPWyhyUVw18GJdHSagtNVwx9bu2W1vfqwVfcs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783552898; c=relaxed/simple;
	bh=Z40Lb29kzHKQmFSP/VggzSymWIsbeSDEY13Ykayc6PA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Fbq4ypFWe1DZR5REsTtRUG7WNv8+2dHqMDp9R2d3sry0t/33CrwA7kblODmlW8xligarzEsUoLwxM/hQK+YzOvcRFM07snF7si9VSAeAa2IzI98wxXVZxVjzKKYcGCHagdyY+//rxJjiZ1GCgPQqPEt6LMZpxkUMYTZovYDwmhA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BOht1oSS; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BOht1oSS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783552895; x=1815088895;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Z40Lb29kzHKQmFSP/VggzSymWIsbeSDEY13Ykayc6PA=;
  b=BOht1oSSx10caC4ClttitGVoSHg2VWxtpZzP9Fr/+32rQfiDjGE0EREt
   PyMWcyWddWS6PqkUyEJNZUcISuBCwnQYA6c/arLp3b4ryzZOT6bl5g7Qv
   2iiDNR9ZJyhPPFww6uPjzP00rhudFlpSf3doRJy8zUj0W3TvLyQZTJMHF
   vbufUSi9wRrXq289V5cZ0IxP9LF5uIFCJ2uxzO4HgciQgxIUukgrwWVbH
   sxIgLNa8cV8V1XJfmHaqMlZohNU7l7ZOWrqzKwPadWIiFMPVp3UfQKc7R
   cIR9Tg/iCfJ8ctza/qwKfQWibKgdrvhfYkU5b/vgrK7+o5/dg05hlbKRW
   Q==;
X-CSE-ConnectionGUID: VB0/MtYdQoufHYaLi4gj+g==
X-CSE-MsgGUID: G38By1H4RYS1HaDo0Tb/DQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="94584266"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="94584266"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 16:21:34 -0700
X-CSE-ConnectionGUID: U9h8YRqnRsagtJ3ebBsBwA==
X-CSE-MsgGUID: Qa3i/Y+SQ/KJZpAdOvJ9Zg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="258716135"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 16:21:34 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 8 Jul 2026 16:21:34 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 8 Jul 2026 16:21:34 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.39) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 8 Jul 2026 16:21:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I4/Ez6n3FWroAJLH65wbe3W/qvI9kgz7xfDJLBGM7ipdi9/6Gi0s3RxOk5REFrhrE9lbiw8O/kkG2K8otq0JWMCdk9bTZLv1Def/hqdB2EF0nUz0jqdCn8w8LJNCbVsHus8w5wWyVeo8GbCsqSWKostJpkromCMrMsF+EQ+o+2UEUeCRIAcN5SYluGm+ZLJO1xwKDThOOMsY82QXrJWT12PGpIWoOpcLTTEbSKixtWjpXbp8ULKi1OZ1JiR6mQw6SHGmRefG73ji9fa8p6cdK1UdqZv5HrdOB46+kQbGKkAJ3uE7LnIA5R3gfmJ5+7xzgYMRhjpr/3yIjMRD4L561Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z40Lb29kzHKQmFSP/VggzSymWIsbeSDEY13Ykayc6PA=;
 b=pNnJJZvf2pZ44odh5LiX5W4mtDAvaq/O4/nTeVX3aq5mByBhM7nZ4iwkFo1FMxag9XTJTRVmczoeIkU11l433WKpfPlBQFCA+TPa4Jl9v8vAby92tDJ0fAfXFq0FsCXYBxLhLMWnpj0y7tzPsXbgljMap2SCrVM99JFUize1xWU96+4+yVz0pgeOL8q8/34PhLVcTIGPw4WQyeMpaLJ/J+NWG52Rl2GkJiEtQ0iRLFSZ8GFBrO66Xx4Duuc8lpWgl5qTdjZTYsqFBTxqmqox1GreEh+SVbtPidAWbKx3Sk0EBoy4dFTHhK6xuaonj3+5V/J1afHSn2jc5x8SnbWuEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB6776.namprd11.prod.outlook.com (2603:10b6:806:263::21)
 by IA4PR11MB9036.namprd11.prod.outlook.com (2603:10b6:208:565::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 8 Jul 2026
 23:21:30 +0000
Received: from SN7PR11MB6776.namprd11.prod.outlook.com
 ([fe80::9c32:5b6b:3a48:dfa1]) by SN7PR11MB6776.namprd11.prod.outlook.com
 ([fe80::9c32:5b6b:3a48:dfa1%6]) with mapi id 15.21.0181.008; Wed, 8 Jul 2026
 23:21:29 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Huang, Kai" <kai.huang@intel.com>, "Hansen,
 Dave" <dave.hansen@intel.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>,
	"kas@kernel.org" <kas@kernel.org>, "seanjc@google.com" <seanjc@google.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "nik.borisov@suse.com"
	<nik.borisov@suse.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "Annapurve,
 Vishal" <vannapurve@google.com>, "tglx@kernel.org" <tglx@kernel.org>, "Mehta,
 Sohil" <sohil.mehta@intel.com>, "bp@alien8.de" <bp@alien8.de>, "Gao, Chao"
	<chao.gao@intel.com>, "x86@kernel.org" <x86@kernel.org>
CC: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v6 04/11] x86/virt/tdx: Allocate ref counts for Dynamic
 PAMT memory
Thread-Topic: [PATCH v6 04/11] x86/virt/tdx: Allocate ref counts for Dynamic
 PAMT memory
Thread-Index: AQHc7LhU1bCbzezxb02fxsgzvwPwJLZkXQUAgAAqhYA=
Date: Wed, 8 Jul 2026 23:21:29 +0000
Message-ID: <a3a878fe02496be580443e338855e6aeda65d710.camel@intel.com>
References: <20260526023515.288829-1-rick.p.edgecombe@intel.com>
	 <20260526023515.288829-5-rick.p.edgecombe@intel.com>
	 <6ab50a8c-d502-4d51-b037-3af6c4b4083e@intel.com>
In-Reply-To: <6ab50a8c-d502-4d51-b037-3af6c4b4083e@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB6776:EE_|IA4PR11MB9036:EE_
x-ms-office365-filtering-correlation-id: fd7a0da2-f8fd-49bd-f5ad-08dedd47a3f5
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|921020|22082099003|18002099003|38070700021|6133799003|11063799006|56012099006|4143699003;
x-microsoft-antispam-message-info: RnMK+DDj56+tD9YkTWMcRMYQKSHI1NRmAlfKHyQl0g/IfirHA5odro80CEVEZnCr3cShzql+bqIFMeUmtNybAgM5z+5qdELCSx8wbvliP5sSF0eQrpqqF1DFxJWbLY8TdtEl5sLmTraGCGpW/yYTpWL4cvq7Zp5hr5xnIMczjKTqBN3ve3knO+YuRg060494ZfOoESwXegO7HlI1Iav1CvY0UBk1b3hMuhnqWRNIHpJ/+c5JBUHonIQ9rwoAoTM+7/+qs+nOr5//Gd25hICvldcXuZU3OosbXMMcqWntZr/0Rhi3BECALC2dfvYy8K4StHbXsfj/gXW7G27bSFalwNp3IOxlwzBCxPeJAyDeDSZfKIqO/Vn1ZD6xBrEIQbLeoTTN7w6QSVN9whpQfvyAtlczpOiRubsfKWV6L5XAffWUEPQfgzVcmp4HzprvpwInlHpR1eM+Zaxkym/Eziqn2Ld7eyHEkhHqv5KcfLWQ+AbhcinMj3PQkY2P6CBbV2o2tqaIFJoHO+8r57BOX4fP9377MGd6lJ6Ouqea4EAdarskXyyUJ1HexzqAJb3aGDqGGn+T5Z83OKDJo6M2fIOQitOMDM+8g5GlJKQr2IrgcJACuauZSzAsmcE9S8uoX56JXiEytbhnx25UOG69gwFyLzpTSX9oYeAt7PHJ7DBM6p/WLbq/+AASBs2rzsi91D3YktH11+NM+adAlHnqoEEJErl+0MAkZ5BP8JOZlVVneVQQYtIzBKcA2ODt2SWsdjrO
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB6776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(921020)(22082099003)(18002099003)(38070700021)(6133799003)(11063799006)(56012099006)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VVlCbjhiRFAwN1JDdlRxWXhUSVA5L2p6Ty8zeUkrM2JrY214RkNxZWtBSGVn?=
 =?utf-8?B?WGlEZEdsTTVCMFU1V3hoMWV0ZkRjV0d5K0pWcTFqa3l0cmF1aG9lVnJmempT?=
 =?utf-8?B?ZXVXOUYyenhRUUsxOW9yY2trRWtmTTE0ZkpaWitrcWxTNkRxaGFUeWllZWN3?=
 =?utf-8?B?UXZxcVhKdEZ2S0ZXRTFrS1ZXV0pvb21JNlhNZGQ4TG9pd3MwN3gwMlpGcDV0?=
 =?utf-8?B?YVVzbENWeTB0Tk9rRDEvdlY4VVU4Nkdia0JYSjNZOVh1WlNPM01NbU56ZmZI?=
 =?utf-8?B?bWpKSW4zeXRlTXNiRk83Nk1Mc29pM0wxMlNkOGxUSmVCN0Y0eXRWaTgzUits?=
 =?utf-8?B?OEpKbDhKVGI2WHp2OEpORVhTdlpKNXN5cWFmTnQ0ODFzMXpBYlZIT0hJdlhh?=
 =?utf-8?B?a253TzFSSlhxNGtmMXBhZ0wrZ0d1SzB2MXVFRE4yQ2NSQWkyR0NVK0Rnd0xy?=
 =?utf-8?B?UEpJYnV0SXh0ZW80OEIvbjdHbXV4Zks0Q0NSQzdlaW5xSmlkVmxsSllRVS9S?=
 =?utf-8?B?YkI1L3BhN09idWQ4WlR5S01hYmhuNldybHhxMmd6QjFYV1hVS1dGOWRBSk1R?=
 =?utf-8?B?MzhEdnU0bUIvSWZVTldSVE1RRE1xUExSRUpYdmM3VEFsTW9XaCtOdVNBY1pw?=
 =?utf-8?B?cFdMQllmRFBZYjg5djV5aEQyZEErWFJRaHk4Y3BlOEdROG1sekZDVjNnRllL?=
 =?utf-8?B?UDVIKy91WWwxajhsWU5idE9VREpac3NhR2FKbnFkRHR0WjN4WmZlSTl5UU5t?=
 =?utf-8?B?S2M4U0pxbjFwOWE2Q21rdWMzaUZleTk2U1RLdlNkeklWTEs3c29pMFEveXVE?=
 =?utf-8?B?YUJBQ1ZZVENVRkpHTTdhMTcrTzhZYXN5ckZDT1JxQmx0ZlJNZDlEaUZyYnUx?=
 =?utf-8?B?WloyVTJ4MWJxNGFWQWh3bnFGQUpodEMvQ3VxSmNMSm9zRHdlaTErbkNXZGgx?=
 =?utf-8?B?VWV0S2M3SDlXRVJ6S1oxc2tsTHJuWExOVUNtRTlqazhhNWxZM3pwckt6Tlhm?=
 =?utf-8?B?NVBYQ0srU3hBQkg4S081ME53TDF4SkcwV0JyN0J4ZS90RDJoYUx5UmhEOUN2?=
 =?utf-8?B?QkcxWjkvOXRXUzVWdE04RkIySUs3d211TFlXUlNDMjJmTGx6NXZtMjZTREFq?=
 =?utf-8?B?NTFRbCsvVnpyTmFSQkRKSE9nNFpCOFRVK3BvTm1FL0ZuRUpvYU1CM1pqOXo1?=
 =?utf-8?B?cG1OSy9iMS9QMnpRNEl1c1ZhRStkZmtQQ3lWcVVEcjg2WTVDT3ptU2I2SG4z?=
 =?utf-8?B?ZVMyUTVyUWJCcEVHYjREK3Zpa2FPVi8rRTJ3SGFhU2pMNHR1T21FY0JRMitk?=
 =?utf-8?B?bnhDYytpd0lzOUk3T0lVT3JLYWFOejI4RERLV0svdUw0S1VuZXMyQ2FzTXYv?=
 =?utf-8?B?WFNBdGh3RWlGYjRUZmFYR2lJNDQ1ZjVsZHByVkVMdVBmVXJ0dUJVbXA2b2RZ?=
 =?utf-8?B?ckdxQVBaemU2d0tOM01YbmZRclpYRHJZVVc3SlNDZFJHWjhsNXhyWGp0cnEx?=
 =?utf-8?B?cEZRR2xaZGN1cWFZTVBuc2U2ajhGd2ZER0pDblJmV0M1S2xZcWlQc1VYcGs1?=
 =?utf-8?B?R3B5eXh0S01IUmxtVkJid0Mxb0R2c3phK21yWndIakl4NTN6WTd4b1k1Qjdh?=
 =?utf-8?B?MDdCUlhnOVM4MG5RMGpiL3hJSGdmd2xkdTJQVkJ2RFBqMUI2S3FKaSs0cnh5?=
 =?utf-8?B?UTRtRFVRS09iYUVTamIxdVpsSzJLZkx4RVdQUTlFMW93QlZQT2U4WG02eWE0?=
 =?utf-8?B?TW1VTlZTLzRHdm9vcFJYQ3Y0ODJDemFhSE43eGRrdzhYUEJzZHc2aG9VU2d3?=
 =?utf-8?B?amxraWgxVDl2eHBoZG0zT2YrRG1xcnZPYkJUVk9INTcyKzNCTU5YK0VjbmJD?=
 =?utf-8?B?d25DUlU0MFAxaER0dVd2OGFwS3oyODBVeHZRVGhmTmtaNTFBb3hMaktxRkpP?=
 =?utf-8?B?bG9aTGRmYzhzNS95aDI5TGt4OW93c0thbTdRcE9SNE52MkliZUtDTCtxVnBa?=
 =?utf-8?B?VHRxY0dZOVE5NVpHbHI5Y2tUYXg3M1ZHeXNZSG1wNldML3RKM3lpY0xaNk9Q?=
 =?utf-8?B?aDNqd2VxY2ZZOHdGc0J2M1lld0ZyaURudlNxSm5XMndhZGJDTmZWc21mRzkz?=
 =?utf-8?B?WTBVM295d2VsWkVva0lEUXF6bUZmdTZGNHlIS1pNWVJaUEsxblVVbWNheklG?=
 =?utf-8?B?cTRQakh6NnpHZXJzL2hNRWNVSWNvU2dLQVZKeU5YcXI3cHpxMjFmNXFMVXh5?=
 =?utf-8?B?WkpjdmVlV1R5VStLWCtHZi9YTVRLWitMOGc2anl1WjVpMmF4OStSQldVZW9x?=
 =?utf-8?B?dUFwWm50ekFiYncyWUxDTU42Tlc5Mng2Q1NWa3pwaTFLS2V0UU1MYU1sUkRB?=
 =?utf-8?Q?fIyNRfGp2BQev2RU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8B2A56B84752D543847A9023DBD061F6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: BxjXvrhlFdgCKHAODbd66BnBCC9n71q3OZN/qTBdPATKAp60ofEKgBJYrCpuPt+2nvw18exASFFuY00HYuPZYHeyATxqtbQg0hLEt5I6EEPV97sYyXukaTIxuWGg/Scfsl1BGP2KSbQwuV0pF1U0CrZht/fxHUjDaGswLnUqTAecMxEts7bhaVapmMrCgBmCqbbOEGIaGoshTjz6NDoKveJhgmy3OF/xfod86L4WtpqdN5AgsKT1fgGufmyfHz9W9b1FCYW2/+Ga9zsUT8LcnKqD82KnyHLpCHZacz7cp9RDTMJpK258BOcD24q+bU92ckGaEsX28SXIulfP1YyO0w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB6776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd7a0da2-f8fd-49bd-f5ad-08dedd47a3f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2026 23:21:29.6374
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B5DEl2PIKAya9LixQzsrD4a10qAg4yI+ZsfirCeX8PXQBcQiHqMP8Y7TjDF+R6CZIiT+tmUnHyKYFRcbdfzIPdzfoLV1bO0cP5nbA7eHEnw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9036
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTA3LTA4IGF0IDEzOjQ5IC0wNzAwLCBTb2hpbCBNZWh0YSB3cm90ZToNCj4g
T24gNS8yNS8yMDI2IDc6MzUgUE0sIFJpY2sgRWRnZWNvbWJlIHdyb3RlOg0KPiA+IEZyb206ICJL
aXJpbGwgQS4gU2h1dGVtb3YiIDxraXJpbGwuc2h1dGVtb3ZAbGludXguaW50ZWwuY29tPg0KPiA+
IA0KPiA+IFRoZSBQQU1UIG1lbW9yeSBob2xkcyBtZXRhZGF0YSBmb3IgYWxsIHBvc3NpYmxlIFRE
WCBwcm90ZWN0ZWQgbWVtb3J5LiBFYWNoDQo+ID4gcGh5c2ljYWwgYWRkcmVzcyByYW5nZSBpcyBj
b3ZlcmVkIGJ5IFBBTVQgZW50cmllcyBhdCB0aHJlZSBsZXZlbHMgKDFHQiwNCj4gPiAyTUIsIDRL
QikuIFdpdGggRHluYW1pYyBQQU1ULCB0aGUgNEtCIHJhbmdlIG9mIFBBTVQgaXMgYWxsb2NhdGVk
IG9uDQo+ID4gZGVtYW5kLiBUaGUga2VybmVsIHN1cHBsaWVzIHRoZSBURFggbW9kdWxlIHdpdGgg
cGFnZSBwYWlycyB0byBzdG9yZSB0aGUNCj4gPiA0S0IgZW50cmllcywgd2hpY2ggY292ZXIgMk1C
IG9mIGhvc3QgcGh5c2ljYWwgbWVtb3J5LiBUaGUga2VybmVsIG11c3QNCj4gPiBwcm92aWRlIHRo
aXMgcGFnZSBwYWlyIGJlZm9yZSB1c2luZyBwYWdlcyBmcm9tIHRoZSByYW5nZSBmb3IgVERYLiBJ
ZiB0aGlzDQo+ID4gaXMgbm90IGRvbmUsIFNFQU1DQUxMcyB0aGF0IGdpdmUgdGhlIHBhZ2VzIHRv
IGJlIHByb3RlY3RlZCBieSB0aGUgVERYIG1vZHVsZQ0KPiA+IHdpbGwgZmFpbC4NCj4gPiANCj4g
PiBBbGxvY2F0ZSByZWZlcmVuY2UgY291bnRlcnMgZm9yIGV2ZXJ5IDJNQiByYW5nZSB0byB0cmFj
ayBURFggbWVtb3J5IHVzYWdlLg0KPiA+IFRoaXMgY2FuIGJlIHVzZWQgdG8gaGFuZGxlIGNvbmN1
cnJlbnQgZ2V0L3B1dCBjYWxsZXJzLCBpbiBvcmRlciB0bw0KPiA+IGFjY3VyYXRlbHkgZGV0ZXJt
aW5lIHdoZW4gdGhlIGR5bmFtaWMgNEtCIGxldmVsIG9mIER5bmFtaWMgUEFNVCBuZWVkcyB0bw0K
PiA+IGJlIGFsbG9jYXRlZCBhbmQgd2hlbiBpdCBjYW4gYmUgZnJlZWQuDQo+ID4gDQo+ID4gVGhp
cyBhbGxvY2F0aW9uIHdpbGwgY3VycmVudGx5IGNvbnN1bWUgMiBNQiBmb3IgZXZlcnkgMSBUQiBv
ZiBhZGRyZXNzDQo+ID4gc3BhY2UgZnJvbSAwIHRvIG1heF9wZm4uIFRoZSBhbGxvY2F0aW9uIHNp
emUgd2lsbCBkZXBlbmQgb24gaG93IHRoZSBSQU0gaXMNCj4gPiBwaHlzaWNhbGx5IGxhaWQgb3V0
LiBJbiBhIHdvcnN0IGNhc2Ugc2NlbmFyaW8gd2hlcmUgdGhlIGVudGlyZSA1Mi1iaXQNCj4gPiBh
ZGRyZXNzIHNwYWNlIGlzIGNvdmVyZWQgdGhpcyB3b3VsZCBiZSA4R0IuIFRoZW4gdGhlIERQQU1U
IHJlZmNvdW50DQo+ID4gYWxsb2NhdGlvbnMgY291bGQgaHlwb3RoZXRpY2FsbHkgY2F1c2UgdGhl
IHNhdmluZ3MgZnJvbSBEeW5hbWljIFBBTVQgdG8gZ28NCj4gPiBuZWdhdGl2ZSBvbiBleG90aWMg
cGxhdGZvcm1zIHdpdGggc3BhcnNlLCBzbWFsbCBhbW91bnRzIG9mIG1lbW9yeS4NCj4gPiANCj4g
DQo+IC4uLg0KPiANCj4gPiArLyoNCj4gPiArICogT24gYSBtYWNoaW5lIHdpdGggRHluYW1pYyBQ
QU1ULCB0aGUga2VybmVsIG1haW50YWlucyBhIHJlZmVyZW5jZSBjb3VudGVyDQo+ID4gKyAqIGZv
ciBldmVyeSAyTSByYW5nZS4gDQo+IA0KPiBDb21taXQgbG9nIHNheXMgZXZlcnkgMk1CIHJhbmdl
Lg0KDQpZZWEsIEknbGwgdW5pZnkgdG8gTUIsIFRCLCBLQi4NCg0KPiANCj4gVGhlIGNvdW50ZXIg
aW5kaWNhdGVzIGhvdyBtYW55IHVzZXJzIHRoZXJlIGFyZSBmb3INCj4gPiArICogdGhlIFBBTVQg
bWVtb3J5IG9mIHRoZSAyTSByYW5nZS4gVGhlIGtlcm5lbCBhbGxvY2F0ZXMgUEFNVCByZWZjb3Vu
dHMgYXQNCj4gPiArICogaW5pdGlhbGl6YXRpb24uDQo+ID4gKyAqLw0KPiA+ICtzdGF0aWMgYXRv
bWljX3QgKnBhbXRfcmVmY291bnRzOw0KPiA+ICsNCj4gPiAgLyogQWxsIFREWC11c2FibGUgbWVt
b3J5IHJlZ2lvbnMuICBQcm90ZWN0ZWQgYnkgbWVtX2hvdHBsdWdfbG9jay4gKi8NCj4gPiAgc3Rh
dGljIExJU1RfSEVBRCh0ZHhfbWVtbGlzdCk7DQo+ID4gIA0KPiA+IEBAIC0yNTQsNiArMjYzLDQz
IEBAIHN0YXRpYyBzdHJ1Y3Qgc3lzY29yZSB0ZHhfc3lzY29yZSA9IHsNCj4gPiAgCS5vcHMgPSAm
dGR4X3N5c2NvcmVfb3BzLA0KPiA+ICB9Ow0KPiA+ICANCj4gPiArLyoNCj4gPiArICogQWxsb2Nh
dGUgUEFNVCByZWZlcmVuY2UgY291bnRlcnMgZm9yIGFsbCBwaHlzaWNhbCBtZW1vcnkuDQo+ID4g
KyAqDQo+ID4gKyAqIEl0IGNvbnN1bWVzIDJNaUIgZm9yIGV2ZXJ5IDFUaUIgb2YgcGh5c2ljYWwg
bWVtb3J5Lg0KPiANCj4gQ29tbWl0IGxvZyBzYXlzIDJNQiBhbmQgMVRCLiBJIHdvdWxkIG1ha2Ug
Ym90aCBjb25zaXN0ZW50Lg0KDQpZZWEsIGRpZmZlcmVudCBhdXRob3JzIGZvciBzb21lIG9mIHRo
aXMgdGV4dC4NCg0KPiANCj4gPiArICovDQo+ID4gK3N0YXRpYyBpbnQgaW5pdF9wYW10X3JlZmNv
dW50cyh2b2lkKQ0KPiA+ICt7DQo+ID4gKwlzaXplX3Qgc2l6ZSA9IERJVl9ST1VORF9VUChtYXhf
cGZuLCBQVFJTX1BFUl9QVEUpICogc2l6ZW9mKCpwYW10X3JlZmNvdW50cyk7DQo+ID4gKw0KPiA+
ICsJaWYgKCF0ZHhfc3VwcG9ydHNfZHluYW1pY19wYW10KCZ0ZHhfc3lzaW5mbykpDQo+ID4gKwkJ
cmV0dXJuIDA7DQo+ID4gKw0KPiA+ICsJcGFtdF9yZWZjb3VudHMgPSBfX3ZtYWxsb2Moc2l6ZSwg
R0ZQX0tFUk5FTCB8IF9fR0ZQX1pFUk8pOw0KPiANCj4gdnphbGxvYygpPw0KDQpUb3RhbGx5LiAN
Cg0KPiANCj4gPiArCWlmICghcGFtdF9yZWZjb3VudHMpDQo+ID4gKwkJcmV0dXJuIC1FTk9NRU07
DQo+ID4gKw0KPiA+ICsJcmV0dXJuIDA7DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyB2b2lk
IGZyZWVfcGFtdF9yZWZjb3VudHModm9pZCkNCj4gPiArew0KPiA+ICsJaWYgKCF0ZHhfc3VwcG9y
dHNfZHluYW1pY19wYW10KCZ0ZHhfc3lzaW5mbykpDQo+ID4gKwkJcmV0dXJuOw0KPiA+ICsNCj4g
PiArCXZmcmVlKHBhbXRfcmVmY291bnRzKTsNCj4gPiArCXBhbXRfcmVmY291bnRzID0gTlVMTDsN
Cj4gPiArfQ0KPiA+ICsNCj4gPiArLyogRmluZCBQQU1UIHJlZmNvdW50IGZvciBhIGdpdmVuIHBo
eXNpY2FsIGFkZHJlc3MgKi8NCj4gDQo+IFRoaXMgY29tbWVudCBpcyBwcm9iYWJseSBub3QgdGhh
dCB1c2VmdWwuIFRoZSBmdW5jdGlvbiBuYW1lIGlzDQo+IGRlc2NyaXB0aXZlIGJ5IGl0c2VsZi4N
Cg0KSSdsbCBkZWxldGUgaXQuDQoNCj4gDQo+ID4gK3N0YXRpYyBhdG9taWNfdCAqIF9fbWF5YmVf
dW51c2VkIHRkeF9maW5kX3BhbXRfcmVmY291bnQodW5zaWduZWQgbG9uZyBwZm4pDQo+ID4gK3sN
Cj4gPiArCS8qIEZpbmQgd2hpY2ggUE1EIGEgUEZOIGlzIGluLiAqLw0KPiA+ICsJdW5zaWduZWQg
bG9uZyBpbmRleCA9IHBmbiA+PiAoUE1EX1NISUZUIC0gUEFHRV9TSElGVCk7DQo+ID4gKw0KPiA+
ICsJcmV0dXJuICZwYW10X3JlZmNvdW50c1tpbmRleF07DQo+ID4gK30NCj4gPiArDQoNCg==
