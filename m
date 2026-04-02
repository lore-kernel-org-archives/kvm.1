Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88C02BEC2C;
	Thu,  2 Apr 2026 23:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775171432; cv=fail; b=YanDu4M8EaG/w+/FGp4Ij+wlEoV7CJ+V+XbuESMDdUNWkOqu+1KY+4qlFJ1Nk1M625Y9L58WDWP+sJ4oFkmnl8tLpEFw+8rX3K1VXOEyRJTlVGmNWsNHHsoVS0kXHqhGQkbJOzb7dlO4wvSKJrbZ6/rYtdCzp0m8z0JGlTi3eJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775171432; c=relaxed/simple;
	bh=SK4aZ+/WQspxOOp5Hwt2QZ5Sz/pb6/1/tGF1GJKbGvs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lsXtvS2b8aMiMNglO0K6xxgSmzNVe+ddPepVUbc9EV/OezzHkRc//PAI2rgFB7hF4CIN2+Z/NuVL/P0V8AAhx3vpdlj3mSuztipu9UZ+F+I9MNYTn/eE5jTEgD3a3Hm58pHg0E0f9Qt0m9X9wEkNrGyT+UcezuqKJLITUGNYo2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wh3HvaE2; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wh3HvaE2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775171430; x=1806707430;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=SK4aZ+/WQspxOOp5Hwt2QZ5Sz/pb6/1/tGF1GJKbGvs=;
  b=Wh3HvaE2tFT1wbJ9861O9pfGs3DQOXemnN194efDg7CIAC8HBJrniV2J
   WaljOdh4WrytfY6w60qou/2FMWLls7vIbowxnEhEu4oxEwFVp0p3lq8ix
   bG3XlxWpWYtWS2uNo8iIVeIHjk5VCR8cM+Lo+pG7f9VJ/BeZCKL0nquFj
   cwjLQmrZSNWth8JymyRgofFpMb9UAPqT5jgEz4zSY0GR0YZLl/pKoUzGN
   GSDcg8LHUHIXXGQgDjPSpRyODfK4Z9EXDEHdKo639HZeiFnC5FnCekBIW
   IawUmjfEoUJ56ocSS1mCeVvXo2sTBtl1dafdCqSXFHFq0XLb2Fpx8Nf9k
   A==;
X-CSE-ConnectionGUID: akzpYbOTS6S1HZJw5/DtuQ==
X-CSE-MsgGUID: 9DN6fmpMSNO3WIh9rCgnFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11747"; a="75959824"
X-IronPort-AV: E=Sophos;i="6.23,156,1770624000"; 
   d="scan'208";a="75959824"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 16:10:30 -0700
X-CSE-ConnectionGUID: tVxv/o87Q1+ubJiqcgphKQ==
X-CSE-MsgGUID: u4NHscvxSCm73iuSZLEhbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,156,1770624000"; 
   d="scan'208";a="222753105"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 16:10:29 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 2 Apr 2026 16:10:28 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 2 Apr 2026 16:10:28 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.8) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 2 Apr 2026 16:10:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qxr3U7odpSfFm412yLEx9xFLQ+5AUjilfNRAL12CQdTr8fD02lIEgyzCDEgStjOwBHs+CPKBXiZeVV5FtW+Ss1rs1wuuIsXQRuiFdbyRTsn555S6DIfNFJEkztsiJlxRwcZ/RjbAJir702vhvmyVt2a5BuL5FjmIyuLDvrcw+69XwG5xnTOtuSt9gPRmuZ0c6aCfxhLubvepXwxUIoWGX+uEuHOow9ex+U8ixJ9zpSC6wQqUlQPD9OkFGW2/vRz0fIN2ctBPDEU21bXjSrXyozAe6h1/ITdcRopcxYftUsKfJvqXM+W/Sqffm/5KraU+lPwm/H9Uv0QaFDl68rZAQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SK4aZ+/WQspxOOp5Hwt2QZ5Sz/pb6/1/tGF1GJKbGvs=;
 b=HUMoDB40IAgj5pIWRAGLJn7YNoJBRM2mYVHbYbgLrRx6Lsl2P5DL950DPUYZd/qMpsoO1TvCqZEeYRBxNcCbkCrcGqXg+Cwku1reeAm2NgG6bGP8LkaZH2F4hscOstSyl9Af6pHrRS5FVHrRcsCkJEBIHgX1SFmdsbnHwIduf/o58/ZlnL7bDthmOWInRAM1NgBlEE8b6sU89+c06KntYv0avzvkyY91LYnXr5LwIYatInvg7QklhqMmtM4wLDGgCqQwEsuwKxXO1ryCQqnf7SdL3c4lEOk5Gz208tFLnp8Lo/JmVA0+EYZdNjDgiZz9b1+ovAfIe6V3yA0gGInr1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by PH3PPFF2B8F6C64.namprd11.prod.outlook.com (2603:10b6:518:1::d60) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 2 Apr
 2026 23:10:19 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65%6]) with mapi id 15.20.9769.017; Thu, 2 Apr 2026
 23:10:18 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Zhao, Yan Y" <yan.y.zhao@intel.com>
CC: "Hansen, Dave" <dave.hansen@intel.com>, "seanjc@google.com"
	<seanjc@google.com>, "x86@kernel.org" <x86@kernel.org>, "Huang, Kai"
	<kai.huang@intel.com>, "kas@kernel.org" <kas@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>
Subject: Re: [PATCH 07/17] KVM: x86/tdp_mmu: Centralize updates to present
 external PTEs
Thread-Topic: [PATCH 07/17] KVM: x86/tdp_mmu: Centralize updates to present
 external PTEs
Thread-Index: AQHcviZXKVkTxmL/NkWOkEaa1Zh4L7XGnJGAgARKfICAACVXgIABYwyA
Date: Thu, 2 Apr 2026 23:10:18 +0000
Message-ID: <4dfb4c106c834cd13da78872bfb262e98581fa55.camel@intel.com>
References: <20260327201421.2824383-1-rick.p.edgecombe@intel.com>
	 <20260327201421.2824383-8-rick.p.edgecombe@intel.com>
	 <acoUt9vy8OPU1SW9@yzhao56-desk.sh.intel.com>
	 <8a107d4da92d4cf910f9a70991a0e67b42e04d4f.camel@intel.com>
	 <ac3Ng7IZpzJczZ2x@yzhao56-desk.sh.intel.com>
In-Reply-To: <ac3Ng7IZpzJczZ2x@yzhao56-desk.sh.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|PH3PPFF2B8F6C64:EE_
x-ms-office365-filtering-correlation-id: 0e0a20a8-350e-43f8-ebd6-08de910d01ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: O554GKQCTFVIA1F4i5mMELH6CInYdV5otyvKZeeuf3DFqBJfbMr48PjrNv9HCIOMw1ciNxnTQz3cCKyjPgwIHLyGy76YsKtOTwCFK+icwdMciN5WXcFoof0RCEDW4uBgxY4BkEaX35mU7cRbQdoD6gckeLNyWoTe6m7lqaHZLuCBgQw3IWh1JOtIB2DpAaQu5wjjRvuAcKCwm8KzNdpUaLFqVFLF0OjEoBzgQe+lBXHmw/iVeTAqj+TE+1WbjCWQghwaUYhye53CrE2tBA3/AKJ+2NK0HXNopHke7Pn71I7T5FCuX3EBaSpL90QGyEWU1X6wJjElFWYbuxtQIXAPb3mCuwFHkbrkfgT6SQENFapsd8h+BahBZDZbk4ca2XoZob79K543d3PuxrsA+8jFTRKNwbaACZNVBz/3O56xEkygVi2IEhVsz5McvmFnPkUYhtH+ggb9gCViYAaV/MlPB3jsZ2zqBBX6BY99QeH+CgC7GsqlquUDJesyuU97oaUWUQofQLhBjx8VVJlJfdPMMthLa6kHQbBGsX51+PbuZ5OMidF81qeLzxB8uI2lM2GO32pypL1XCONoNemJDHItZ5U3HqsfFtDOwnjW55jcKyQYyFcTEEipHGP9SPKmb/svw76/fTYFyt5xTZsWomDrS7m1TKkC8ZDz/OPiEJdVdKpY4d/AcN8PG5B9Wz4giJ4spjpgWqTZ/tYneAxu+T1VE5s2XAeKK98vRGGTguH3gfKTwipFdGciucUljsh19Wi3n6OMfISTlg5JP0FpTZWupQY1uk8sieqOxtTEchBNTo4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RWhvZC90dGcwbUNNZXY5MEhCSmxFV1JNUVc2dWFVWEdyU1cwWERETkJ3dElJ?=
 =?utf-8?B?NmNHTEhiVFV0eUVxbzRCWmwzZXduYmtQczVaaFFDYnV5U2w0QUlOSHB0bEN2?=
 =?utf-8?B?VWdKNFBJakhOU0RvRzR2UmRVRXcySHgxcmpqYW5QN0VEb0V3MExMK0tCRitQ?=
 =?utf-8?B?d0VXT3h5ZlNEVE1oM1lMVkF6bitqMkVJUXc4V3hscDRnTFZDL2xXSHhpdFhp?=
 =?utf-8?B?bXJQZEFCMlptWmdzZG80RHlpODZhZkRHNSt3OWxHbHRJRnlhdWpSdzQxZHI4?=
 =?utf-8?B?NHltbUFVNTFPSTdoMXdCSjg0aTZRQ2NERW4vWVdLdzV0dExIUUEybysrMFMx?=
 =?utf-8?B?bjhJaTdDYWRoQm1LYjg5N21jZUY1T1VPWG1NSGZ2OEl4TVBuc3V5WTkzNEl4?=
 =?utf-8?B?VzRqUzd0RGNoQSt1OCsxMHhVSklJTjh5bkowdWxlZWJWV3orN3RDdXluaW5j?=
 =?utf-8?B?OGxEMkQ3cG44cThSSzhHbmJwOTBRVUN5STVXKzRRaWVONC9zQUUzK3F0M0hv?=
 =?utf-8?B?ci9qdGFzVHlmRnFUa0hjVXJqRTlqWGwybTJRMjVSbmhNK0lBYysvQkdqNmxn?=
 =?utf-8?B?T2Z5eW5rdUJhbjV4UEpuRVU2MlBNOXBGU210Z3ZZSEtoRWpTYVJ2UHY0U2lH?=
 =?utf-8?B?R0oydURBWE1QVGVRSTEvNHlvVUJBODByVG1wUEUwbHB3L3lNWUVDSjY2bWJU?=
 =?utf-8?B?blhTTUtpeSt2TkhnYVdWT2dRWVpKWWtRc0sxMnZvRFE3RVlqb1lLb21SdmlJ?=
 =?utf-8?B?ZGpxam9mamJVQjR6amhZR0hrbE1hR0V2ZzNXeEJJMTNHVjJrS3V4NVdsSFZI?=
 =?utf-8?B?SjdyMzVZWXcvaGJuL2crQVVoU1hmdWhtZ1RmUXhEL3dvSXh5bCszWE91OEM2?=
 =?utf-8?B?d1Q0WHo0akg3WXN3aVd3aDJwSWdvMU5LV2c4ZEFnMTY2Ri9MN2U0OE1ZcDZx?=
 =?utf-8?B?aWl4bFp1MFlEOWtwN0s5L1F0UWhYekovT3NFYVJadVpMVlVJUFBISXFlMnR0?=
 =?utf-8?B?Y3ZOakwyVmFxY3lSMlVTY1pZcnZ1ZzMrbmdLbm9leW1HOXc5ajNydU1iUFdV?=
 =?utf-8?B?TXdoVzk4Uk9hZ05xRUU4YTByVk5Yd2VucFNybVhWNWxsR0xqbVR4ZVlvSVVB?=
 =?utf-8?B?dzlpVDJuSVFBd3hUNlQrT1d4dThrVHVEN1VLNlMrUklneVcveENHR2xzZFZL?=
 =?utf-8?B?UmxLUEJ4U0VaNGpuNkgwNXRhQjNiSDExODNvcDcwa0lNMWtpR0g5ZEowcGd6?=
 =?utf-8?B?ZmxmT2U2VWRFajdQZ3gwNjBCRzlEL2F3NGp4WHA0RGVteDhxZzRLeEp2dmxl?=
 =?utf-8?B?NmtrUyt6Z2NLSm1SUUJuakNqSXlRR25YTys0UTkzL3pIbUJWMDRMKzBGSXBI?=
 =?utf-8?B?MzFRVXhRQmRaYWNNQnRoQ0JLNDBIS1E1QW5PeVUxUkUrbmRkU1E0WlN2WWpZ?=
 =?utf-8?B?cGl3ay9DOUJjTncyc1FLYXBaOFdkOW5PdVJieENPdXpKdUJhUHFMQUdxVTBs?=
 =?utf-8?B?b0NWTm9RdkY1eVQ4R1NsL0RINzhCWXFjRzFhMlA4VXd4cTZLc09NRlZGNmlG?=
 =?utf-8?B?ZFRCY3VON1ZKeHVSU29EK0R6aEpJNjZSVThRMnpMbkh2ajRramt0WUhJWURT?=
 =?utf-8?B?L0tzYXIzc2hULzNLUEdpUE1wdVI2NGo4c09rclF6dit1SUV1TmRWdlFxMCtq?=
 =?utf-8?B?bEhLcGpSTE5kY01maFdxZ2czOWo2cUJxU3dlQUlNQ2V3a3RIaTFBbzZqSFFr?=
 =?utf-8?B?L1BVOVF5MHJUTFc0RGJEandOMkErOXFsVGRNanVvalBlNmlyVmdKN2lXTm4w?=
 =?utf-8?B?aXlBcWIrNFQzQ0pIWDhYb2ZYcDc5c0YxRDlwSlgyR0R1SmRoaFlLbi9aOGpT?=
 =?utf-8?B?a1crVkRyUVRsWDh5K0UxUC9KZmdSTFY0UzdmT3RLQVA2UXEwRkxWNDhMeU1F?=
 =?utf-8?B?OHF2L29BM0hjU2g4bGYybzFmUUtiR1d3MXZUSkVGMlU4NFl2K2RXNXV5YVBS?=
 =?utf-8?B?blhvbWVHRG14OFhDaU1FajA0VWhUdUtRN2tNL1h4eEFhSXRWNDN1OFJkUEtK?=
 =?utf-8?B?SEZ0biszZnZnaWdmQ3RSQlJPaDRPSjQxWUlRM2c3UWFFSG85MDhsTlUzRWJE?=
 =?utf-8?B?b1Z6NmhIRDcwRnZjTkxjTzh2U2cyTEZUT29iN1JCTlN1WUkwaGJISUdTbFVU?=
 =?utf-8?B?WWRrZy9TVXZhMjN1eUtLZDNZbU9HM0d2WmxxdDB5Vk9VemZ2WmUyQTBuak9l?=
 =?utf-8?B?U09ZSWJkQ0pyeVRQNW1hTHFDRnZpT0diM0lmLzN3TjVEeFJyZVZRakZUQlAy?=
 =?utf-8?B?M0NGUTk3dnhJck53NitXNXVYaWJJeXA3SlAyVHdnZGYxbldodXRpa1pJV3FF?=
 =?utf-8?Q?9NHcdRrLl+MM0bbk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D547C6C5041140499D3225A3DFC56C18@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: MtTlIGjAFIyv7sdWQK6Zi5FDNuJDe639OtepJTiVcogD9UDsxFEfOu1k5dMsIqZU9ZGoxIUSdKuaHHXngNUcDL1wumS9F5RJHp674GR3Kj9fa/q2Egeo+xir6y7qTb+ibHc4KdHi715RJKyrpmfll1TxILYGQEZtmgBIMxhl4ZzoyJjIYfpUYpjU+Cb2hn0u3C0MOlR8ctTSlmIqofw2J1+CRANIq7IK6dmTZLvCz5wirXHdcPKRVauTRJcB+xke+PhIgQKzKiqjFOjdXrDJOBcyOColm7nRZFPQRxVM9PoaN4FUO4Lxp2+T6SxHxQH89kuKBrT4VsNkDdEfmfJ33w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e0a20a8-350e-43f8-ebd6-08de910d01ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2026 23:10:18.6812
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F8mZpnErUetORXCyeFFxP+lV8rT6DrWzEbP9IqDSmguxAZsdu1nrnt7uzUseUrKbXznbP+/aia70Esc0axnVpJqn5WqnHAnKCk34DxspGs4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFF2B8F6C64
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI2LTA0LTAyIGF0IDA5OjU5ICswODAwLCBZYW4gWmhhbyB3cm90ZToNCj4gT24g
VGh1LCBBcHIgMDIsIDIwMjYgYXQgMDc6NDU6NTRBTSArMDgwMCwgRWRnZWNvbWJlLCBSaWNrIFAg
d3JvdGU6DQo+ID4gT24gTW9uLCAyMDI2LTAzLTMwIGF0IDE0OjE0ICswODAwLCBZYW4gWmhhbyB3
cm90ZToNCj4gPiA+ID4gKwlLVk1fTU1VX1dBUk5fT04oaXNfZnJvemVuX3NwdGUobmV3X3NwdGUp
KTsNCj4gPiA+ID4gKw0KPiA+ID4gPiArCS8qDQo+ID4gPiA+ICsJICogVGVtcG9yYXJpbHkgZnJl
ZXplIHRoZSBTUFRFIHVudGlsIHRoZSBleHRlcm5hbCBQVEUgb3BlcmF0aW9uIGhhcw0KPiA+ID4g
PiArCSAqIGNvbXBsZXRlZCAodW5sZXNzIHRoZSBuZXcgU1BURSBpdHNlbGYgd2lsbCBiZSBmcm96
ZW4pLCBlLmcuIHNvDQo+ID4gPiA+IHRoYXQNCj4gPiA+ID4gKwkgKiBjb25jdXJyZW50IGZhdWx0
cyBkb24ndCBhdHRlbXB0IHRvIGluc3RhbGwgYSBjaGlsZCBQVEUgaW4gdGhlDQo+ID4gPiA+ICsJ
ICogZXh0ZXJuYWwgcGFnZSB0YWJsZSBiZWZvcmUgdGhlIHBhcmVudCBQVEUgaGFzIGJlZW4gd3Jp
dHRlbiwgb3INCj4gPiA+ID4gdHJ5DQo+ID4gPiA+ICsJICogdG8gcmUtaW5zdGFsbCBhIHBhZ2Ug
dGFibGUgYmVmb3JlIHRoZSBvbGQgb25lIHdhcyByZW1vdmVkLg0KPiA+ID4gPiArCSAqLw0KPiA+
ID4gPiArCWlmIChpc19taXJyb3Jfc3B0ZXAoaXRlci0+c3B0ZXApKQ0KPiA+ID4gPiArCQlyZXQg
PSBfX3RkcF9tbXVfc2V0X3NwdGVfYXRvbWljKGt2bSwgaXRlciwgRlJPWkVOX1NQVEUpOw0KPiA+
ID4gPiArCWVsc2UNCj4gPiA+ID4gKwkJcmV0ID0gX190ZHBfbW11X3NldF9zcHRlX2F0b21pYyhr
dm0sIGl0ZXIsIG5ld19zcHRlKTsNCj4gPiA+ID4gwqDCoAlpZiAocmV0KQ0KPiA+ID4gPiDCoMKg
CQlyZXR1cm4gcmV0Ow0KPiA+ID4gPiDCoCANCj4gPiA+ID4gLQloYW5kbGVfY2hhbmdlZF9zcHRl
KGt2bSwgaXRlci0+YXNfaWQsIGl0ZXItPmdmbiwgaXRlci0+b2xkX3NwdGUsDQo+ID4gPiA+IC0J
CQnCoMKgwqAgbmV3X3NwdGUsIGl0ZXItPmxldmVsLCB0cnVlKTsNCj4gPiA+ID4gKwlyZXQgPSBf
X2hhbmRsZV9jaGFuZ2VkX3NwdGUoa3ZtLCBzcCwgaXRlci0+Z2ZuLCBpdGVyLT5vbGRfc3B0ZSwN
Cj4gPiA+ID4gKwkJCQnCoMKgwqAgbmV3X3NwdGUsIGl0ZXItPmxldmVsLCB0cnVlKTsNCj4gPiA+
IA0KPiA+ID4gV2hhdCBhYm91dCBhZGRpbmcgYSBjb21tZW50IGZvciB0aGUgdHJpY2t5IHBhcnQg
Zm9yIHRoZSBtaXJyb3IgcGFnZSB0YWJsZToNCj4gPiA+IHdoaWxlIG5ld19zcHRlIGlzIHNldCB0
byBGUk9aRU5fU1BURSBpbiB0aGUgYWJvdmUgX190ZHBfbW11X3NldF9zcHRlX2F0b21pYygpDQo+
ID4gDQo+ID4gWW91IG1lYW50IGl0IHNldHMgaXRlci0+c3B0ZXAgSSB0aGluay4NCj4gPiANCj4g
PiA+IGZvciBmcmVlemluZyB0aGUgbWlycm9yIHBhZ2UgdGFibGUsIHRoZSBvcmlnaW5hbCBuZXdf
c3B0ZSBmcm9tIHRoZSBjYWxsZXIgb2YNCj4gPiA+IHRkcF9tbXVfc2V0X3NwdGVfYXRvbWljKCkg
aXMgcGFzc2VkIHRvIF9faGFuZGxlX2NoYW5nZWRfc3B0ZSgpIGluIG9yZGVyIHRvDQo+ID4gPiBw
cm9wZXJseSB1cGRhdGUgc3RhdGlzdGljcyBhbmQgcHJvcGFnYXRlIHRvIHRoZSBleHRlcm5hbCBw
YWdlIHRhYmxlLg0KPiA+IA0KPiA+IG5ld19zcHRlIHdhcyBhbHJlYWR5IHBhc3NlZCBpbi4gV2hh
dCBjaGFuZ2VkPyBZb3UgbWVhbiB0aGF0DQo+ID4gX190ZHBfbW11X3NldF9zcHRlX2F0b21pYygp
IHNldHMgaXRlci0+c3B0ZXAgYW5kIGRvZXNuJ3QgdXBkYXRlIG5ld19zcHRlPyBJZiBzbw0KPiA+
IEknbSBub3Qgc3VyZSBpZiBpdCB0aHJlc2hvbGQgVERQIE1NVS4NCj4gDQo+IEZvciBtaXJyb3Ig
cGFnZSB0YWJsZSwgYSBzdWNjZXNzZnVsIHBhdGggaW4gdGRwX21tdV9zZXRfc3B0ZV9hdG9taWMo
KSBsb29rcw0KPiBsaWtlIHRoaXM6DQo+IHRkcF9tbXVfc2V0X3NwdGVfYXRvbWljKCkgew0KPiAg
IF9fdGRwX21tdV9zZXRfc3B0ZV9hdG9taWMoa3ZtLCBpdGVyLCBGUk9aRU5fU1BURSk7ID09PnNl
dHMgbWlycm9yIHRvIGZyb3plbg0KPiAgIF9faGFuZGxlX2NoYW5nZWRfc3B0ZShrdm0sIHNwLCBp
dGVyLT5nZm4sIGl0ZXItPm9sZF9zcHRlLA0KPiAJCQluZXdfc3B0ZSwgaXRlci0+bGV2ZWwsIHRy
dWUpOz09PnNldHMgUy1FUFQgdG8gbmV3X3NwdGUNCj4gICBfX2t2bV90ZHBfbW11X3dyaXRlX3Nw
dGUoaXRlci0+c3B0ZXAsIG5ld19zcHRlKTsgICA9PT5zZXRzIG1pcnJvciB0byBuZXdfc3B0ZQ0K
PiB9DQo+IA0KPiBTbywgdGhlIHRyaWNreSBwYXJ0IGlzIHRoYXQgUy1FUFQgaXMgdXBkYXRlZCB0
byBuZXdfc3B0ZSBhaGVhZCBvZiBtaXJyb3IgRVBULg0KDQpJIHN0aWxsIGRvbid0IHNlZSB0aGUg
cG9pbnQuIFRoYXQgb3JkZXJpbmcgaXMgbm90IG5ldywgYW5kIHRoaXMgcGF0Y2ggYWN0dWFsbHkN
CmFkZHMgYSBidW5jaCBvZiBjb21tZW50cyBhcm91bmQgdGhlIG9wZXJhdGlvbnMgYWJvdmUgYW5k
IGJlbG93IHRoZQ0KX19oYW5kbGVfY2hhbmdlZF9zcHRlKCkgY2FsbC4gSWYgeW91IHRoaW5rIHNv
bWV0aGluZyBpcyBzdGlsbCBtaXNzaW5nIG1heWJlIHlvdQ0KY2FuIHN1Z2dlc3Qgc29tZXRoaW5n
Lg0KDQo+IA0KPiANCj4gPiA+ID4gLQlyZXR1cm4gMDsNCj4gPiA+ID4gKwkvKg0KPiA+ID4gPiAr
CSAqIFVuZnJlZXplIHRoZSBtaXJyb3IgU1BURS7CoCBJZiB1cGRhdGluZyB0aGUgZXh0ZXJuYWwg
U1BURSBmYWlsZWQsDQo+ID4gPiA+ICsJICogcmVzdG9yZSB0aGUgb2xkIFNQVEUgc28gdGhhdCB0
aGUgU1BURSBpc24ndCBmcm96ZW4gaW4NCj4gPiA+ID4gcGVycGV0dWl0eSwNCj4gPiA+ID4gKwkg
KiBvdGhlcndpc2Ugc2V0IHRoZSBtaXJyb3IgU1BURSB0byB0aGUgbmV3IGRlc2lyZWQgdmFsdWUu
DQo+ID4gPiA+ICsJICovDQo+ID4gPiA+ICsJaWYgKGlzX21pcnJvcl9zcHRlcChpdGVyLT5zcHRl
cCkpIHsNCj4gPiA+ID4gKwkJaWYgKHJldCkNCj4gPiA+ID4gKwkJCV9fa3ZtX3RkcF9tbXVfd3Jp
dGVfc3B0ZShpdGVyLT5zcHRlcCwgaXRlci0NCj4gPiA+ID4gPiBvbGRfc3B0ZSk7DQo+ID4gPiA+
ICsJCWVsc2UNCj4gPiA+ID4gKwkJCV9fa3ZtX3RkcF9tbXVfd3JpdGVfc3B0ZShpdGVyLT5zcHRl
cCwgbmV3X3NwdGUpOw0KPiA+ID4gPiArCX0gZWxzZSB7DQo+ID4gPiA+ICsJCS8qDQo+ID4gPiA+
ICsJCSAqIEJ1ZyB0aGUgVk0gaWYgaGFuZGxpbmcgdGhlIGNoYW5nZSBmYWlsZWQsIGFzIGZhaWx1
cmUgaXMNCj4gPiA+ID4gb25seQ0KPiA+ID4gPiArCQkgKiBhbGxvd2VkIGlmIEtWTSBjb3VsZG4n
dCB1cGRhdGUgdGhlIGV4dGVybmFsIFNQVEUuDQo+ID4gPiA+ICsJCSAqLw0KPiA+ID4gPiArCQlL
Vk1fQlVHX09OKHJldCwga3ZtKTsNCj4gPiA+ID4gKwl9DQo+ID4gPiA+ICsJcmV0dXJuIHJldDsN
Cj4gPiA+ID4gwqAgfQ0KPiA+ID4gPiDCoCANCj4gPiA+ID4gwqAgLyoNCj4gPiA+ID4gQEAgLTcz
OCw2ICs3NTksOCBAQCBzdGF0aWMgaW5saW5lIGludCBfX211c3RfY2hlY2sNCj4gPiA+ID4gdGRw
X21tdV9zZXRfc3B0ZV9hdG9taWMoc3RydWN0IGt2bSAqa3ZtLA0KPiA+ID4gPiDCoCBzdGF0aWMg
dTY0IHRkcF9tbXVfc2V0X3NwdGUoc3RydWN0IGt2bSAqa3ZtLCBpbnQgYXNfaWQsIHRkcF9wdGVw
X3Qgc3B0ZXAsDQo+ID4gPiA+IMKgwqAJCQnCoMKgwqAgdTY0IG9sZF9zcHRlLCB1NjQgbmV3X3Nw
dGUsIGdmbl90IGdmbiwgaW50DQo+ID4gPiA+IGxldmVsKQ0KPiA+ID4gPiDCoCB7DQo+ID4gPiA+
ICsJc3RydWN0IGt2bV9tbXVfcGFnZSAqc3AgPSBzcHRlcF90b19zcChyY3VfZGVyZWZlcmVuY2Uo
c3B0ZXApKTsNCj4gPiA+ID4gKw0KPiA+ID4gPiDCoMKgCWxvY2tkZXBfYXNzZXJ0X2hlbGRfd3Jp
dGUoJmt2bS0+bW11X2xvY2spOw0KPiA+ID4gPiDCoCANCj4gPiA+ID4gwqDCoAkvKg0KPiA+ID4g
PiBAQCAtNzUxLDcgKzc3NCw3IEBAIHN0YXRpYyB1NjQgdGRwX21tdV9zZXRfc3B0ZShzdHJ1Y3Qg
a3ZtICprdm0sIGludCBhc19pZCwNCj4gPiA+ID4gdGRwX3B0ZXBfdCBzcHRlcCwNCj4gPiA+ID4g
wqAgDQo+ID4gPiA+IMKgwqAJb2xkX3NwdGUgPSBrdm1fdGRwX21tdV93cml0ZV9zcHRlKHNwdGVw
LCBvbGRfc3B0ZSwgbmV3X3NwdGUsDQo+ID4gPiA+IGxldmVsKTsNCj4gPiA+ID4gwqAgDQo+ID4g
PiA+IC0JaGFuZGxlX2NoYW5nZWRfc3B0ZShrdm0sIGFzX2lkLCBnZm4sIG9sZF9zcHRlLCBuZXdf
c3B0ZSwgbGV2ZWwsDQo+ID4gPiA+IGZhbHNlKTsNCj4gPiA+ID4gKwloYW5kbGVfY2hhbmdlZF9z
cHRlKGt2bSwgc3AsIGdmbiwgb2xkX3NwdGUsIG5ld19zcHRlLCBsZXZlbCwNCj4gPiA+ID4gZmFs
c2UpOw0KPiA+ID4gPiDCoCANCj4gPiA+ID4gwqDCoAkvKg0KPiA+ID4gPiDCoMKgCSAqIFVzZXJz
IHRoYXQgZG8gbm9uLWF0b21pYyBzZXR0aW5nIG9mIFBURXMgZG9uJ3Qgb3BlcmF0ZSBvbiBtaXJy
b3INCj4gPiA+ID4gQEAgLTEzNzMsNiArMTM5Niw5IEBAIHN0YXRpYyB2b2lkIGt2bV90ZHBfbW11
X2FnZV9zcHRlKHN0cnVjdCBrdm0gKmt2bSwNCj4gPiA+ID4gc3RydWN0IHRkcF9pdGVyICppdGVy
KQ0KPiA+ID4gPiDCoCB7DQo+ID4gPiA+IMKgwqAJdTY0IG5ld19zcHRlOw0KPiA+ID4gPiDCoCAN
Cj4gPiA+ID4gKwlpZiAoV0FSTl9PTl9PTkNFKGlzX21pcnJvcl9zcHRlcChpdGVyLT5zcHRlcCkp
KQ0KPiA+ID4gPiArCQlyZXR1cm47DQo+ID4gPiA+ICsNCj4gPiA+IEFkZCBhIGNvbW1lbnQgZm9y
IHdoeSBtaXJyb3IgcGFnZSB0YWJsZSBpcyBub3QgZXhwZWN0ZWQgaGVyZT8NCj4gPiANCj4gPiBF
aGgsIG1heWJlLiBUaGlua2luZyBhYm91dCB3aGF0IHRvIHB1dC4uLiBUaGUgd2FybmluZyBpcyBr
aW5kIG9mIGNoZWF0aW5nIGENCj4gPiBsaXR0bGUgYml0IG9uIHRoZSBpZGVhIG9mIHRoZSBwYXRj
aDogdG8gZm9yd2FyZCBhbGwgY2hhbmdlcyB0aHJvdWdoIGxpbWl0ZWQgb3BzDQo+ID4gaW4gYSBj
ZW50cmFsIHBsYWNlLCBzdWNoIHRoYXQgd2UgZG9uJ3QgaGF2ZSBURFggc3BlY2lmaWNzIGVuY29k
ZWQgaW4gY29yZSBNTVUuDQo+ID4gVHJ5aW5nIHRvIGZvcndhcmQgdGhpcyB0aHJvdWdoIHByb3Bl
cmx5IHdvdWxkIHJlc3VsdCBpbiBtb3JlIGJ1cmRlbiB0byB0aGUgVERQDQo+ID4gTU1VLCBzbyB0
aGF0J3Mgbm90IHRoZSByaWdodCBhbnN3ZXIgZWl0aGVyLg0KPiA+IA0KPiA+ICJNaXJyb3IgVERQ
IGRvZXNuJ3Qgc3VwcG9ydCBQVEUgYWdpbmciIGlzIGEgcHJldHR5IG9idmlvdXMgY29tbWVudC4g
SSdtIGZpbmUNCj4gPiBqdXN0IGxlYXZpbmcgaXQgd2l0aG91dCBjb21tZW50LCBidXQgSSBjYW4g
YWRkIHNvbWV0aGluZyBsaWtlIHRoYXQuIE9yIGRvIHlvdQ0KPiA+IGhhdmUgYW5vdGhlciBzdWdn
ZXN0aW9uPw0KPiBXaGF0IGFib3V0ICJFeHRlcm5hbCBURFAgZG9lc24ndCBzdXBwb3J0IGNsZWFy
aW5nIFBURSBBL0QgYml0Ij8NCg0KSXQgc291bmRzIHRvbyBjbG9zZSB0byAiVERYIGRvZXNuJ3Qg
c3VwcG9ydC4uLiIgdG8gbWUuIEkgdGhpbmsgSSdkIHByZWZlciB0byBub3QNCmFkZCBhIGNvbW1l
bnQgdW5sZXNzIHlvdSBzdHJvbmdseSBvYmplY3QuDQoNCg0KPiBJJ20gb2sgd2l0aCBsZWF2aW5n
IHdpdGhvdXQgY29tbWVudCBpZiB5b3UgdGhpbmsgaXQncyB0b28gb2J2aW91cy4NCj4gDQo+ID4g
PiBBbmQgZG8gd2UgbmVlZCBhIHNpbWlsYXIgV0FSTl9PTl9PTkNFKCkgaW4ga3ZtX3RkcF9tbXVf
Y2xlYXJfZGlydHlfcHRfbWFza2VkKCkNCj4gPiA+IG9yIGNsZWFyX2RpcnR5X3B0X21hc2tlZCgp
Pw0KPiA+IA0KPiA+IE5vdGhpbmcgY2hhbmdlcyBmb3IgdGhvc2UgaW4gdGhpcyBwYXRjaCB0aG91
Z2g/IEZvciB0aGUga3ZtX3RkcF9tbXVfYWdlX3NwdGUoKQ0KPiA+IGNhc2UsIHdhcm5pbmcgY292
ZXJhZ2UgaXMgcmVtb3ZlZCBpbiB0aGlzIHBhdGNoLg0KPiANCj4gSW4ga3ZtX3RkcF9tbXVfYWdl
X3NwdGUoKSBhbmQgY2xlYXJfZGlydHlfcHRfbWFza2VkKCkgU1BURXMgYXJlIHVwZGF0ZWQgdmlh
DQo+IF9fdGRwX21tdV9zZXRfc3B0ZV9hdG9taWMoKSBvciB0ZHBfbW11X2NsZWFyX3NwdGVfYml0
cygpLCB3aGljaCBkb24ndCBwcm9wYWdhdGUNCj4gY2hhbmdlcyB0byB0aGUgZXh0ZXJuYWwgcGFn
ZSB0YWJsZS4NCj4gU28sIEkgdGhpbmsgaXQncyBiZXR0ZXIgdG8gd2FybiBpZiBhIG1pcnJvciBy
b290IGlzIGFjY2lkZW50YWxseSBwYXNzZWQgaW4gdG8NCj4gdGhvc2UgZnVuY3Rpb25zLg0KPiAN
Cj4gDQo+ICANCg0KSSBkb24ndCB0aGluayB3ZSBzaG91bGQgYWRkIHdhcm5pbmdzIGZvciBuZXcg
cGF0aHMgaW4gdGhpcyBwYXRjaC4gTWVhbmluZywgdGhlDQpwYXRjaCBzaG91bGRuJ3QgaW5jcmVh
c2UgY292ZXJhZ2UsIGp1c3QgbWFpbnRhaW4uIEJ1dCBpdCBzZWVtcyByZWFzb25hYmxlIGluDQpn
ZW5lcmFsLiBIb3cgYWJvdXQgd2UgYWRkIGl0IHRvIHRoZSBjbGVhbnVwIGxpc3QuDQoNCg0KDQo=
