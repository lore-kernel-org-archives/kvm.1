Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BB5378D63;
	Thu,  2 Apr 2026 23:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775174046; cv=fail; b=r2hdljR4ALQRJjjI+l8bukGgzVe7o+ocA8Z21UpEJc7/9xZ9qkngl+FacoWd7nUqQ2orpbrPnvDWUuA7m8NgJEenuhocHNnFZyQL0ZiaoiZtfiy/O8ddEvLdQioUwpM3K/gRlZHGLALTCcX9NPvHXkAvJ15dZEycuX1Kkc357LU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775174046; c=relaxed/simple;
	bh=aYvMiutzBimuSXvn3UyU7BmE5Grgfl/fXjuwMZFQz84=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QZixGOdm7rd5h6tBVqMYChVfVdl39tSi6h9h6XDvxH2VUto5m9cp7foPjfWKOpuGUK74Gu+K1hapKXe6K2N0Ns8nOmSqcI8EJTM2Mo0APMJEJ1x7MHJzFCtVxGU+QbXMSuHg1Sm5O1TiLb25e/ZQLNhv1Ys16+ZMW0VpceboIFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dAk1U91G; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dAk1U91G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775174045; x=1806710045;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=aYvMiutzBimuSXvn3UyU7BmE5Grgfl/fXjuwMZFQz84=;
  b=dAk1U91GQbq8s0N0Z6miu+rxcBbGhLXxOi5NQShvYftnJ5wuN0TO8XIq
   Q7cW/mwFl62Vf/ASfRpGPSjkyVaBjz6TTVCJg9ij6ZCGLmFvZTVTx2wff
   l0+30JQ5JdbQqPWArXhie2QDLjhtxJERVz09NVULAhW0tc4NIBpo/9tZD
   K0VHs3gNLF7zGxDQvnUSaZFLccNYqOECIqw3ChaOxNlxn7FB8d32/Wpif
   YMkc4CJb2E5Zk4cYXMBMB0ol9q+3im6q8Jc7vYP23NP+gJHtPkS9L09mo
   UKTvmaIw5pzoZ8vSzwn+jEziGnFuWmN2pr8ymlStFjqSQzQSFkEKvbJR5
   A==;
X-CSE-ConnectionGUID: JSwooiIbTGO09ZZxIsAZTg==
X-CSE-MsgGUID: KDQvD7R+T0yFsMFRkHvUiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11747"; a="76433086"
X-IronPort-AV: E=Sophos;i="6.23,156,1770624000"; 
   d="scan'208";a="76433086"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 16:54:05 -0700
X-CSE-ConnectionGUID: +H6bUHoMTI6wjLe4lzUzgA==
X-CSE-MsgGUID: KVwLF8E4RP2n/nOed2vzWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,156,1770624000"; 
   d="scan'208";a="226984731"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 16:54:04 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 2 Apr 2026 16:54:03 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 2 Apr 2026 16:54:03 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.56) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 2 Apr 2026 16:54:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fSkVULCD5r8ixDEt4o566OUfWUnj/mc1nqKDl6q0087z+Nfszq3AKqoQGM2NTpPYWAhCfg/6vI9gB2wqV3EqcL4mLgk9+K7+LfHxHpBVfaAmjbiJF5kTK6USdy7q3QNbILAoH5PzJWR7aQt+awVBEbzvfhgAv+ES0cDSaNHizQykGpWEJFdYi+3krMxq12f0l50aZ4f9uMZfD4894pyYRXYyJH5R0SeuyVlUWRnZ1ZjzVvroepttyIFVk+zbS/UntZqt2qrGWOP7ApmjV7rqly4cUMbqmgqW5CmIA1qzjJf7MAuib2e+GmHhzFXCTZP13eQnfPebjr/CsYVJdO1LHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aYvMiutzBimuSXvn3UyU7BmE5Grgfl/fXjuwMZFQz84=;
 b=ChcOM0Laii3OX4Hw7tQztfTYJgcPrvBkI36BNAVJ1tAQpxph7eq5zTHUxvrH+uHekiPMpzPHDvREcolcbZskADb+FwIWEzKiUNtAQVaTzz+XNz1M7RTkKhoPi7av5MKR26zaDE0taMEeuCjR/1Yen+xhMeESowxXLl6BD4vq1G96x1bfXjyRwqSJMQbB8thP8n+0964/TZPp9JLsDxWPAjt9D7aJAVFCX3EcSomcKw+9+RFV+rzzifvkQ1nyKm61v3TJoY+3mjtLFV1CG8LWFt0HGjXnQqv5th9lCU/xojQcjsscsQzRlaofw+OWcsa8WzRr/5RhkqL84AyT7hQgAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by DM4PR11MB6143.namprd11.prod.outlook.com (2603:10b6:8:b1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 2 Apr
 2026 23:53:57 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65%6]) with mapi id 15.20.9769.017; Thu, 2 Apr 2026
 23:53:57 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "seanjc@google.com" <seanjc@google.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Huang, Kai" <kai.huang@intel.com>, "Li,
 Xiaoyao" <xiaoyao.li@intel.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kas@kernel.org" <kas@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "Yamahata, Isaku" <isaku.yamahata@intel.com>,
	"ackerleytng@google.com" <ackerleytng@google.com>, "sagis@google.com"
	<sagis@google.com>, "tglx@kernel.org" <tglx@kernel.org>, "bp@alien8.de"
	<bp@alien8.de>, "Annapurve, Vishal" <vannapurve@google.com>,
	"yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>
Subject: Re: [PATCH 1/2] x86/virt/tdx: Use PFN directly for mapping guest
 private memory
Thread-Topic: [PATCH 1/2] x86/virt/tdx: Use PFN directly for mapping guest
 private memory
Thread-Index: AQHct0DWySj+AXH+Kk26T1K2yM7v+LXMgOoAgAADgACAAALNgIAAAjYA
Date: Thu, 2 Apr 2026 23:53:57 +0000
Message-ID: <053e97800cae24a936a4dd6ab836b03571c6e970.camel@intel.com>
References: <20260319005605.8965-1-yan.y.zhao@intel.com>
	 <20260319005703.8983-1-yan.y.zhao@intel.com>
	 <CAEvNRgGknoP=QscA-efLB0LSS03XttsdN3v0KBVROAXTknAakw@mail.gmail.com>
	 <4f0a5d5f7b743e3872547e14d02b894cd9f60550.camel@intel.com>
	 <ac7_uQc5t0uU3a1h@google.com>
In-Reply-To: <ac7_uQc5t0uU3a1h@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|DM4PR11MB6143:EE_
x-ms-office365-filtering-correlation-id: 357083fe-27dd-4194-7fe8-08de91131ac9
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: gaKZ9wxwqimmyvxoUzLFUq/FYfkmkd8nvuzrNoREOvEJdaSM1BpJbkCiuSkorWHZQLB76LJwy1YM/ZkdUay4Y0tQp+SVk9BgO8iWVdCI+vsTkWSAP0yyzDxrS3uxXhPJqv7bMia1V+b+TUqg1Et2TJkLsDbzRMAIHQawefsEYATf1tivGxVCIfyOPboV1Dmy4p5IpJZFZekvCkxniasejl8FltpcVPuGNZ8O8dWMs7ULZTmsscFJ9B4uKVwevhLJrYRmmPMAY5hbm9CBKBol/A+fcyyVAOLdzsQ0a9Re2AIANSNj55gINMjrHxFRNCxHkXXl/lJsJJEbGg2r1vxyWkbUwTLuscz58xkGE5gZR3I1FlVFyG9M90Y3MTOttGCD1YZIuYCKMkti4fljsaj9y4b13c3TzlQYAIzHGvvQ7dWBEtTyPwJXfwdJfPSpwkSIw3pyhZisxbmfTuJ8CDQkrEzIKBddC51WmhsHVM5jLcSftVXv2WGcj6uSei2aiTJ61MWz32Fofq+nTUWRBd9kno+eHDT5g/7ny/LjOzmLBKzSQmTZixa84L/IE4cnGxxO+sp+qd7UcCqSfSwO+ZLGuYDLBOW20mFMoA2MTZrhC/AuGpXE4wCK4Qag01lEI3lW48PzKc6Hbo7nHuup2PI4BC6oDcRxzMHUO1E2vqA8JOzFaTRk45PHmdUO2TOydLpQyiscWF3FzlJ6cqR4czJtH3WwOCxda73ga2lNdTzXl9YHSbFxNiPTrjI0zxuBMGLyTb/d6fkBNLQwMMeEJdeF1eAbmB8VFhKfPKyzu/U4qkI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?alJSU3dvcW1XUW9INWV1M3lJeHZMUVQwdm8rb29kWjdtS1pPU1ZkL2taS1VR?=
 =?utf-8?B?OWM0WWdyT2tnSWdUN056NnVrOUlkTDhYbHdqMGp0eDY2bzhwTFlkNWhRRFRt?=
 =?utf-8?B?YmRaM1ZJcWxxMVdhVmdBNlAyOHpiVFNzbHlEL2pUS1k2b2xXYWNPRkRFSno4?=
 =?utf-8?B?WVRwdXlib1Vsa0lPUW5laGUrVlh5SCtmMkczYzlzL0Y2Wk96aTJscUZGdnZa?=
 =?utf-8?B?dGVIbG9maHFOcUxsMUxWWGwvUlgrYmFrWmdBbVg4dE5uR2ZXcnA0ZTJJTXkx?=
 =?utf-8?B?NFprdElsTmhJYWJQZm9LUkcyMnB2L2JZQUpzcnFEOWFGVWhTQlo1QmFpaFV2?=
 =?utf-8?B?Z1lqdElyZUxXamVwUmpOcUxUUjJFZ2RUZ0E5WGxCcXkxSHo1eHZCdnVJcmJr?=
 =?utf-8?B?MkhHNlAyT3l0VWxaQk4vWE13U3lYUVNwbXVJbEpHblN5WTV1aDA4MVRtQTZq?=
 =?utf-8?B?alhCbnNrdHkyam0vQkZoeldjQnErcjRua2RDYXNTQzY4Vm83dzVVb3BBR1pX?=
 =?utf-8?B?OCt5cVo4R3FzbUFBY000WGdsWmdWby9IMjkvNFdGWGs1M0lHTzZlMm5sZ2Mz?=
 =?utf-8?B?WUsrTW83bWZNa2tFU0p6VXlkbW5kV3lDdUxnaG82RUQ4S1k1amIwVlF6RHYv?=
 =?utf-8?B?MmRxMElnaTJNWUk0OFdJRlNKMkpWWTB2Tlo0WFRRdFRueGtvWHVlME1Xenlh?=
 =?utf-8?B?N093R3FrTWdXK2preW4vdmUzcHQ4S1lQUGZ2aHQ0a0xhVXQxTTFTa0UwSW5k?=
 =?utf-8?B?OVZMVUFOeFdaOHJvWlpWQ3ZEaFdmcE5SeG5IR0g2MzFiczh3c3MrZys4a25H?=
 =?utf-8?B?eWZvNzZLdzJlWEN5NHBZemtPbkY4d2dKYWU2NTdaNkNvM2RwbE5TNS9XMFlw?=
 =?utf-8?B?VngvblpnaE9WWmdEMGplSU1uUTNMMmQ0TnpkMTFPbWFrTlhHMlRCcW4yRXo3?=
 =?utf-8?B?M0ZSWFVzcG5VSkVWWUNiQWxDSVBOUnRoUXd6S2I5US9SQzh6M1hnTWxGWTh6?=
 =?utf-8?B?ZURSUlU5Z0pyN2thbTFScCt1OFJQUDdZM1RqdWQrUkhOVUNxUXloN3A5M0lp?=
 =?utf-8?B?K1BKQWt4YitJS0xZSEpQcTJKWUtMcnVsak5LOHJGVmZudGRQVDB5Mkt4VFpB?=
 =?utf-8?B?c1l4ZmlQK09kS1lnTU1qc3J1WTFBMG9GSDVSeWVBbEF1U2w5TDQwMjFEQ3lp?=
 =?utf-8?B?dXA5NTIwV1NMS2hhOHlXTUNUeFVPNE1tMmFaUHhHakIyN2FyVXNyaWRvclpN?=
 =?utf-8?B?dDQrNENOc0w3dThoeE8xVUdWaUtQNEM3V2s3NEx6K0FwWnlxS1Y3M2Roa1A1?=
 =?utf-8?B?SW5idVZOS3FJT3ZnVTJudGtmdENLd0R4N0pMZkpVa3EvMFBvaGxFWTM2WVFx?=
 =?utf-8?B?NGMxVXY1KzRQd3NrdUlnd3hDMytpRGZXQjQzR1JLT2tSSENCdVZmaGM5RzRv?=
 =?utf-8?B?dlNOSEdaemk3bDMzOUZVRXNoTDQvbFVMQUdTWkgrTVc1cW1KMWZ6UDA3KzBW?=
 =?utf-8?B?QWFVNHZKMFN4ZWhBZTZ2N25FTFZSSHloKzJva0FuVnpYUDhvN1Q5Rmduc3gy?=
 =?utf-8?B?dWVuVG83OFAwV0V0djdNMStjQ05YMzQ4Z2xFeFFkdTU3Unh6eENBLzdYRkx3?=
 =?utf-8?B?SjlRai9YeFNDKzY1SjYxcmljcXVoNkFYOXpHRkpxM1lDbTdlbWdXa1doMHdw?=
 =?utf-8?B?cGtDRE5EbzNyeldVOU85bExHT2NLY3ZJNWhRZzdnbW1OMmVwdlBGMjE3Tmw1?=
 =?utf-8?B?TUhKL000T2hoeXA0WW5MOFdVcmttOEd3VmJqU3lZZGg0NXNiUkZKMVUzbSsz?=
 =?utf-8?B?Q28ydGpGODlLNzRndU0xWkhWa3E1NE5lQW50QkxyU3lHMFNBZlVvMVJ5SmFK?=
 =?utf-8?B?WDRLellQU1FwT29Ta2VrWVExcG1uYnE0NkdrYkVYS0JjL09UMWJZd0hpVHo5?=
 =?utf-8?B?ZlVhbWhaaEtVWkJVUTR5MFRvcUJGeDZ3NjJJclpvTm11TUVqL0xLQjhEcEhW?=
 =?utf-8?B?RFRWcERCZ0lGbTlWYTNGZzAyUCtrK3plV3VDc3FzZlQxVzViVTk1Y2RuRzhl?=
 =?utf-8?B?eHp2VnRDVVR2eitKMkpEYUIxbFExSDhKaHBYSzJIV2xxOVRhNHNucmpjWnoy?=
 =?utf-8?B?bWtqYmpsZUNQSTVFSjBpNVN6OXFWalV5WHhJN3kyV0xpVlZUcHUxczE1ZjlT?=
 =?utf-8?B?SGxFRjkwd1J2dmJqVjZad20wd2FkS013NFZUSGVhNG5vMHkyQ1k2WjBWdHZC?=
 =?utf-8?B?d2xHUWNEYnNpMzF3MUJvU2tYK2lDMi80eWdKd3BDaFpKYXUrb2w3dDlIM1Ey?=
 =?utf-8?B?V0RxdUVUQUlSdWlNT2VXT1BveEVwVnh0cFFXSFl5Qlg1RS8zUnBJb1dBdjZl?=
 =?utf-8?Q?WpheIRhb0jB4Fy1w=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DF9187DAB4DC6144B16D75BBD77324A0@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Qvq9AbVooNNSBuuRhyMhMGM0y9BlYzgEQvTEWuoUOdYvF+cdAaMjNIdMjNeKHQemFR0FkfT224U3hbzf7mkwEfHzfwtm5fIllzshbw4lOkD/sNCN/IVsxINb4taxX+Sylu1i/aGRQhufVNVKqlzzG1Rp54dyq88nPaEykbRuA8Z8++RkUWTN8dXzNJUNwzFs129b8H7COCYqBk0q4CQkW4vjpmnrhCAyZ0KrB1qMhpRvbIU0oHipFIeCpYtg5LVB1fADRU1BtWhw6dYy7FeYLwyNj9oT5vZ5OBeZ8/VqQVA04KSeMScof54k7m5Gzosa8/qaCFgw6ZSCbwm7yxdeuA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 357083fe-27dd-4194-7fe8-08de91131ac9
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2026 23:53:57.2721
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oubYeiE9B8yN6s2ALKaf1/lLlvnve0o+3tknX1MlO+MNvrLCYjAyJu+W/qxTDqfogeCmWrGCuT3b1V2UMdXAH5EoJ6+r18hzy8UPLOlhzEA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6143
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI2LTA0LTAyIGF0IDE2OjQ2IC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiA+IENhbiB5b3UgcmVtaW5kIG1lLCB3aXRoIHRoZSBuZXcgQVBJIHdlIHdlcmUgZ29p
bmcgdG8gZG8gYW4gaW4tcGxhY2UgYWRkDQo+ID4gcmlnaHQ/DQo+ID4gVGhlbiBJJ2Qgd29uZGVy
IGlmIHdlIGNvdWxkIG1heWJlIGNoYW5nZSB0ZGhfbWVtX3BhZ2VfYWRkKCkgdG8gb25seSBoYXZl
IGENCj4gPiBzaW5nbGUgcGZuIGFyZy4NCj4gDQo+IE5vLsKgIEluLXBsYWNlIEFERCB3aWxsIGJl
IHN1cHBvcnRlZCwgYnV0IGl0IHdvbid0IGJlIG1hbmRhdG9yeS7CoCBQcmFjdGljYWxseQ0KPiBz
cGVha2luZywgd2UgY2FuJ3QgbWFrZSBpdCBtYW5kYXRvcnkgdW5sZXNzIHdlJ3JlIHdpbGxpbmcg
dG8gY29tcGxldGVseSByaXANCj4gb3V0IHN1cHBvcnQgZm9yIHBlci1WTSBhdHRyaWJ1dGVzIChv
ciBhdCBsZWFzdCwgcGVyLVZNIFBSSVZBVEUgdHJhY2tpbmcpLsKgIEkNCj4gc3VwcG9zZSB3ZSBj
b3VsZCByZXF1aXJlIGluLXBsYWNlIEFERCB3aGVuIHVzaW5nIHBlci1nbWVtIGF0dHJpYnV0ZXMs
IGJ1dCBJDQo+IGRvbid0IHNlZSB0aGUgcG9pbnQgZ2l2ZW4gdGhhdCBUREhfTUVNX1BBR0VfQURE
IGl0c2VsZiB0YWtlcyBhIHNvdXJjZSBhbmQNCj4gZGVzdC4NCg0KVGhhbmtzLiBJdCBtaWdodCBz
dGlsbCBiZSBjbGVhbmVyIHRvIGNvcHkgY2xlYXIgdGV4dCBmcm9tIHRoZSBHVVBlZCBwYWdlIHRv
IHRoZQ0KZGVzdGluYXRpb24gcGFnZSBhbmQgbGV0IHRoZSB0ZGhfbWVtX3BhZ2VfYWRkKCkgY2Fs
bCBpbiB0aGUgbWFwIHBhdGggZG8gaXQgaW4tDQpwbGFjZT8gRXNwZWNpYWxseSBpZiB3ZSB3YW50
IHRvIHN1cHBvcnQgaW4tcGxhY2UgYWRkIGFzIGFuIG9wdGlvbiwgaXQgd291bGQgbWFrZQ0KdGhl
IGNvZGUgbW9yZSB1bmlmb3JtLg0KDQpCdXQgaXQgc291bmRzIGxpa2Ugd2UgZG9uJ3QgbmVlZCB0
byBkZWNpZGUgbm93Lg0KDQo=
