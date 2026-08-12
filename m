Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E6230C157;
	Wed, 12 Aug 2026 20:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786566129; cv=fail; b=uMMEp0HjMV8BW1qhatxURtYVcY5kBbDLqfR0nUaxvUZ6oCX0aTQumvL+UiuFOEs264rDdWAf5KTsyetEFHqg2aZgx9/EwpSMyDrTVeYkMYHVxcG7M/+bCLmRARQxD/qBb4MXfwB94RiNPGVCbZnIUBqvnVD7/hro79bLadgSGUc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786566129; c=relaxed/simple;
	bh=zonn76sMsplntqf5v4P7fAf9rltVSsQvsJs997hcBbY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dFpYXtjdyNwCqCkX6VwOpFTHhSPIkRmjfOvZM8yTAA8tvYwNCoPGECzF/pXYoiK5HJ4ggDXM6d/f8mRxWe5CKV0OIgVf3+TeE+92DWugb4Qw6rQ2ZFEnIvlPW2XbhoXiJt1VsqFn8GNbH2MfUECUv8EKgXEWSK2LfjjPdaV1X80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ebA1zTwH; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ebA1zTwH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786566128; x=1818102128;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=zonn76sMsplntqf5v4P7fAf9rltVSsQvsJs997hcBbY=;
  b=ebA1zTwHT8XEkH2wVLd92a9GjYjez6VHkrKCYrQehenePsHHyXo4tCUV
   1Xua1fTAHam4R9b12rcVLHbgsEuaAWcYiXp2oYZNXC4yhT85FKAIQb9It
   lNkQoNeqNj4NyAlyMtInvlSawfcv4GTFVa7wVxGjF1GmMkqZTu4RI5iE9
   rnmDfXbwwuJpbhVlGOdqKlXEhLnSAGmisYlOUBx36vr6pPOhccBd8r63I
   3Nsizk+FUQHXZq+tMmUtCxWrpxKGDFdrJDxgwfL2rKGVXK2QN1Lk2zjQU
   V8zVzt0LTp4iRudThT/cAJLrO6Bvp7uqzIn29V7ZhtBOlROjZMZfslBZo
   w==;
X-CSE-ConnectionGUID: CyXin0TTS52wUnidl6w1gw==
X-CSE-MsgGUID: WLMZMZzZSymaESfRCJueXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11873"; a="86900594"
X-IronPort-AV: E=Sophos;i="6.25,220,1779174000"; 
   d="scan'208";a="86900594"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 13:22:01 -0700
X-CSE-ConnectionGUID: gg6CZRo3TaiCC5X3QWAcMQ==
X-CSE-MsgGUID: 9qhw9vOrQV+w0i0QOxUvRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,220,1779174000"; 
   d="scan'208";a="302001115"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 13:21:57 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 12 Aug 2026 13:21:54 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 12 Aug 2026 13:21:54 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.49) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 12 Aug 2026 13:21:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B+AWG/8puMnRGMKeLrLWhxBK6VD63iz1rR5sNcBvQcGdHwqQPVniCRJXBd+0EtBRMG8Ugep4rlLnuKtkgmdHaLmH2HCxPgAyicWHoviPSRz5jI8GfQXP1DTgABxRZOa4//KkeQ1h86XEAwj4Xs7UWIgjSL8q/RPrt/ePJ8W/0IgSWef3JhzF4DQpXag/5CVVR3iDp3/n9q+c71x8YMpwxmJQnw4LMLvGKy5a20u08hpu4N52ok3PFg/+PZFtyqSOeX3jRm40Lcd+ccMw7BM3B3pb+aGqlwxYvOAZUUp72aROm7WUL0v6usWnm2FxxSesd/b89cWDs7HvcdD0SkfwbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zonn76sMsplntqf5v4P7fAf9rltVSsQvsJs997hcBbY=;
 b=THWX7S2LF/ydCQsC86Ux6dYqXUKcInQ4bbQwB3KsNqNadoy/Sbf8ehUq/TDV2c+Od2Z2zrsS1rVoHOGOZypUn5e66iTBAHsMwlzYxabhumyeU/I07Ew69vdfHJUVVqTH8vlbURTfzUHWqLPbHhxqJaK2f9/MYCJuj9ILi2kGCvs9oQ0d88AGd6Q8ZmQkzy3auCHMeCMGhLqd56HguX72nOwIXmKXf+tD8RvTAFqgBmk53sCYaNDmrh8lSM8nShvhZ7MhjzmfjiX9uPcFYmZ18scPS+wOOjS1YFQT/4eXyyl8FAc8aTRRemY5p0dctjfSC9wbk/XNF6+laVvYWzcb5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by EAYPR11MB9563.namprd11.prod.outlook.com (2603:10b6:303:2c0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Wed, 12 Aug
 2026 20:21:50 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0315.014; Wed, 12 Aug 2026
 20:21:50 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Li, Xiaoyao" <xiaoyao.li@intel.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "seanjc@google.com" <seanjc@google.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "kas@kernel.org" <kas@kernel.org>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] KVM: TDX: Fix the exit reason handling
Thread-Topic: [PATCH v2 2/3] KVM: TDX: Fix the exit reason handling
Thread-Index: AQHdKLszJKJ95KF+vUOi4YjlC1BNl7aYAh4AgAAO8ACAAOhgAIABDdKAgADXsYA=
Date: Wed, 12 Aug 2026 20:21:50 +0000
Message-ID: <4447e3f5a6c6fa5c64774c8b1a28fd901833b8bd.camel@intel.com>
References: <20260810112200.2326727-1-xiaoyao.li@intel.com>
	 <20260810112200.2326727-3-xiaoyao.li@intel.com>
	 <5dfed336a46329ba39922dcb3a8723116dae9ae4.camel@intel.com>
	 <6bb1328d-e995-4ad7-9744-3ab01d2ae591@intel.com>
	 <0a458dd822e5469068d5dea6aea3dd935b69e963.camel@intel.com>
	 <1a7bff3b-731b-4990-8267-82d08669c8ee@intel.com>
In-Reply-To: <1a7bff3b-731b-4990-8267-82d08669c8ee@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|EAYPR11MB9563:EE_
x-ms-office365-filtering-correlation-id: 80c2b015-a3f4-4561-ecae-08def8af5792
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|38070700021|22082099003|18002099003|10067099003|56012099006|4143699003|11063799006;
x-microsoft-antispam-message-info: 449X+14PG0WkTsJVPmSr9ku2Y7fhw7OuDamrOokZHPQhCUTQOGhpKRuqVdRm2imxMNzHRP7NFZcnRx9zHNf60vuKFnVYtxq0LMJM5nKY2Ia7ZNIPfnprPyF8nMsNDDno59ASkqKqWtqwW3BSF6vp0hgVkzhEKDt6DX7+TOymEuKtChHnFRtNjHPXTot+Q3en9BXzMO/CIcnvsWIjrUxQFhjNYavYa7BGLQpHgdgnL6lD1ZxqL8zf8D78RK0xiwosX9KDVWC/IEFUerU9d/gfn/uP8RLkhGkI01rTg7J9FmRJE6HfSx/S+GA6JDEKrFHuIzv/Hm8/uRgId4yKCQSyJceVZ3baof1WkcXWoEp0aQL5wQRZtrJF3ANeEeSwIs6ziC0w5ZD7h/ZvNc6by/fSamD4qMY9hGBZeUS2PP1Z0iGKuxBGkLHiG7E/Ezj86cz1G3ZciTyYZ9SQz9JLV6q5Z/0Taq+kFPJGyVKS3I/z+FTBZ528gZoDdfpxJ5uFVaGlFS+M4nuUfiQUe9Es5pNqcqwSh/jijVjojBN17MQrbEO66Telx8kMi5oJZN90ymCgH6HiVOFghMts6aRFWjMhh3HX1EifFvpAdm0O+ItYvGGwtaVRsnl6yp0XgvX8pIXO2bypx+i5stWLAx17z8jMpPGWpSK/QRpknvH7lukQAgFnLQZaOcGY2OFPrGKYLnFH97UVfPXPLii95GNMcbxSQQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(38070700021)(22082099003)(18002099003)(10067099003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dVMybk1jWkt5ejlHaENnSEw1YW5WQk5rYmxpaGEyMTFzRE9JR1NBVkZxeVZx?=
 =?utf-8?B?VUJZSnNuSEV1U1Y0ZTNrSzhvWHFma255WTRMMllIcHZ2ZTB0cjNCZ1dYOVRL?=
 =?utf-8?B?VU1jSThkQUwxcG9vZ0VxLytIYkd6ejBNcFFscFZEc0h5M0FUMVR6TkpBQkkr?=
 =?utf-8?B?VElzSkVJdEpEeG0zRlV3R3JxYVFTWUJoTzczYzRvekphRzJMTGcwS3JwOUkr?=
 =?utf-8?B?d01nTVRCMVZBODNoY3BpM2dxMUoyQ0JmeDUzSlBVVFpBcTM3dWhYUXBxcWhu?=
 =?utf-8?B?dm9QWGVpTkJiRW40YmJzaFlPQUYwVVYyNjhoa0wrWWZrTDk3bmZERy9lQzQz?=
 =?utf-8?B?WGJvK01RZTM5OEQvRHRZZEhlNkNvNFB4UHJmbDdKWjQ2ZFVyb0M2QVVnYjA0?=
 =?utf-8?B?YlFHMkI3dHZDclM4aTVOZ2pBM0RKWmx2Q2FkcWlnRzU1SE9hZG1hYVFkWTdm?=
 =?utf-8?B?YnNreStkcHZPQ0xSRUpVT3IvdWFWSDgzZWttWXB2b0d0eE5wVjdxRlR6MkVn?=
 =?utf-8?B?dFZQYjd5TmtmYmhOOTB3bThmcE9ZQjhpL0MwL2FjeVpQVWhQSzR1Q0t4TmVY?=
 =?utf-8?B?dGlzOGRsZkgxbUZ3RVJETUJBblRaZWJrNWZRNXpORXZqOHplWnFZaEtqNFlo?=
 =?utf-8?B?MzkyQStjSTJ1TFZPelo3cFcrQ2NQaTFWZkd3ZHlvR0xDczcrZWx5R3BFMzRa?=
 =?utf-8?B?VUV4Y2RMdWNrM1hCNUVuMXlDTFF5Qk5uRWI2ZFA1QlovOURUL2RyaS92dzNy?=
 =?utf-8?B?MDZtdHk0V1A1VlZXZUVYYTVaTm1HKzAyUWNkYjE3SEwzSXdSQmtGMEM0TSta?=
 =?utf-8?B?a3VGMEpYbFhvRFM5Vm5xL0orZFd4WmpjU2NBUS9vbVJqUHpOSU41Wnd5NzNw?=
 =?utf-8?B?MGVBK1oyUVhhOGY0Wk45bTN1b1RWZ3NVbW5YWHI3MGs1WUxQbFNnSzdLYjR6?=
 =?utf-8?B?OS93YnNON3Z0WmQ3RVdwMGJ5YWpRVERWZDhpL2RHbGx4ekVNdzdqcSs3VGpG?=
 =?utf-8?B?Um01K0tqY3ZpS2ZPZFNkV3VsVjVDTU5sSkZtczFUVnRoQXVxd0psL0VOVXNB?=
 =?utf-8?B?R1FiMjlCRjlyZmVuRjZoVENDZGM3dDJjOXdsNDkxbmcySnhXT0pleEc0VDdk?=
 =?utf-8?B?WHE1dkcwNVVzcU92c04wbXFqY081SVdUMm1qcmN4eCtDQkZ1YVF2bEdGV0xv?=
 =?utf-8?B?Y0huLyszRG9iakJGYVh5QTAyNFVydUJ2ZkVEaDFramlaMzlUdmtKb3pvdzQ0?=
 =?utf-8?B?bEU1Q1RpRDE2c1dlSGJ4aVA3b1hFb3Y4V3VXRWZrbHVmQnJpeTRrWTVJOWhi?=
 =?utf-8?B?SEE3dFRTSnRtcmwzbytsSEI2dlJjc1Bkd3ZWMVdHUXZPWE9FUkg3b3JWOVFt?=
 =?utf-8?B?dHVma3IxdG5QVFREaXhYTnVLQmhnV3B2TXBOcjU1aUdZZlhvYkpOUE03YmRu?=
 =?utf-8?B?bWFmZ0pZYjdRN2tFNDNlYVEyZWxJWnBOenJkL1ZvWWVnRHhybGQvYU5UTnFm?=
 =?utf-8?B?cWpVUWxxTTlrem5CZUtvTm5nWFJNZ29lMFRLWFJvZjZzd0J4TVZ2WWRyS1Q5?=
 =?utf-8?B?bWVjWW1yMC9vN3RGSnRWL3JWVEg2blpaMHpZVGFpY2o3cEUwdmFlRVU5UmpS?=
 =?utf-8?B?bE9UTmdQMzFFUXpaZml4VjRudDZIakljU0x0LzFuT0RNRmc2Yi9zYzlteUF1?=
 =?utf-8?B?WHZ4Vnh4OTc5cWFpbDBFN253d21vQmNPbWd2eGZHUXBabkd3Tk9Jc0pTbk5G?=
 =?utf-8?B?TUZNSWp0YUJVcDFMUmJSVFhiZ0I1TjZkSGV0U3B0R1V6Q1l0dVNUdVp0anZG?=
 =?utf-8?B?RmVvWDh4dmUyVlFVVlp0RmVOSDBlNGNUb3J2SzYzQWdJNDFKSHhyaGphK25Y?=
 =?utf-8?B?ZEk5b1VSczRIRTN1ZTlvSktvTFJWMjFDdm80bmdWYXpoZzg2QnRpc3RXU2pE?=
 =?utf-8?B?WDY0V0VtNVdETjdNemprM2RqdkZZeDZGVnVCNTQ3RThrQ2tlMGxWeHIwMFJn?=
 =?utf-8?B?d0tpVjd0YXpESXRiYndDRGdWT1doY3o4Vzh2TXdpeHlnSGhUREVrTjg1enJi?=
 =?utf-8?B?NzdBa2NIWmk5N3FPenlYS3FRK0NnVmphTERad05FU0ltTGhkTC91ZXlIR09U?=
 =?utf-8?B?RUM0SVUxTWNncHNvZWN4QWFiT3hwdlNDTlZUVUw1UVdtMkFKelVXYWJPZHVa?=
 =?utf-8?B?WDVUaE9IcnUyWW5HR3hYUGYvRjQyWU1heE9aZ3FPQTJWMHI1VWdPS1NhY3Vk?=
 =?utf-8?B?bnNSMzBtTU40dHo2V25ZeTZleGJiWkFGa20zRVo4RmxiSEg0UlBEV0VXZWlq?=
 =?utf-8?B?U2JSdWR0K2owdXQ1My94RTFiTFU5VXllZnBNcDAvSkZmWkw4ZmxtRWVUTTZj?=
 =?utf-8?Q?JKF/FHVIiZIwfPfE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A4F038F2E34BE64EB5493D6E49FCA263@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: nOOruh0bKXR7nqjdRpoKrg32bjrCQ48DRsTmv1Ejph3bDTNMIS7JYee6cS4BjsqZkDDUxMBJLshHCPvdORdQ9aOosUecTduEY5ji96GZ4ncZjUfXyAdqRNQZY5ChH8LMTbZ6PxKCHemxOAQ7bzHAoUVneSSgWPFCR/S55bjWpaXsaRGFf2EAzvdS9tWLUcUopcldfy+n5pFYczneJpnYd/dHgwYqL6bcKQxb1sZWcGB3mSQSoE1T3ROeB99gY0njcDedAILpPmQ11plea4s1O7EuqQxcBsr66gFq6Ml0eF3xNPBdvu847VyLfERFrz9EXhsO61b7fwdOPavgaubBvw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80c2b015-a3f4-4561-ecae-08def8af5792
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2026 20:21:50.5233
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FFwHDOBqK0DIc4at9SOPU3F1oVQ9GPZPPFvbUWOutNWlwItCX7g81gOh3ivcDdVjraddsLMsVuBST12s8OLNd/meYfBk8mQHex0swROwI60=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR11MB9563
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTA4LTEyIGF0IDE1OjI5ICswODAwLCBYaWFveWFvIExpIHdyb3RlOg0KPiBX
ZWxsLCBhY3R1YWxseSB0aGUgYWRkZWQgY29tbWVudCBjYW5ub3QgYmUgc2hhcmVkLiBGb3IgdGhl
IA0KPiBFWElUX1JFQVNPTl9FUFRfTUlTQ09ORklHIGNhc2UsIHRoZSByZWFzb24gdG8gcmV0dXJu
IGEgc3ludGhlc2l6ZWQgDQo+IGludmFsaWQgRXhpdCBSZWFzb24gaXMgdG8gZGlmZmVyZW50aWF0
ZSB3aXRoIHRoZSBjYXNlIG9mIA0KPiBURFZNQ0FMTChlcHRfdmlvbGF0aW9uKSwgd2hlcmUgdGhl
IGV4aXQgcmVhc29uIGlzIHVwZGF0ZWQgdG8gRVBUX01JU0NPTkZJRy4NCg0KQWgsIHllYS4gWW91
IGFyZSByaWdodC4NCg0KPiANCj4gSW4gZmFjdCwgd2UgZG9uJ3QgbmVlZCBzdWNoIHRyaWNrIGZv
ciByZWFsIEVQVF9NSVNDT05GSUcsIGJlY2F1c2UgdGhlcmUgDQo+IGlzIGhhbmRsaW5nIGZvciBy
ZWFsIEVQVF9NSVNDT05GSUcgaW4gdGR4X2hhbmRsZV9leGl0KCkNCj4gDQo+IAlpZiAodW5saWtl
bHkodnBfZW50ZXJfcmV0ID09IEVYSVRfUkVBU09OX0VQVF9NSVNDT05GSUcpKSB7DQo+IAkJS1ZN
X0JVR19PTigxLCB2Y3B1LT5rdm0pOw0KPiAJCXJldHVybiAtRUlPOw0KPiAJfQ0KPiANCj4gYmVm
b3JlIHRoZSBoYW5kbGluZyBvZiB0cmFuc2Zvcm1lZCBFUFRfTUlTQ09ORklHIGZyb20gDQo+IFRE
Vk1DQUxMKGVwdF92aW9sYXRpb24pDQo+IA0KPiAJc3dpdGNoIChleGl0X3JlYXNvbi5iYXNpYykg
ew0KPiAJLi4uDQo+IAljYXNlIEVYSVRfUkVBU09OX0VQVF9NSVNDT05GSUc6DQo+IAkJcmV0dXJu
IHRkeF9lbXVsYXRlX21taW8odmNwdSk7DQo+IA0KPiBCdXQgaXQncyBub3QgdXJnZW50IHRvIGZp
eCBpdCBhbmQgaXQncyBub3QgbWFuZGF0b3J5IHRvIGVuYWJsZSBCdXMgTG9jayANCj4gVk0gZXhp
dCBvbiBURFguIExldCdzIGxlYXZlIGl0IHRvIHRoZSBmb2xsb3ctdXAgc2VyaWVzLg0KDQpPay4N
Cg==
