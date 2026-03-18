Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA8B9460;
	Wed, 18 Mar 2026 21:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773870328; cv=fail; b=AYIoGE/K8yADP3DXmD9kw/SqPGEyVpY4wPUj6fqb/G7EYJX/rJLv0noQqrDlaFdyPrl5fYbHZi/eADS+yGlCBF+7IDd1TbYDS/BgeRI/mld+hbNW9GWKWVvA5aInlibb5ByYepPslBR30PQ2S8bWirE7MA1gqnwYwvSz6pV+Q8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773870328; c=relaxed/simple;
	bh=ABVYUi/g13jCwiOcXXF3vCUYX0/RX5LPlk0/13wrUgA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MkOs2XAlq1f46t/NMiNgz0MzBFLK6/AtwOTuvuNr/RYaaBMhPtzI2OGiYJMcN/BWjJRl/NxXTyK+d78ptOHa/ejUz+Hyjue4rrBdNyxWhAP/Vx67f2slDwZrEyCrqcY8DfYeLDaWWcLoN3vmdkDYzKIyaydfWyZOlsO26CTWnE0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DiJLoQwn; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DiJLoQwn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773870325; x=1805406325;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ABVYUi/g13jCwiOcXXF3vCUYX0/RX5LPlk0/13wrUgA=;
  b=DiJLoQwnAT43KOewfg3KPAZu4ukTBVrLB2jgA7+B+s5X6QvTreeItSLx
   FVNMRb3lwsX+A00xnrX+ME6XbdkJWbOrx0qGgAknPuSLMyM98kh2vHWGt
   qmp/89IrSdIlJFWxYql1uvCQbHx0zGb6TANOcBu3zNVatlHtj0uFI3Izc
   XbCF8XTo5vZqDGRHUvNtY2XkGG4zpuE542t5bUrTeHshhwCs2RsA+bc5a
   8StoLPA4QlxORJJTEcJs9WG+kB41SkjbOdOEqN06ZGGywXxZ+L/u4RFKt
   SErmvc+Gfkh8JaG4IRxlQGlHbiwybn5Z0RveX822nikGoCPvVMxU2I72l
   w==;
X-CSE-ConnectionGUID: BIBy0QkoSje/wB7i/y7Ngw==
X-CSE-MsgGUID: Zk14C4hLRRSptFhQVTZjDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="92321205"
X-IronPort-AV: E=Sophos;i="6.23,128,1770624000"; 
   d="scan'208";a="92321205"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 14:45:23 -0700
X-CSE-ConnectionGUID: mxZOy3BoTlOrk4bu5IxuJw==
X-CSE-MsgGUID: Edi9ymmrSEiq7EaFbrRdIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,128,1770624000"; 
   d="scan'208";a="219764061"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 14:45:23 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 14:45:22 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 18 Mar 2026 14:45:22 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.43) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 14:45:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iMzQ/ehnS3H+DjpSWFA1IAIeYT3BTZ4236FixtKU/x8nHYvFfkbfBEQ0vrGYHupKQtmXn33bUQgq6qMezjRKGuhVLQpkVyNKjR5ro7BqinFp5vaKFgcHqOhkXYiUtU7Lh/VHd1XcZfyT4K/dqSqOdzVbVphAR36/x42zGDZ0+De5oOyMQBVXhckTaHDe7lRRThXg9ytAV2YsJKhTaezhmjgUv6kZ6DOOKH9KacjMO7h9S5XSRhiJIrHiVe8hdTcxZbwog1jOYPgVkYaEtXfSbWRzRjvyqzGJ3S/HBaZO4h5HE25ptzpvCIwKylGLCdbJ38FzDq+AyDN86GX1MS1UUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ABVYUi/g13jCwiOcXXF3vCUYX0/RX5LPlk0/13wrUgA=;
 b=Tu+kdhnzS8HxOoxACIQsaPjzwBHaM4NY9E4lhXpG91Heb3yNnxvZWQcanqZqmUdlMETwo64GgIxa85uMoMK0YcBJUSsnvKMB/ripJxtD0mnx5edzvY96ly/LiDWDwyN9XRamnsQOEl0SAjM0fQW/bYCpUjDS6XPMiUB5ycBZ0o4rdV1ScNAFrxJxnNT/6REkGnRYtvo4CO39oVTgFP/C7H0s9eIZY9cz90iyRCrkoWy+Hl/pYS0l5JhhQLlY1iypjTvlkMecUgVHJQtuubQSNm30Jgte3Y1eyww80N6QuJx3BlRBtuECCAHogRuqhcZjgLTPIisqj6cDuUV1kSwX1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 SA1PR11MB6807.namprd11.prod.outlook.com (2603:10b6:806:24e::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19; Wed, 18 Mar 2026 21:45:13 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%6]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 21:45:13 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Gao, Chao" <chao.gao@intel.com>
CC: "x86@kernel.org" <x86@kernel.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "kas@kernel.org" <kas@kernel.org>,
	"seanjc@google.com" <seanjc@google.com>, "Chatre, Reinette"
	<reinette.chatre@intel.com>, "Weiny, Ira" <ira.weiny@intel.com>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, "Verma, Vishal L"
	<vishal.l.verma@intel.com>, "nik.borisov@suse.com" <nik.borisov@suse.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "tony.lindgren@linux.intel.com"
	<tony.lindgren@linux.intel.com>, "sagis@google.com" <sagis@google.com>,
	"Annapurve, Vishal" <vannapurve@google.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "paulmck@kernel.org"
	<paulmck@kernel.org>, "tglx@kernel.org" <tglx@kernel.org>,
	"yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>, "Williams, Dan J"
	<dan.j.williams@intel.com>, "bp@alien8.de" <bp@alien8.de>
Subject: Re: [PATCH v5 07/22] coco/tdx-host: Implement firmware upload sysfs
 ABI for TDX module updates
Thread-Topic: [PATCH v5 07/22] coco/tdx-host: Implement firmware upload sysfs
 ABI for TDX module updates
Thread-Index: AQHctIQAtCtx3ZLQ/Uq7ANUo+rvPM7W01/QA
Date: Wed, 18 Mar 2026 21:45:13 +0000
Message-ID: <c38028557a53d0b70bbfefd36a9c51b8b7de24c3.camel@intel.com>
References: <20260315135920.354657-1-chao.gao@intel.com>
	 <20260315135920.354657-8-chao.gao@intel.com>
In-Reply-To: <20260315135920.354657-8-chao.gao@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|SA1PR11MB6807:EE_
x-ms-office365-filtering-correlation-id: b333e63d-1619-4b10-b424-08de8537a2ce
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: eXHxRkPEheYhKcg1gJdKXzZz7IvOaPQ/DNUk6f4Bxg9dui2iCiTsGEr3e8NUCi25KcpCwsQjpGMc3y1e5/b2jkB15vr/red+bK9Gu1QpkWeuSVAZfkBhZAoP79nx/3NOTsuwwljSCibEN3jZBW7igryuLuxFTDQNB4PjT7Ag/bb3vg2oU8Pjze+ORnFmcVGEwIS3pCDrKOn+xXLVwACumudU8MH0nrwmgHkcg6U8nLjnrmcLobrcAsGo5nxJbIcpRufTNYMbgm3j+7OuOUQ1Hr7OJNjzXjo+Qs/CirsaV5GzKYXmveN6VnDZgqqyx0zcsz5hu1AAAobSrBXpnBpfl8SEbnJFxS48AH1fKo6pfn6TIkgXotXWryZh9gDI3lBChhaxL6j0qdiizL3kQ7lDxd+BDa34ihV7M+N87b3ywH1BaqypNxAFOZs3FGEXz8jCu8sAISK7Bxsz99mTanGm+Lm9NjxiN/f3hgtyLGrB0ZVP7tH4V18BUJGFdcwJntEWsMy8KZQNC7zb7Mi8y/2lxQkvE3XURqGnbXPfQqq/1VVbjDfnWsqXuLKOTHs11GdzC1kuOj7jvptTmpfFjPKayd7q7MvJL7BxhlRJf9JIW5NoiU3bF3vSILCRwJcs1OeHcVg0ZQLVTNK1EeNSUVocNWOJJ4aafc7xiNKLnEdg6HWlCps07zFOlOfsPQJ5OrkcAJC4iI8zEKvYjKCsXlVr+cudoDPvkYaEylkzBdumYq/BxKbJb720peiZAACm+4pLk05o/8Yd9Z5U/vxRu/ikTEmEtqMaVlJ9i/sBr7vLm90=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K3FwOXIyR29NclRQQzlBVW54aUIwakwrcU1SL0thVDRRRXpDTFNlUDNhTjJS?=
 =?utf-8?B?QWRPYUFHSlk0RGpiL1FPNGFmYlFaakczdUVGbjM0TitNemFWdTJRSWNPSFV1?=
 =?utf-8?B?QXJqb3NhMUJtQmJFOUFvRkdweUtTajV3a01VQURINTFLcE1pSXVSaUZ6a1Yy?=
 =?utf-8?B?QmtSR0FUblVDcnRndktrb1MxUzdHR0pKWmFkYk9zQWt1dEpBNFE5K1pFUGNU?=
 =?utf-8?B?aThFYkVwdUM2ZHZnYWVlNDFyNEYreWtXdGJ0WEtRL3JuNnliSmx0SEVtNitZ?=
 =?utf-8?B?L045SXA5Tkw3NjVrVVU1WTcrZTJ6OVo3WGoyemJMOERCZ2NZaWFFRUdraHNL?=
 =?utf-8?B?bUM2V0VXRFUvR2s0REdzZ0tHZjQvOCtPVVppL1RFQlF2RXFDTkd2YWh3SWhr?=
 =?utf-8?B?cTNtSXlFR3JOUHdQUU9MQkRJU0JVQTk5YVFxZEZtMG91cmNtWnR2Y3VGRExG?=
 =?utf-8?B?Qnh0eVJ5ZjYwWTkvTlVwMmE4ZWd6TlZPaHg3ZFk0MGpqNDBYYjFsOCsxTnla?=
 =?utf-8?B?WkkySUpQc2hMR0JvRnpiWWExUXJlVmhPVnhENEU2d09PYnVuMjlkWnVzcllU?=
 =?utf-8?B?YVJNWk5JTEIyWExXdytxSU10aVIza2IweVBZOXJnV1p5YVFNNCtlTmhET3VJ?=
 =?utf-8?B?cC8yNkJQS0lMeDhzMmFEeGZPbXhPbDBIOVZHZkd1ZGNUMEQxM2RnTjRORlpz?=
 =?utf-8?B?T3JaRjY2Wk0yYVNNdkpHVGs2em1NWjlNRVpYSTB5V0k4THB4WlZSenR5M0pL?=
 =?utf-8?B?Z1ZybmFFU1dHNE42elNjSkVNcjI3N2ltb2U4KzlCbXJiSWZyTTVWSHVvOC9y?=
 =?utf-8?B?MFozakNUNGo2QlQzanIrd1FLTGRmNkNtZ2llUG9pUytETyswczIzcDVXWkh3?=
 =?utf-8?B?MzdvdHZCM0x5M2QxRkI3Z1BWeHNJeFhhREJ5VVZ0NCtWZUhTb3dWbVgxMDU2?=
 =?utf-8?B?TFg1dU8yQ1QvNDZYTk4rRG5UOFliK1JIOURqOXlqRzdZdEcvVXg1bjVoUVB3?=
 =?utf-8?B?NXdOZXBPeTFPQlJUbWVzRTJGYXk2c1REbkxJTXFwTzdnN2VMc2xEZE5VOUVy?=
 =?utf-8?B?ZHM0c0xKaERaMHlwbHZlY05OcENYUjNOcEt1cVhjNS9CR2p5T2ZidExXL1hj?=
 =?utf-8?B?ZndneDBxZmNCbVZMOHByWU1HenlVdllJSlBRQzdwdkEwQmYvMW43TStMYzZq?=
 =?utf-8?B?M1BBcUVDenduQzN3YzNyRTQyKyt2RGJVeFJtU2pTYnBVUlR5blZCb2VWVERq?=
 =?utf-8?B?RXFpN1pFTm9wSDgrenQ1aEpyZXpUQ1RzckFQV2d6bWZkU0E3aEpaSTBUNndI?=
 =?utf-8?B?a0dmOUFxMi9DVzNJZC9yVEVzRUh0Yzk5eWt1QWFvWkNTNFg3OExmeFBOOUdi?=
 =?utf-8?B?dFJJTTdHNVo1Nnk4eHpEZnJTSjdiOHVCZTltWTh6eEdqSWdUeFliWGl5V1Yx?=
 =?utf-8?B?Z3V6NENCYzNiejh2MTBIZUExUTZqejlUckRsNDBUbmJweVhhdkFkTVZxMmhn?=
 =?utf-8?B?dEhvR1BLUmdtNERqRGFFdWl2Z3FwWnNNTFJGbk1DZDRxTjlMUWI5d2VGeldl?=
 =?utf-8?B?d0RyM3ltZnQxSlZKeFlUUkRWYWVESUx2bElNQW1vZTNnbjBWaS9qMlR4eU1S?=
 =?utf-8?B?NUJYS1NIK2FveG1mYTkwMUtRazRGTVNRdFlObkdjZUJwbko1ZGFhWWN0eGNw?=
 =?utf-8?B?N1BHNEIwUGl3SFRRa0h3SUdDZjJ6d210MTRwWktXNEU2aWtxM2VyMFpoQVBn?=
 =?utf-8?B?MXJoa0g0UjlQSzhud3p6clJFb3lSb2wzQi9yN0RnZTBUUGNFc3ZWUHVPb0Rw?=
 =?utf-8?B?UDIzODZqQkdneWR5STlaQXVxNzZXMjI3NGgwWkZOUzBMV0hueUV0bkQxMUJj?=
 =?utf-8?B?MzdsWDJzd0taVnlYNUhFUWxNOGs2ZklPNWlCaUZKTjdjWXI3czUvMiszMUYv?=
 =?utf-8?B?UlVMY0JtUmxzOENwZ1hEeHExMTdBQmZDR21nMFVNRDZSbzhRWis2eWdWOGMx?=
 =?utf-8?B?OERyWjNUMmtZZE45TE5OVXg2Vm9RL2ZrZ0ZjNjZpcEQzVVV0eW1IaW1FRjh3?=
 =?utf-8?B?bUdFekk1RXFXQmZhRmJhWTdXZFJ2SzlaVjFySC9jcXh1L0tSQkJZUVpjQThG?=
 =?utf-8?B?K2QrWThyOHRCbTZ2ci8zNFh4K0NlQUdLNkxHQWZNNEd3Mm5sQWd1bjF5ZEpm?=
 =?utf-8?B?VGozZmtXRXdJanlxUTF2SGo0RVR3cU83NytLQ0liT2VZUGNkQzBGeFFGWW1h?=
 =?utf-8?B?aHdZdHdQa2FoK1hyOHZXVkMxZFJEU05VeFRFdXFvSGtIckFBcXEyOHRyRUEx?=
 =?utf-8?B?UUc5dHgvN2IzQWJmNmNwTUhQeVpaYWgrQlNTR0FxdnptdzdZVTJ4dz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7AFCCD52634AAF4A9430E464B6D0535D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ItZwnD6oq7xBsuMaWtpUlkDoJKbprhjZ8n4acdyffdiKfL+IIqBHbRvg4gaInYgYLQJNkf2pK2rYEuV/lV9yiRSVzjNkd73NlP6APgzSf171yW7NfTqAkcq2pL7Dx2wgWTa2XWD3T4fSfJHn+1Mn29egNvK2Fu/X0ivx6T/FYNGje+9SrmBu/NGU2WAZXq5MLK/4SGnS+cDJP3jfOCX+MFcVApmGfMNsZcdP7FKD5A143sAwf57I9RX8o4iDb5Sypc8ode10eToPmFTioQPy0FaqYh9aEHKX2S58u6br7ES3M3v08qYG3GpXguplr+LkuzhYuNfaYyX3biTqJ3WSKw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b333e63d-1619-4b10-b424-08de8537a2ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2026 21:45:13.3953
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dWtSxlMALyPxYbxAu4P1wlTI95V0QinIITRTKwcSxicWp0G9Hx+kvz2tuznH7bTFCvBcFDLmlpiDMMQog+HnGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6807
X-OriginatorOrg: intel.com

T24gU3VuLCAyMDI2LTAzLTE1IGF0IDA2OjU4IC0wNzAwLCBDaGFvIEdhbyB3cm90ZToNCj4gTGlu
dXgga2VybmVsIHN1cHBvcnRzIHR3byBwcmltYXJ5IGZpcm13YXJlIHVwZGF0ZSBtZWNoYW5pc21z
Og0KPiAgIC0gcmVxdWVzdF9maXJtd2FyZSgpDQo+ICAgLSBmaXJtd2FyZSB1cGxvYWQgKG9yIGZ3
X3VwbG9hZCkNCj4gDQo+IFRoZSBmb3JtZXIgaXMgdXNlZCBieSBtaWNyb2NvZGUgdXBkYXRlcywg
U0VWIGZpcm13YXJlIHVwZGF0ZXMsIGV0Yy4gVGhlDQo+IGxhdHRlciBpcyB1c2VkIGJ5IENYTCBh
bmQgRlBHQSBmaXJtd2FyZSB1cGRhdGVzLg0KPiANCj4gT25lIGtleSBkaWZmZXJlbmNlIGJldHdl
ZW4gdGhlbSBpczogcmVxdWVzdF9maXJtd2FyZSgpIGxvYWRzIGEgbmFtZWQNCj4gZmlsZSBmcm9t
IHRoZSBmaWxlc3lzdGVtIHdoZXJlIHRoZSBmaWxlbmFtZSBpcyBrZXJuZWwtY29udHJvbGxlZCwg
d2hpbGUNCj4gZndfdXBsb2FkIGFjY2VwdHMgZmlybXdhcmUgZGF0YSBkaXJlY3RseSBmcm9tIHVz
ZXJzcGFjZS4NCj4gDQo+IFVzZSBmd191cGxvYWQgZm9yIFREWCBtb2R1bGUgdXBkYXRlcyBhcyBs
b2FkaW5nIGEgbmFtZWQgZmlsZSBpc24ndA0KPiBzdWl0YWJsZSBmb3IgVERYIChzZWUgYmVsb3cg
Zm9yIG1vcmUgcmVhc29ucykuIFNwZWNpZmljYWxseSwgcmVnaXN0ZXINCj4gVERYIGZhdXggZGV2
aWNlIHdpdGggZndfdXBsb2FkIGZyYW1ld29yayB0byBleHBvc2Ugc3lzZnMgaW50ZXJmYWNlcw0K
PiBhbmQgaW1wbGVtZW50IG9wZXJhdGlvbnMgdG8gcHJvY2VzcyBkYXRhIGJsb2JzIHN1cHBsaWVk
IGJ5IHVzZXJzcGFjZS4NCj4gDQo+IEltcGxlbWVudGF0aW9uIG5vdGVzOg0KPiAxLiBQLVNFQU1M
RFIgcHJvY2Vzc2VzIHRoZSBlbnRpcmUgdXBkYXRlIGF0IG9uY2UgcmF0aGVyIHRoYW4NCj4gICAg
Y2h1bmstYnktY2h1bmssIHNvIC53cml0ZSgpIGlzIGNhbGxlZCBvbmx5IG9uY2UgcGVyIHVwZGF0
ZTsgc28gdGhlDQo+ICAgIG9mZnNldCBzaG91bGQgYmUgYWx3YXlzIDAuDQo+IDIuIEFuIHVwZGF0
ZSBjb21wbGV0ZXMgc3luY2hyb25vdXNseSB3aXRoaW4gLndyaXRlKCksIG1lYW5pbmcNCj4gICAg
LnBvbGxfY29tcGxldGUoKSBpcyBvbmx5IGNhbGxlZCBhZnRlciB0aGUgdXBkYXRlIHN1Y2NlZWRz
IGFuZCBzbyBhbHdheXMNCj4gICAgcmV0dXJucyBzdWNjZXNzDQo+IA0KPiBXaHkgZndfdXBsb2Fk
IGluc3RlYWQgb2YgcmVxdWVzdF9maXJtd2FyZSgpPw0KPiA9PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PQ0KPiBUaGUgZXhwbGljaXQgZmlsZSBzZWxlY3Rpb24gY2Fw
YWJpbGl0aWVzIG9mIGZ3X3VwbG9hZCBpcyBwcmVmZXJyZWQgb3Zlcg0KPiB0aGUgaW1wbGljaXQg
ZmlsZSBzZWxlY3Rpb24gb2YgcmVxdWVzdF9maXJtd2FyZSgpIGZvciB0aGUgZm9sbG93aW5nDQo+
IHJlYXNvbnM6DQo+IA0KPiBhLiBJbnRlbCBkaXN0cmlidXRlcyBhbGwgdmVyc2lvbnMgb2YgdGhl
IFREWCBtb2R1bGUsIGFsbG93aW5nIGFkbWlucyB0bw0KPiBsb2FkIGFueSB2ZXJzaW9uIHJhdGhl
ciB0aGFuIGFsd2F5cyBkZWZhdWx0aW5nIHRvIHRoZSBsYXRlc3QuIFRoaXMNCj4gZmxleGliaWxp
dHkgaXMgbmVjZXNzYXJ5IGJlY2F1c2UgZnV0dXJlIGV4dGVuc2lvbnMgbWF5IHJlcXVpcmUgcmV2
ZXJ0aW5nIHRvDQo+IGEgcHJldmlvdXMgdmVyc2lvbiB0byBjbGVhciBmYXRhbCBlcnJvcnMuDQo+
IA0KPiBiLiBTb21lIG1vZHVsZSB2ZXJzaW9uIHNlcmllcyBhcmUgcGxhdGZvcm0tc3BlY2lmaWMu
IEZvciBleGFtcGxlLCB0aGUgMS41LngNCj4gc2VyaWVzIGlzIGZvciBjZXJ0YWluIHBsYXRmb3Jt
IGdlbmVyYXRpb25zLCB3aGlsZSB0aGUgMi4wLnggc2VyaWVzIGlzDQo+IGludGVuZGVkIGZvciBv
dGhlcnMuDQo+IA0KPiBjLiBUaGUgdXBkYXRlIHBvbGljeSBmb3IgVERYIG1vZHVsZSB1cGRhdGVz
IGlzIG5vbi1saW5lYXIgYXQgdGltZXMuIFRoZQ0KPiBsYXRlc3QgVERYIG1vZHVsZSBtYXkgbm90
IGJlIGNvbXBhdGlibGUuIEZvciBleGFtcGxlLCBURFggbW9kdWxlIDEuNS54DQo+IG1heSBiZSB1
cGRhdGVkIHRvIDEuNS55IGJ1dCBub3QgdG8gMS41LnkrMS4gVGhpcyBwb2xpY3kgaXMgZG9jdW1l
bnRlZA0KPiBzZXBhcmF0ZWx5IGluIGEgZmlsZSByZWxlYXNlZCBhbG9uZyB3aXRoIGVhY2ggVERY
IG1vZHVsZSByZWxlYXNlLg0KPiANCj4gU28sIHRoZSBkZWZhdWx0IHBvbGljeSBvZiAicmVxdWVz
dF9maXJtd2FyZSgpIiBvZiAiYWx3YXlzIGxvYWQgbGF0ZXN0IiwgaXMNCj4gbm90IHN1aXRhYmxl
IGZvciBURFguIFVzZXJzcGFjZSBuZWVkcyB0byBkZXBsb3kgYSBtb3JlIHNvcGhpc3RpY2F0ZWQg
cG9saWN5DQo+IGNoZWNrIChlLmcuLCBsYXRlc3QgbWF5IG5vdCBiZSBjb21wYXRpYmxlKSwgYW5k
IHRoZXJlIGlzIHBvdGVudGlhbA0KPiBvcGVyYXRvciBjaG9pY2UgdG8gY29uc2lkZXIuDQo+IA0K
PiBKdXN0IGhhdmUgdXNlcnNwYWNlIHBpY2sgcmF0aGVyIHRoYW4gYWRkIGtlcm5lbCBtZWNoYW5p
c20gdG8gY2hhbmdlIHRoZQ0KPiBkZWZhdWx0IHBvbGljeSBvZiByZXF1ZXN0X2Zpcm13YXJlKCku
DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBDaGFvIEdhbyA8Y2hhby5nYW9AaW50ZWwuY29tPg0KPiBS
ZXZpZXdlZC1ieTogVG9ueSBMaW5kZ3JlbiA8dG9ueS5saW5kZ3JlbkBsaW51eC5pbnRlbC5jb20+
DQo+IA0KDQpSZXZpZXdlZC1ieTogS2FpIEh1YW5nIDxrYWkuaHVhbmdAaW50ZWwuY29tPg0K
