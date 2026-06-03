Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8310E38D011;
	Wed,  3 Jun 2026 11:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780486861; cv=fail; b=nIwRRQdTgvLQ+LhFwUajcZZTCbygrM3icO79bABcn7SWa7U0psLEtREeqCOl2nR6yImGwzRk5Rqu8ohMf/fJPhxa3xIri/QMtrFMKVwctARmzgmnDdf5X+RJi+ty4H0KxMvp5LTwU5VQ0I2rA7VKUbwTWeowu0PkqhA1Wta1s/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780486861; c=relaxed/simple;
	bh=1VGQUCmJuO3eUQ4MwFn75vUsGfv1fwEVLRBXHQ//w/4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pDmTKGObhPfuGzrz4H+QfOgjEYeIvChJeUv0sF19cxvMo1oHVf9x6EyFykJZ3C+hjq7bxPDwIK9cjJKfdIC6vUdoYCXizXC2KNCp7A3Sp0HUzMqkZk8J5jda/fWz4wYR/jRPYHMJeuVM8MN/MFNH/0qeIC26ruzDEzqqFztPbSk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OAsbyGN0; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OAsbyGN0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780486860; x=1812022860;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=1VGQUCmJuO3eUQ4MwFn75vUsGfv1fwEVLRBXHQ//w/4=;
  b=OAsbyGN0r8dGFxtE4/BDUPwzv5hWwx5ONGoxuG2hh1FQq4nK2Sewfzrl
   aXjIo9+R0g2aeIp03CGm7vVdv9vuAib19sqVycP+XWX0xK+lNd15uFM4N
   /gSc5wFw3/34wpoMTqCawEWjUwaX2UTy9VYmqX2mcu/rij+3qfzubB94b
   vD9sxjnTDHOhKraM1kv48rI7oA1PBfp5Aa6GqlPWnM7APo37P8vc2nP5u
   J4We0XwzTZ8kNJWrl2ZTOZyPJGu9cnluKDVLWWoPPbr2ztFGMhQL0BgXB
   G6U8tesEg8Fw8pKBIZgob33y8AS68tl1jYJFGcUUocg2yyxzIWwAoQGhW
   w==;
X-CSE-ConnectionGUID: iBLIDO25TXyJgOMJv8Tr1A==
X-CSE-MsgGUID: l2dUMb5IQ1K4agOcbLJZtw==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="81418856"
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; 
   d="scan'208";a="81418856"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 04:41:00 -0700
X-CSE-ConnectionGUID: yQOf6LbvSvyEJ0jiSO5NtA==
X-CSE-MsgGUID: /KxFr9jZRqS9GMxKiMmCkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; 
   d="scan'208";a="244292338"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 04:40:59 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 3 Jun 2026 04:40:59 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 3 Jun 2026 04:40:59 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.43) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 3 Jun 2026 04:40:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SgsHHSAkpYPqY0jcbRWbu3Q4GeeF+zNEvAa3ocWUvDWICL9z8mxQ/k3EFACPmGSCmO0nwfpUKhhRJP21JGHSKrTrqJggEkfNOM0Xft4Ueukm80cGykYqwao2/YiFME3j2jOPgkaZOk4LpmoW8MUu2kzukIqgz43PU66JQPQ3VoaDC6PN85MtABOap8Sdb8zEFPMP5i5sfiftzIMylFIADKcE5RZBm8G2hvVnkDHJroi/Hb/eKAhKzLngxDOvayBNL0kvrVe+lmUCjLdKQoOF2+AQSnQr0YYkBARUXX6Bac8UWwD7346kJQE2rHE1x1GcF13iIX7k3S0nXjkytv23hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1VGQUCmJuO3eUQ4MwFn75vUsGfv1fwEVLRBXHQ//w/4=;
 b=I0va82+/WHWstt0dtcUbS7odZSbhnFmeBuFZvPGnENDIdxtDOuHVT4UratDDyNyc6aEo6IpfYriFF0tMWd25byHwUGwzt8OTkpEVxXiXn7ub/265ZuSxVypANx03eGC4SCZk4nmbRqgmvFll1qx+p3st5+TVuQ1BLfpbqqyOaoOHs37sWhYyta+4azuGNIxNzFDADmwMBjObBM55QA7wJNScFKy96QChIKZhxmBEsZn+t6KLPktYHxXyaKEtklun9qnfgnHwczzgTb/f9DNgrKb9tss5acnC5B0s6EAnfPM644/KQgbQa7YaZsWmRD0Qdf5SN/4REwOw1bnanhKCMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 DS0PR11MB7829.namprd11.prod.outlook.com (2603:10b6:8:f1::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.7; Wed, 3 Jun 2026 11:40:57 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%3]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 11:40:57 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "seanjc@google.com"
	<seanjc@google.com>, "vkuznets@redhat.com" <vkuznets@redhat.com>,
	"dwmw2@infradead.org" <dwmw2@infradead.org>, "paul@xen.org" <paul@xen.org>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "dwmw@amazon.co.uk"
	<dwmw@amazon.co.uk>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "yosry@kernel.org" <yosry@kernel.org>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>
Subject: Re: [PATCH v3 16/40] KVM: x86: Move local APIC specific helpers out
 of asm/kvm_host.h
Thread-Topic: [PATCH v3 16/40] KVM: x86: Move local APIC specific helpers out
 of asm/kvm_host.h
Thread-Index: AQHc77m+w9rMVEC3uUWkeJLZjm203rYsvDmA
Date: Wed, 3 Jun 2026 11:40:57 +0000
Message-ID: <cc6b8181fb107350d0065de541749b7b3ded2b85.camel@intel.com>
References: <20260529222223.870923-1-seanjc@google.com>
	 <20260529222223.870923-17-seanjc@google.com>
In-Reply-To: <20260529222223.870923-17-seanjc@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|DS0PR11MB7829:EE_
x-ms-office365-filtering-correlation-id: 464ea989-119e-48d1-f179-08dec164fa47
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|22082099003|18002099003|38070700021|11063799006|4143699003|56012099006|6133799003;
x-microsoft-antispam-message-info: GK/6Bw6R6syfXmWyJZubj4BM0cG1xUYfF0aKcdfYSCPmJdGOMyl+TM434LVy/gipmQS5OL4xOTRicbZtFzTgK0yjkFAmd5naTnKR1cWQURuBpJWG2z10Ho8+ouhIH14VQGSvju4eg7WQexGMhUJRmIDBuvrK60lrZNJdv8/uFCS8WkWv60xOP/C8n68LX1oYI/IHIhOBpIZ+IlJTtW8YDVCPdZaG+BcNzPQqaviON9EmcWYXpaiW8jJp4G0mQcXA0PWV2vdWpwnRk/0urJO6/E4EyMt616i4llOyLwvfCHFiHpBtLxKYo2+TBqJ2cq5qlnJw5Iex49zGtPbTqHUotxSUO6YOyoTC5QTJ0N3F4txtu6eNaKAs8hxYlKvNDmY1t3nHfz/ys0F2vmcWABaTb5pOpJkoct7TJxwh6Ni912n3zXnRHITfyZd4sVN8CZCjzX4aDsKbyPxn24TWKIE66LVxwnDiOmsUC0azpwtlrSNCPE7ImqWjrvF57VCDt/+U7rTHoQrIBDi7KAUkl8WkwaMSeFkmPXzsQE/+MR6p5xw8ucEG1F742kc6TENPhhhiShy9n/xue7WceLx7poQDG9b2ITTqCBTrkguByZfB0kvRZ9S7izT809cWnSNg36YIHcmCBX0/4yVul3h0P/oznL/N+iCLLD1XzHbY3C5e1Q6obFybXj7CBgBngmFPgS9/OogQyrdZ/V4/e0/VhoVRlYaMhBgYJaFuSKg36K1qPwkIOZ+FZjEet8FY4UTuIGP9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(22082099003)(18002099003)(38070700021)(11063799006)(4143699003)(56012099006)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eEpkTEFzL2pVNWU3bG91Tk5CRXg0UnFJNk5oVk4vdzVFYzlXU3d1LzgrbXpJ?=
 =?utf-8?B?NFlUMUZNSjVZdmZzaE5NZFB6aDhtbzgwRmI5NkpUT3pRRktrNUpFc0hVUk1H?=
 =?utf-8?B?YWZldkNmWlBUMnNXc29XUTg1cmJxcXpHNElXbncrQkw2V2xpcnRwUGc0Qldq?=
 =?utf-8?B?bitHdlpncTB1cVg4dkRIcUtqVExnQkJOWmV6L01WWmFaVjZsYnNFTjFBL1l2?=
 =?utf-8?B?RERBUjZvbElOSm1sbUF5V2RISEdmY3VLYzZaYUhNVm1wTFp2Z0g0ZXYrYlpY?=
 =?utf-8?B?ZU1Kd3laYWZmVmxIQUd0WnhKYVFxL3ljNUIzNXhTSzVROVdRcVdiSENaYTRw?=
 =?utf-8?B?TmpPTVp1ajFleWQxblgxY016STVmY2dqNXJyRExuT2hXZ2h4TWNjRGxxenU3?=
 =?utf-8?B?ZU9qZm5qRExmZVN6RlcwVDVMZGZKemJoTy9NY2t4YWhacGhHN2tFMlhta3hD?=
 =?utf-8?B?aUtTZUYrU2NzZ0FqcGY0MDlvTnoweThqeGlDZGlVa0ZxMExRZHdLck1GMkcv?=
 =?utf-8?B?S1g5bEhlQXJFMVVTVzJYSkk3N1ltaWFsWTlwenpZVi9xd3ZlSFJlRFNSdjFW?=
 =?utf-8?B?enVBc1FYZ3lhMXovYVVTWlo5SzNIdUsrcnBHdXJpSXN5RnBmRkhaaFZHcXlo?=
 =?utf-8?B?ZC9BVjVSdy9JYjRzN1VTa01aY0pDdmg2ZDN3WlJaMXcyOEVoMkJlNnZFVXpj?=
 =?utf-8?B?RWhZOHBCeU8rYXRoQ1psVEN1T2FLZlpGTGhPSTNDby9ubGlrU2l3clhSZmJp?=
 =?utf-8?B?bEx5RjVlRkxDTlJLMDZYaUlTbnJCR2JOcDdTK0F4Z2N2b0MreHZXNkxkYXFk?=
 =?utf-8?B?am1BUGxIKzZkOFBWTElsTzJVaGJxeXFNblJVOXBhRGVKR0U1U0pDUFFaRGpa?=
 =?utf-8?B?RUFBU3pac2ltYk5ZNnZSQ3RDbkFNSU5VV3VQek0xUXdWK1haTUcxNk5mQjU1?=
 =?utf-8?B?SHd0QWhsK1Y2NFRRNDYrZVVZNkVkaUVhZ1lWNUU3TFlmR0ZjVFFJRkVLbUcx?=
 =?utf-8?B?eCtQaXhUZGFKN25HMFhWaUxON1BDYjdoOENpYUdnZFV4UVBDZkcxK0lUV0RN?=
 =?utf-8?B?ZG82ZXhoM3RMWGJYTlo2ZXE2QXBUenJMK1J0R1FrU0RleUlRMXkrVkJCTzBQ?=
 =?utf-8?B?YURMZ2pyRVZZNkJtVVJBQUNLVXNWRnhyZVovVUpjNjdQZHJ2K1RKNVQ1V0lR?=
 =?utf-8?B?cjU1ckRiQkErYXNtOEJmRUhyWnhyeHErd1BueStOeFZLV2tUdERRMXhSdVdO?=
 =?utf-8?B?dlhkNWRPeG9hQzdjdUJEVlQ3ekllQUpGaFBjYk9OWUpTNG85dTRjdE5CUDJp?=
 =?utf-8?B?aG8xWEVvd0E2SWtweUhhSmZVVmZiVlVqK0k2NExKMFlqMno3YzJaZFp2NDJY?=
 =?utf-8?B?WjkzUEdURDJjZEhSYm43Q25SZy9RbzBsSW9TVVJLS2ZSaDNkNlQ0aDRHNjIw?=
 =?utf-8?B?MXJKb2ZxNUo5bGMzbXhrdnAwb3V1em1RdkdzWDZSdGs4YXRQWFU1T0ptS0dn?=
 =?utf-8?B?dmduUi9tcUtSSEtoR3E1U0NCYkFNWkFSOW5aKzZUczRIL1NKZWc3QkU0NGtZ?=
 =?utf-8?B?ekFncmZ3cThUcDZKdHNVZkU0MWJGMGQ1eTQ0NjVhQTZHWGQ0MXNKUDlDOHpV?=
 =?utf-8?B?ZEhwTEczdnpxd1ZKOE5YekhBdmpxWDZXWWN1RFRsZU9MNVFKUEVDWnl1czRx?=
 =?utf-8?B?K0tpdTBaaEMrTE5ocGFBU2hYY1k5YzNGeE5aaXdaaEFFVWt5cmZncEZ6SzJI?=
 =?utf-8?B?RDE1NFFOdDloYkovT2YxMGNwQ2RuZlZQTm5rQlZ1aXpDd1hZOVRTYVY3UkND?=
 =?utf-8?B?b21jaVg1TmxiSld1WmtYY3VMUnl5dDhoTVdqYXlPUERGdFNKRUs2WHlHVEZL?=
 =?utf-8?B?QzFCQlFQQWo2bFFkcXhYaDRGWDI2RHo2ZGFyZjUya2l5ZjVRNXM1SDZzRGc5?=
 =?utf-8?B?WHpMeWtSbysyQTVOY1pIcnA5UGVnZW13eVY0RGovSVJ0Y0l1dGwzSzdFSElI?=
 =?utf-8?B?YVdjZHd2UU1nRnA2ZmVLcVBtQldZOVg4VUtkNk44Wmd0VWplN3NTSFNzWm11?=
 =?utf-8?B?amNFMy9sU0pqTEU5M2l4RnpVYzg2dldLQ3UxOEZIVFhHRnYzMmY4VHZRS2pN?=
 =?utf-8?B?bGRSanZiRzR4cldtaXQrM2RsYnhORkxVbEU2ellVTXlwVEU2VTVpalNWWUQw?=
 =?utf-8?B?RmZBbWhBRFR0RG9WRngySnQvWFZlU3g0NjhsNHhrc0xaMjQ4a3JwU0tiN21X?=
 =?utf-8?B?T3RJWXhrVWp2VUszanl1V1pPTVFJR3BERDR3MDkvU3JMQndkOGVQN3NrUCtn?=
 =?utf-8?B?VWRJTFdPQVJPeTRkOFNkSlZwTG4xRm13ZzNFcXJsemw0aTZpQ0p5dz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DB0F56938FD9E64BB00193E2DC799F69@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Dmofab+L0iKvKBlsJKmKTrjcyhrYh091ojg1C5e6HhDKtiouQmxs8QsXHh4dukWE/KhZGkzQ/5l4ZUb36ItMKQBnLFLamOO4YmtxW5XhqrXlz+nz+lakKUw9Ne9luRbV8MpvBnZwjyjEAdGBugpC9DvxzthmqupnZrDH+77BT/rhIdhIn4nMr41rkdV0xqtzq6yKu+xLwX8jmMf7LM4zud/Cs9kcGd1TFbJDI7T/8lhS62D+XSLVgg6mrNBAuBCh0pt1dqZTgcGa+tPrtJ91wRojzpQjIE0HUWkeatgPNAvzbHswMrxIQb19DqkUUEXXY7fjGtt6QymDmZ3iJ5K6+w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 464ea989-119e-48d1-f179-08dec164fa47
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2026 11:40:57.3052
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YKiSjh531iG2213RirppGPz9E0OkqecRiSxwm5UdjMS9SIo3DvYw/D8oZoCx9WFQDQA2MyOQcOQTb/5Nd9FvBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7829
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTA1LTI5IGF0IDE1OjIxIC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBNb3ZlIHNpbmdsZS11c2UgbG9jYWwgQVBJQyBJUlEgaGVscGVycyBvdXQgb2YgYXNt
L2t2bV9ob3N0Lmggc28gdGhhdCB0aGV5DQo+IGFyZSBjby1sb2NhdGVkIHdpdGggdGhlaXIgdXNl
ciwgYW5kIG5vdCBleHBvc2VkIHRvIHRoZSBicm9hZGVyIHdvcmxkLg0KPiANCj4gTm8gZnVuY3Rp
b25hbCBjaGFuZ2UgaW50ZW5kZWQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBTZWFuIENocmlzdG9w
aGVyc29uIDxzZWFuamNAZ29vZ2xlLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IEthaSBIdWFuZyA8a2Fp
Lmh1YW5nQGludGVsLmNvbT4NCg==
