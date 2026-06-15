Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B72F2CCC5;
	Mon, 15 Jun 2026 02:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781488844; cv=fail; b=qLk4Do6oJXlmJ17AaGCGOkvQ6iz0Z82cic+9VK49qSJ6o5m4jpWyg59RPJAxxUmhazHs2/c5nMXY79utUsQEOMUKz+YjxdhBBSXkp8HYkDM3bzxQLGJoeWDgABsUCQhWjx4kXeXfZQFW/0HoUmeCUqkmqW4Bth1Yc4rfI+2ZCew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781488844; c=relaxed/simple;
	bh=2EDDUf4FDi9An/A5vYhiPKeypbx6Szu5sWkUGhDgfoo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ojh3EtI5bshu6CebPm9UHEvGqzkedFQMgWmMO50pOcxzlm9pwGF2JgQEnLbUgdPVBNiHPNFv7FQVgmBEsVIBJSvKgSY14bH3jssp9DaNOOPDaLGT3pOaSxhxvNhnWdBsLKQIzAfv8YcreSelq3eB0a5NamKWKzI48rrXRdAgCJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mzQY7Nsv; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mzQY7Nsv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781488842; x=1813024842;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=2EDDUf4FDi9An/A5vYhiPKeypbx6Szu5sWkUGhDgfoo=;
  b=mzQY7Nsv615PqlbY9IRzwnmKirEE0/mK7nahpZfIjm+4bUwe3n5tWX5D
   kiGILdJaUOM0XvnYuMSJvQG0HRCGIThWjhxAjRiRqefSmJidRyU1srN6L
   CvK+ki3XXs+2ydCcr4X9pTPeS047UOGimbSFtSmbmiUZZfRc2P+/HNv5p
   qhkyGjfQaRiaAWhfoVGuHYpkLmvvzkw2OybpwEREQdISvkdUAEct83/oj
   xKt/rrrYeXG3bHFLSkH+Ou34JLTc1//RiLXH89U5d1uvfjCty+6QPyTUl
   xOwC46Aa50yw7YkSPCfwwmhs2lu75Zh15CYrXDraPNyNua06XCRs0t9YV
   A==;
X-CSE-ConnectionGUID: Jgfvf5JLSXuIzm5KCILWLw==
X-CSE-MsgGUID: hHczNoivSXeI178uAQPOiw==
X-IronPort-AV: E=McAfee;i="6800,10657,11817"; a="81359820"
X-IronPort-AV: E=Sophos;i="6.24,205,1774335600"; 
   d="scan'208";a="81359820"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2026 19:00:42 -0700
X-CSE-ConnectionGUID: GiTOqh1wSfKhQKNLwJXJbA==
X-CSE-MsgGUID: Wzr+H69WQL2lMxUP+jFn2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,205,1774335600"; 
   d="scan'208";a="244936919"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2026 19:00:41 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 14 Jun 2026 19:00:41 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 14 Jun 2026 19:00:41 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.1) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 14 Jun 2026 19:00:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IOuXczZZMHPbmBkKLPgX7FTTq4RnREPapXxOHLf5UpO076EX6sTo9K4OSbUFxvEqT853Vw35ERTB13YWcWu6MgAX62YMRpd0UQhZ0I10DZepHk3s4eoDs4kgyAIUOByLE73i2iTL6ljoLlTkd2nLQUaHzxYLEsDa+v0egQp11Kj9rDuT6e48j6gvmYcXuAnLxTtFiiGgrAKvFSx2UjHh+rFmRBqU+QNoQiFedD9swgHdCN/1zf2mRvsFc3NPeQNE7YvIufmLSw9lStmzcg6S1RmoTPM6tP/1vIhwN6m39htQG1CVVLGAGtWCYzH4qsp8RZCe/qAlMWoyMst0GUzbHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2EDDUf4FDi9An/A5vYhiPKeypbx6Szu5sWkUGhDgfoo=;
 b=OjxZZMT3Po7kM2OTnlQDqzx/pXDDhWFNNFSz4/FiDcJux2xxD9Kap9ZGdJnHLGxcd2uM/HpxeHblPp6yIUB8LEO/Sr9HMcdN/VosaO6t4yyN3NqXCCFu2Q6apxugL18zMsBbAWXtFWq5BJkbUKZCOzMg7fECZXl34on6it1vCWa9CCS+gX3BZTJZrwOeGGB8tWMhmViBz3Nqd6KdeKA1DfVwWO6Me4enelXx2akoEUshG7j6w1q9FWnRVAZt3/G1VDQZDSZoJi42picBiLRdgJznQuJqI7gp7gKp8vkHBHkQUXUmRIm6sVgK0tHI9xr0q00fQr/++xioA4mp7IevkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 CO1PR11MB4881.namprd11.prod.outlook.com (2603:10b6:303:91::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.18; Mon, 15 Jun 2026 02:00:36 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%3]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 02:00:36 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "x86@kernel.org" <x86@kernel.org>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "tglx@kernel.org" <tglx@kernel.org>,
	"seanjc@google.com" <seanjc@google.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC: "hpa@zytor.com" <hpa@zytor.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "yosry@kernel.org" <yosry@kernel.org>
Subject: Re: [PATCH] x86/apic: KVM: Use cpu_physical_id() to get APIC ID of
 running vCPU for AVIC
Thread-Topic: [PATCH] x86/apic: KVM: Use cpu_physical_id() to get APIC ID of
 running vCPU for AVIC
Thread-Index: AQHc+p0H1opnKNEehE+LkBWwpE3v+7Y+4EWA
Date: Mon, 15 Jun 2026 02:00:35 +0000
Message-ID: <1a254f5df4cc66952a7a7f2e9b669da334fb3525.camel@intel.com>
References: <20260612185459.591892-1-seanjc@google.com>
In-Reply-To: <20260612185459.591892-1-seanjc@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|CO1PR11MB4881:EE_
x-ms-office365-filtering-correlation-id: 5ec32246-8e70-4209-728e-08deca81e421
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|23010399003|1800799024|56012099006|11063799006|38070700021|18002099003|22082099003;
x-microsoft-antispam-message-info: Lie6CqZzhhCF2xXqn3Jgn0hJrUnArlWlOA/wfiDZvLszGwVWpm6K9svAL1Be4MHUhsiMg4H9IB/Qc+nA6Ptp0Ur+CimPc/QhdrdskehAuuVLrge1rWWmPiDqpDhUKUa9LjRv2Z5s+t5zwqNBRz+ftgm2Y8tJ0oOh57+zJA9BGPOtNF/R/jEMsg3nyFP1faoSpORZJFOOhvtGHp4utOzb35zSSdB/ttpkySxlPJ22Fw85kDtcWkNPNdUAO/V9/gyzWawyIxnpbT66SamjZs/ffcDJtqNeY0x1L06numjp/z0rSUwYduyJSceekPLjAEv1uFJ2tQytNuvSCp3kkp5BTjSUsEkfzwZocGF28Lk4ahbHuItohIFirPCxWka2XjNDHczJ2Nd9z6TKtDQnhebhGzDezTTH8xqnh7nU4oBfIwXeGwrz3QglaWYxBuilfyIiKfAg6w0qImGlSH2zAT4tZKY9xxpOuvNyOvvzJ88XzMnflmpdUeMmJfSBvw8aHpm7q2h1VFUKMbl4XZqu/k2rYMvqujOQd9p7JP5ZEOxyw0TiXWHNwqp6kTlJ4ETNfYuFGrKi9n3Op8ANPGErnwW67cEb53SsVjEZjyIXmDb8inf04RNBnDt4mcbRVt/dUDYKLAs1qind8oZ+A6zeN5w2xQQhd3PNPeekjzksGVIf8LQJ4PJJ8t44Yb2imDNjDn740LHqgAuETPvWuZa7a8g7z0v9yXygPsjsQrDRd9U5P2Fb2T/ihzCG+CBvmzFma6iJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(23010399003)(1800799024)(56012099006)(11063799006)(38070700021)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cTlsQTBnQVd3Q2M4Q2R5UFJRajYwRVFaK1VOVEhBSXFDM09hUnJaOUh6OTkv?=
 =?utf-8?B?ajM5RzNYbDVxVDlvOFJtUERlOEMzc2h5OFBkRXNBRFlFbjdEMXFFTUJCM1Z1?=
 =?utf-8?B?V3JEVVJKNkN0RkdBcUdJNEk4ZGJKVmNLMG5hcDVOS0JSMnAyUDFHSmU2Um1I?=
 =?utf-8?B?MCtWZ2dvemhzc2p5ek54WUFQZGtWc0JIblJiRy9DMDNzbEFDZDlxMXIrUTdY?=
 =?utf-8?B?UFl5TS9VVXBMK3JrTW9hZ2R6UEtrR2pEUFRqNU1WemY5WW9ZNWR4QkxPaWRl?=
 =?utf-8?B?M2thZzdjOXlzSmJtbUx4Ym9OSmJEZjcwTHR1b1BSeXAvZHJjNlVoa0hTV1U4?=
 =?utf-8?B?NDBJQmpYaEtmbUxiYTRib0U0TlJHbVdoa1F3aGVQR2kwYkRXZ2tBakJnNC9C?=
 =?utf-8?B?dTlOWGsvd1RnTVdpSm9rQktwdE1reEVKN1E1Y3RkQmVTeXl3VFN4aitZYW54?=
 =?utf-8?B?RzVBVi9qb1d4dks2dWEyV3FwQldXSUNBMldFRXJKN3FCREFRdE1OYk5rN2pt?=
 =?utf-8?B?RjhDOUlQQVhBOEtsNVUrbFJjWGlkVU9OdngxRkZEc3c1TXY4OVU0RzhLWFJB?=
 =?utf-8?B?aUNpNFBoOFgzOHVhV3dQM25ISW10NGxibmg4aVdObTVzNG9aK1JSMEhzM3ZQ?=
 =?utf-8?B?WVlkNW1LN0Y3WnZTZ0RKenF4Q3p3bDM3bUhzdEVob0xRMlhxMVpiZzJEQVB3?=
 =?utf-8?B?OFVCMzRwQ2VqMTJ0Sm1vMFN0NUdQTWovYkc0ejVCL3VMUWpjL0h3b2ZwZTVp?=
 =?utf-8?B?WXAzY0R3M3YxL21UTjhzaGlwMlJJclJKS2JKcmlUMkV2dEFFdUtnbGw4Qk1J?=
 =?utf-8?B?QkhwdWgwTWhlNXRhWEE0RUl3dXNHT0pycEIvWFR3VnR0OWdZZ29BMEh0T280?=
 =?utf-8?B?bk9oRUpUdEV3VnVGOGpaaTF5bEZRb2g2aWxQMjU5ekxXeFF3YnFVSVBQU2dZ?=
 =?utf-8?B?bTRweGtRajNRd1ZSVnRERkJmTVVGQ3Qvb2tmd1g2QlBXMjdydkladzh6UXFu?=
 =?utf-8?B?dDRsMVlmTDFvYzg3K3hYVnNKSGk1YWg1dlVmdDAxZzVJNnovekMraXZTcGdL?=
 =?utf-8?B?cnFXWnRhcGM3TklFYzV2bXh1c1lVVS9aMWUzc3pITzRib0xEcmZZNngwWHRC?=
 =?utf-8?B?QkZ2bG5hSXcvaU1QZXdhQWdOYWtidFJpUDF1dk92S0dSYmlJVlBTQ1BsMjNw?=
 =?utf-8?B?dktnQWpMSzlBcE4wdWh2a3VwTms1VVZGVzh3WkppeUJ0TFQ5KzU4VDdkc29Y?=
 =?utf-8?B?bDY4YlJJWmZHcEFGa3BCeHdqU2FCUkJGUjROZytXRW5vSHpjL3Q2b2tmU05z?=
 =?utf-8?B?YVZ3VkJwNkRIa1R6b255RTRjRjlhVVY3S1RwZlkzZFZITVN0ekJKYXN6a0dG?=
 =?utf-8?B?NWhoRmswMWViaTBETFIxM2xFMXRGSWNFZWpWeE1GZ1lBVkpBRUxIY1N4SFdG?=
 =?utf-8?B?TEE5MmFqUTVKWnA0d1U2dGg4R2RoS0NocWRCdmE1UDYram90a3UvY1Q2K2hQ?=
 =?utf-8?B?ZlAwU2xJZHFGNWh6VE4yQlRUK0tMUzNUQ3cxZG95ZzdZcTNzYUI5bVRkR043?=
 =?utf-8?B?NDRTYUs1cnVhQjdyeUFUakQ1YWQ2SEtoTzNueVZMaFdISWRkY1poUjNYZFFv?=
 =?utf-8?B?QWhkTk5qOVBOTkU5VHRZNzRwNUZtbVZESlVUWkRLNGw5S0NyenBRUzVhbEJ4?=
 =?utf-8?B?SXpDN1VGYXNyZ2JDaHhsZE0vV0orc1RlcVlxOTZ4L3ozeXo3S0dnb0p0d2Jt?=
 =?utf-8?B?MFdMdDFXVWxMdXRxYmplQXYwMVROZXM4K1czRjhrZktYQnI0eXpxWTdNazht?=
 =?utf-8?B?SWhmWUVpNm5XZlhoVXBzUDdZdEFBUm1OamVFazJtTkhyRFlPbmlzWldmMi9B?=
 =?utf-8?B?T1g3OGZCRUxLUHBPS2VmSU5DYUNoMHpvWjVvcWdCRXd6MGpaS3ZvNk5NRUND?=
 =?utf-8?B?MkV2MU45NHUweXFMY3l6WElKcWQzVE5mOGFBaFFsV3FCaE11MnN3UFJCZWFs?=
 =?utf-8?B?SVlhSWx3UDRqMUQ0OWtNVHRCT25TcExWRzhKVDRDR3J0anhGc0IyWXNNYVVa?=
 =?utf-8?B?L244cVhHblJNSkh4SGZCYVdYUVZ2aWZMcDB3WFhidkRINlRRN1lrZGhoUG1Y?=
 =?utf-8?B?S2QwRi9aNDU1bEQ1OURVNDRXQWVkYVJsUGk0WGc5YS9KcHhtL0dpdmxKMHJx?=
 =?utf-8?B?RGZHWnJReVRHbC91SXZqSnpHbERQYlhUK2lXSmxtVEtCaEFjZUs2dnRaOTMx?=
 =?utf-8?B?S1FTK3JSZ2ZzZnNjMDJTY3VEeDJjdkcremNya2tsSUJ2cUFTS0c1YjBQcHVy?=
 =?utf-8?B?MGsvZFRYeFBXYWtPZUR4dGJra1ZZS1hMT2xKOEE5ZXFIQWVxTnZMQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8EE5B0FA18AD7248A871BA6772D99D79@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: rALieOtduFWh+IgyfEvZbSLQvUpKgW0NvRfCq8Aj5Q3VXhU6fCNGE6/FzpFNj7FcBRTNsAPR8P81EU7X0QG8VjGJlm4QbfSSGGS3GL8K+NnmG3PIIj8knDe/4Bw40rcXkqEpWXtKGAo3ClNNKwmMXMRNLGFLfdtGXS35loQ2WD8+Pp0zGX7ByrXmcFsOggE61OtTX0g4kKd7zysdsZqzLSebo+cBJbXYFAM0hoIE1qjppNKybYBF1rmnwaHt9ZaB0Cw22hMxja/dQ3MwVak1ZB50KAe/OWGP4p7t0AKUPHZ2qQ2zgCxErCqudgOJqyLXbs0Q86hMfxYSNY/9U7WSng==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ec32246-8e70-4209-728e-08deca81e421
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2026 02:00:36.0037
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0U+3xbi5halUTMW37gpa5VbzaKq8gLL/EvzNZ0QPmcnOC7kmier9vrGjrWpiNRjmzogBwFWvMcllGSzb0+UJPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4881
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTA2LTEyIGF0IDExOjU0IC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBVc2UgY3B1X3BoeXNpY2FsX2lkKCkgaW5zdGVhZCBvZiBkZWZhdWx0X2NwdV9wcmVz
ZW50X3RvX2FwaWNpZCgpIHdoZW4NCj4gZ2V0dGluZyB0aGUgQVBJQyBJRCBvZiB0aGUgcENQVSBv
biB3aGljaCBhIHZDUFUgaXMgcnVubmluZy9sb2FkZWQsIGFzIHRoZQ0KPiBrZXJuZWwgaGFzIGdv
bmUgd2F5IG9mZiB0aGUgcmFpbHMgaWYgYSB2Q1BVIGlzIGxvYWRlZCBvbiBhIHBDUFUgdGhhdCBo
YXMNCj4gYmVlbiBwaHlzaWNhbGx5IHJlbW92ZWQgZnJvbSB0aGUgc3lzdGVtLiAgRXZlbiBpZiB0
aGUgaW1wb3NzaWJsZSB3ZXJlIHRvDQo+IGhhcHBlbiwgdGhlIGFic29sdXRlbHkgd29yc3QgY2Fz
ZSBzY2VuYXJpbyBpcyB0aGF0IGhhcmR3YXJlIHdpbGwgcmluZyB0aGUNCj4gQUlWQyBkb29yYmVs
bCBvbiB0aGUgd3JvbmcgcENQVSwgaS5lLiBhIHNldmVyZWx5IGJyb2tlbiBzeXN0ZW0gd2lsbA0K
PiBleHBlcmllbmNlIG1pbGQgcGVyZm9ybWFuY2UgaXNzdWVzLg0KPiANCj4gS2lsbCBvZmYgS1ZN
J3Mgc3VwZXJmbHVvdXMga3ZtX2NwdV9nZXRfYXBpY2lkKCkgd3JhcHBlciBhbG9uZyB3aXRoIHRo
ZQ0KPiBmb3ItS1ZNIGV4cG9ydCBvZiBkZWZhdWx0X2NwdV9wcmVzZW50X3RvX2FwaWNpZCgpLCBh
cyB0aGV5IGV4aXN0ZWQgcHVyZWx5DQo+IGZvciB0aGUgd29ua3kgQVZJQyB1c2FnZS4NCj4gDQo+
IENjOiBLYWkgSHVhbmcgPGthaS5odWFuZ0BpbnRlbC5jb20+DQo+IENjOiBZb3NyeSBBaG1lZCA8
eW9zcnlAa2VybmVsLm9yZz4NCj4gU2lnbmVkLW9mZi1ieTogU2VhbiBDaHJpc3RvcGhlcnNvbiA8
c2VhbmpjQGdvb2dsZS5jb20+DQoNClJldmlld2VkLWJ5OiBLYWkgSHVhbmcgPGthaS5odWFuZ0Bp
bnRlbC5jb20+DQo=
