Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89253BB10D;
	Mon, 20 Jul 2026 18:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784572413; cv=fail; b=YBnScRHAa5xdI1MYEL/FYiVAof7biXNTCmELHrdu0CJVXRek9cW1Twe/HaCyHAwojs9WL1snzpRdKuhuNpvYXVYLQ5/mKx7ndDG/2UlIVaDCq31zuGCg7/9ipLcqga5d4Mc1Tjc6YLfG0Odi90ZQgTCygOECtfuq1TOPsSHXZCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784572413; c=relaxed/simple;
	bh=Ne3PH4bpMu504uZcsMg/i981VB00nzmeMwosp+ZC3ec=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rIhk8jZlbsh/OXPooIq90h24nvUpIRJcjor64uwWn7sBCMzF0syVCk2x9YTABkKCty3Y568ueeZq1R1vMOc3ezoRgpURwPD6JrEWijXQPW4VfihYOhMWQLQNvyim+VSY4/uJkD3snr5hvDAiOkPzsBhd2WcC73S4vt3VQxjXIxg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LOnT/OYC; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LOnT/OYC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784572412; x=1816108412;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Ne3PH4bpMu504uZcsMg/i981VB00nzmeMwosp+ZC3ec=;
  b=LOnT/OYCbQwzG5qBJQnNsttCSMTWSpZHL5nbEKw5w5dn0Sa7ExU9EaSF
   1PG2no5PGRfLuRTWU1o+kZtIavgfQLpRjZEFNKHYi9FB+TbaBJtHo6OvQ
   rni0mbQTqojyE4iKyaEIvOUCKyLNNZb4Veb3Egb033XjEkKZqRKgnpcAh
   0Tv3nQhUokSl1OYugnu4350SFbJ2cgWg0p1nv5zvuPDaZUS+kQMTqJreL
   NXQyhLZzshHztAVeEMqpe2n4bWe9ghHBQ84CgKi/r/2bQauWuF5h2kUek
   tS0cOZUoTptIeaHYX1F0nkfnKFeZ4Yo5PxjjL1YY90nF/bN18TR7sOwV3
   A==;
X-CSE-ConnectionGUID: w/l51fW6TzmKjXygKdiCVw==
X-CSE-MsgGUID: MpOkGSECTEiHg2kmRho7+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="95814853"
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="95814853"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 11:33:30 -0700
X-CSE-ConnectionGUID: HmKOMACFRtKGs6reI9JQ0Q==
X-CSE-MsgGUID: N/oAraXvRV+Jha8Cp5zFig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="259534082"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 11:33:30 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 11:33:29 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 20 Jul 2026 11:33:29 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.36) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 11:33:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ORF9eWug6b/vbywFDStsWrPvkxxfBnkFSeUmXYTl8oVWjb9zVjMT2Za9KL8sRNiL77s7COt8ydlDbCcgNZq23mcrj0yUc3xab7FXTFPtY+RwyxbNqZA6Hv9L3OthcFyACPLbzLxh/OXyegKdvAebKTGGpCVAFaWAnUi3SlNDHcfPsSdX55gJp8BAji06/sUfgtPuhRT/+NV6KrlYtfEhi6t+FVyMfJ5PRI19OkinyCBJwl2aXufI2eOuKngCPHgA/MXmVt+15qXHopiJ6erhjiDvFBUX7vlFIZI9Tz9tl4M6oCH51OD4y5W6vmO3kfto0w6uYeafDLSBaj6CJOn1BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ne3PH4bpMu504uZcsMg/i981VB00nzmeMwosp+ZC3ec=;
 b=c1VDsq6kaRMoZs9vLjw6idZtIPuvWXgOgP4owWrdgxwjz8TsuDonTLaCx3tSnDW2NzI6SNA1qiJ8vCQkWtesVJ8507hlpbLHpvfIOT+s9lJBn866beY+/MYkMP+7Y5P7qjEiIP9Rz6Q3geIOiDrAVtcgmaNUlo0rcrffLFCUouHz1RIAhHeBC2H5r8EpzdY12POrrxQcOTTL/rRljgRPvdulpmTUCG5jFKJS862MDm+PR5/IQhfhradMdfzHHgNzJgXJs/GbpifuhQRJwXfqx5T/CkD00s8UI2jPHqPDnNtUaBUQ6MURvqKuy0VRDRFymqaax60rzj4OKfOIT5MK/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by CH3PR11MB7391.namprd11.prod.outlook.com (2603:10b6:610:151::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 18:33:19 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0223.017; Mon, 20 Jul 2026
 18:33:19 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, "Huang, Kai"
	<kai.huang@intel.com>, "Hansen, Dave" <dave.hansen@intel.com>, "Zhao, Yan Y"
	<yan.y.zhao@intel.com>, "Wu, Binbin" <binbin.wu@intel.com>, "kas@kernel.org"
	<kas@kernel.org>, "seanjc@google.com" <seanjc@google.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "sashiko-reviews@lists.linux.dev"
	<sashiko-reviews@lists.linux.dev>, "hpa@zytor.com" <hpa@zytor.com>,
	"tglx@kernel.org" <tglx@kernel.org>, "Annapurve, Vishal"
	<vannapurve@google.com>, "bp@alien8.de" <bp@alien8.de>, "Gao, Chao"
	<chao.gao@intel.com>, "x86@kernel.org" <x86@kernel.org>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: Re: [PATCH v7 11/11] x86/virt/tdx: Optimize tdx_pamt_get/put()
Thread-Topic: [PATCH v7 11/11] x86/virt/tdx: Optimize tdx_pamt_get/put()
Thread-Index: AQHdFlcdyyex0MBipEGoc5qQEviyorZyhdiAgAQ58QA=
Date: Mon, 20 Jul 2026 18:33:19 +0000
Message-ID: <207186fcb49b741b3774c4d3be479594656b64b2.camel@intel.com>
References: <20260718014500.2231262-1-rick.p.edgecombe@intel.com>
	 <20260718014500.2231262-12-rick.p.edgecombe@intel.com>
	 <20260718020053.C2FC81F000E9@smtp.kernel.org>
In-Reply-To: <20260718020053.C2FC81F000E9@smtp.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|CH3PR11MB7391:EE_
x-ms-office365-filtering-correlation-id: 690cad69-75be-4bca-e633-08dee68d5f30
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|23010399003|366016|921020|18002099003|22082099003|38070700021|56012099006|4143699003|11063799006|10067099003;
x-microsoft-antispam-message-info: SM7aqj94nnkErp0NW9EUq0Mpn9MSxbBib5oDHt9/fU6BLZwQu4E5eljBS6aDDd9vgbOhIEm671pKrzBC/etmcT8bvez1AN90lKbcBUv5Q/ECa3K+wd97szaTnLLPFABG95DIawnBhZhAHjV7kN9RDaJf9PTUmLkIK3gXNFL6sd3QunGCu6TmQ46zJlUItwCCuAwNFcXjMKRePpXkN3LBKEd503rdp8LATliz4nun4RoXzpWAnOFNFHp1whhpLJNZzMnyqUGgLu9NtcJOMdLc6AwUEvhieYZ1sdUrF4L7rTkg1hgmXa0KYhvudleCFdxS153saNlVfNsj+UU67C3uXnf+OBp94u+11pSIcBEWeHrcUHsr2moGbRt0UaRw8i5IQvi54jBehwQ3aV3AICkv1szXrJP4Bz5O3bnqYn9eq96p94qGN3qQX0Q+iAGMBBoQe8INEWefiD/d02UW8GpZP3bYQTC3phWeHecA8HZzx9FP16ZQecA0d3Ilklu1aDlpJ+XRGdmk3oxoGFV9JIHrqrqDNCn7dwWDihpXMnMeQijDoxzaWgAtGbsSTFBX79R3oAsR49Zqt/B58EKfCsElb6Y1AmfD/gJ7L+IlBB07n+3Cflqn4JGv6Oj9LnKyIPaHzPRHIAS3wbgpUY4W+3CDXzpYhfWcgjiBBLh1gJzsXXBVPW2Q8WNrvHwLojeqqHn6s2Hcdaf2/3+BIjstn09D3228zByeXbkLmKoqKl047O7ALVKZigx5cvHpYgIAq/hl
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(366016)(921020)(18002099003)(22082099003)(38070700021)(56012099006)(4143699003)(11063799006)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZnhxNitZcjd0UGg3R3N1U3dvbjlHZHVOb0RhVWxMMys5ODZRNm5JWGxSSkF1?=
 =?utf-8?B?RklGMlh4Z2lvc1o0bWxhQjVGWGtCWlJEZmNIc1c3c0JYOEdERUhGUXV0cW5s?=
 =?utf-8?B?WFJqalhIM0hWS3Y2dnpZcFBvdHIxa1R2Z0RORHJPbGczbERnRUdjRWl4TEYx?=
 =?utf-8?B?RjBOekVuczR3RG9ZWEFiU2V3SitNcVVRN25uTlRoZ1Y4ZXJ4RmoyRmNhUDdB?=
 =?utf-8?B?QmNLczhhTjlUa3NZWDlVNlNvdkJROVJkVzUvU2NuTVZRNnRkd0U1TDltZG4z?=
 =?utf-8?B?U1NDK2o2RXlyb3BtNGhibHl4dDJDM3phTnJiUXg1aEUyQUJQV1p3OTVqOFlI?=
 =?utf-8?B?YWd2OUdSSXNVaERhV0NzWmJ6K3hoazdIbFRHUnFxUm5Ec1l4cWhrQ0VkNlNT?=
 =?utf-8?B?dG0yeDdWdG5pNThyUzhJZzgzVS9NK3M5d1ltZHNrd1BQZitRdUM4c3g4MVRT?=
 =?utf-8?B?ZWVVNzIzT1doWHFFUDlQSWoyNzlvNnV2cFlNc1BCMGNJaXRNWWFYamlrUXkw?=
 =?utf-8?B?YkFJaFlERm0vcjlCYjJORDlLRnpxZ3pKY2poZW96RXd6TDJGKzVFZnZoMnlP?=
 =?utf-8?B?cHJzekNvNVNDUExuc1o4UXA3UlM3QUZPNEp6QWxvTnpndDB6Tkd0VHAzaHFi?=
 =?utf-8?B?TDFLMnRDaGdRT3B0a2xSbGVmQjFSbkRWZWNURjBValVXZ1Nkbk83ZmVMNU5G?=
 =?utf-8?B?N2RFRHEzWjducVNFUDkybHRCTHV2MGtqZXN6cDFCdENpQkFmaldEL0MwM3o5?=
 =?utf-8?B?ZUFLaXBRc2h5UG1KYjhyRkxLbGhaajNYdlFQeVRDSmY2NkF3czBqb3RrYS9j?=
 =?utf-8?B?d25TKzB0ZFp3Ris1TEJFd085Nmx1eG1BMnlHSnBiS285VTRPbUo0eWd0b2pJ?=
 =?utf-8?B?T0pxNWhIUEI2TjZKUWxZS2FVU1kzamdrNlhjOEZtY3h4dlQ2UmpnckRXWjhV?=
 =?utf-8?B?VnNPb1d4eVRtQ2VSV1RaVENhYkZzUVNxaEl3dXhvdGxMeUswNzVlT2FiZHlp?=
 =?utf-8?B?YjhoSGVwSCtzN1ExYllQVXlrR2U4Uko1RDFnTDhYQmV4Mnl6MmYxaGh2TUFW?=
 =?utf-8?B?bVFxRlA1a2ZLSVIvRXdob0JCMllLb2tCV2dKUGlMeEV4Vi9TK2FPTTBKZjdI?=
 =?utf-8?B?Z3BLU2k5amlmQjlHdjY3Nk5XaHJBR2V5WHk0QXVGckdkaE1KL0VFUGtxVnQ5?=
 =?utf-8?B?VVp1V1U4ZGhsYWtwZHpLSzMyWFpZVmtWSnV5UXhvL1FGWmZZRThFUENsYkI0?=
 =?utf-8?B?eHI5eVpkcFVlN1FMRFBWNGg4MThZazlwV2JFUllaSXE3S2FDUmJmTjJRRld0?=
 =?utf-8?B?L3J2UzlOM3RweHM0YzI4ci9VR2M0Zkx1Y2FhRlRUQlkvbFlyUHdQWTF4M2lY?=
 =?utf-8?B?OXRQenZncTd4bGVoNDRjNktCUVp5aE9zZkw3ZGY1UXlPNy9tNmRJMHdJczVq?=
 =?utf-8?B?V1lWUHJmTkl2Vitobm83MnNuSG4wT2kweEdrZEY5cG5TWmwxNC9GQ1BHM3d4?=
 =?utf-8?B?RSs5aDhHL2ZUdmhIM1JVRG5oa3FGZktQd2lmZjBhUzNRcGJMbklHUXdTVklo?=
 =?utf-8?B?ZzRIUjdrbHpsT0VlU3N4Q3lGbFNDTGpEMEorbGpBU09yU1RERnFpMWduTnA1?=
 =?utf-8?B?UTF2MkFsdVNYWGlDVHk5bC96NTdzbVVRWVJoTnh0bmdZZlJDR29pS0ttYldS?=
 =?utf-8?B?TUpDajNGcVJwUzNUbzVrcDVSMU01M2VFUk5RYzBPMlRjOVI2UytnZ3UzK3V4?=
 =?utf-8?B?YW1WNUlMMnBxT0lvWWQrZm5EL2RvSnFJd1phN1FiUkxHWU9tdEVpWlN0V3JG?=
 =?utf-8?B?aVE4bG50aUhiU1BZakc2b3lTTCtDclJWRGZIRGpKMzFCbDMvdDV0ZjNRTmE4?=
 =?utf-8?B?RkpEcjZKTEFXRkhBZW9Ja1dVUXY3U2paNEY5ME5ZaC9yamIxMTU1WXkxTllQ?=
 =?utf-8?B?eGNwK2VVeHU4a3NXWjdFRzNKNU1nZ1MyUUE2aUJnNEttL0Z4b0xNYnZtcFBF?=
 =?utf-8?B?OXRMVU9ybGlTd04zeDh0UENSWFpNL3Vib3BPNGl1ZjVnY0c3ZGJpVnVBK1Vr?=
 =?utf-8?B?akNlVzJUdjYwREY3RzREQitVaC9vUWRubGtuUlgrellWem9DaFFqL24wSzk3?=
 =?utf-8?B?ZHhyRXhpUXpNQVgxVkl4TjVidzJEWHoyRzU1UUx5NjRyYUljbkNvdmJBUTR2?=
 =?utf-8?B?SEEybWlhbVdGYXlOeEw4Vk9meHJmd0JLZkRLSjVleitnd1UvUXo5cGNyc1Bu?=
 =?utf-8?B?VWpQOTBhYWZIakJVL2xva3dsZWlxUUdXZzJmejdOZVljVkxlTXp1K1ZlOTc2?=
 =?utf-8?B?WUk3OW1aY2ErbmJ1eU5ubWl3Vm5vVnUxL05iWUlIbzZwRmd2ZDFWZTJMdkV4?=
 =?utf-8?Q?t01nqvMzB8X5+Uqk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <56A4420A36014144BB8E85C136C488A0@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: JpI9fcpqMEQ7BlpFBHfunqe8GjsjHSEypUJ6Uk22wb2YbjxrfrdB3eCH1eKtgFlyaH3sSDISGUV5vPNJjSDyU9Zty5JyWxFhOjIyzjCNKchLhLArURMDHRObAxa4+kubJy4Jm8blHWlWiJT80XxjOA/o+S2dTXDKiBS4wEIUlv27WTBMDJ6p6dnPsiA5B4SkV5FmUHpWbX4wG0tc1+vCm8HzCYqyRz4U2HwNRIjvJXounU0Qh66nHxbRki6K0gmR7T7gIEwcogsBuFtvFSbDJfguqEmBu17nVYeCToBLzBbmVWnv6Hr1bDrf3Nv7L5p0fxq5ubaQqq78cPMoJ9asbQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 690cad69-75be-4bca-e633-08dee68d5f30
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2026 18:33:19.4551
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3PngaazDmQbtIwlrK7R6ezIqkZP3sC8imnSPhW/ByaGVHVI+2bCSbr8BE8/fi9KQggRRf/XN1mnu3bPetKj2XptedFG/TPNL5c2hxkWTKaI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7391
X-OriginatorOrg: intel.com

T24gU2F0LCAyMDI2LTA3LTE4IGF0IDAyOjAwICswMDAwLCBzYXNoaWtvLWJvdEBrZXJuZWwub3Jn
IHdyb3RlOg0KPiBUaGFuayB5b3UgZm9yIHlvdXIgY29udHJpYnV0aW9uISBTYXNoaWtvIEFJIHJl
dmlldyBmb3VuZCAxIHBvdGVudGlhbCBpc3N1ZShzKSB0byBjb25zaWRlcjoNCj4gLSBbTWVkaXVt
XSBVc2luZyBgYXRvbWljX2RlY19hbmRfbG9ja2AgaW4gYHRkeF9wYW10X3B1dGAgbGFja3MgdW5k
ZXJmbG93IHByb3RlY3Rpb24sIGNhdXNpbmcgYW4gdW5iYWxhbmNlZCBwdXQgKHJlZmNvdW50IDAp
IHRvIHNpbGVudGx5IHVuZGVyZmxvdyB0aGUgcmVmY291bnQgdG8gLTEsIHdoaWNoIGJyZWFrcyBm
dXR1cmUgYHRkeF9wYW10X2dldGAgY2FsbHMgZm9yIHRoYXQgUEZOLg0KDQpUaGUgcmVwb3J0IGlz
IGVzc2VudGlhbGx5IHRoYXQgdGhpcyBwYXRjaCBkb2Vzbid0IGhhbmRsZSB1bmJhbGFuY2VkDQp0
ZHhfcGFtdF9wdXQoKSBjYWxscyAoYSB0ZHhfcGFtdF9wdXQoKSB3aXRob3V0IGEgcHJldmlvdXMg
cGFpcmVkDQp0ZHhfcGFtdF9nZXQoKSkuIFNvIHRoaXMgaXNuJ3QgYSBidWcgcGVyLXNlLCBidXQg
aXQgaXMgdHJ1ZSB0aGF0IHRoZQ0Kb3B0aW1pemF0aW9uIHBhdGNoIGhhcyBhIGJpdCB3b3JzZSB3
YXJuaW5ncyBpbiB0aGUgY2FzZSBvZiBidWdneSBjYWxsaW5nIGNvZGUuDQoNCk1vcmUgYW5hbHlz
aXMuLi4gVGhlIGZ1bmN0aW9uIGlzOg0KDQppbnQgYXRvbWljX2RlY19hbmRfbG9jayhhdG9taWNf
dCAqYXRvbWljLCBzcGlubG9ja190ICpsb2NrKQ0Kew0KCS8qIFN1YnRyYWN0IDEgZnJvbSBjb3Vu
dGVyIHVubGVzcyB0aGF0IGRyb3BzIGl0IHRvIDAgKGllLiBpdCB3YXMgMSkgKi8NCglpZiAoYXRv
bWljX2FkZF91bmxlc3MoYXRvbWljLCAtMSwgMSkpDQoJCXJldHVybiAwOw0KDQoJLyogT3RoZXJ3
aXNlIGRvIGl0IHRoZSBzbG93IHdheSAqLw0KCXNwaW5fbG9jayhsb2NrKTsNCglpZiAoYXRvbWlj
X2RlY19hbmRfdGVzdChhdG9taWMpKQ0KCQlyZXR1cm4gMTsNCglzcGluX3VubG9jayhsb2NrKTsN
CglyZXR1cm4gMDsNCn0NCg0KSW4gdGhlIGZhc3QgcGF0aCBhdG9taWNfYWRkX3VubGVzcygpIHN1
YnRyYWN0cyAxIHVubGVzcyB0aGUgY291bnRlciB3YXMgZXhhY3RseQ0KMS4gU28gaWYgaXQgd2Fz
IDAgKG5vIHBhaXJlZCBnZXQgaGFzIGJlZW4gY2FsbGVkKSwgdGhlIGNvdW50ZXIgd291bGQgdW5k
ZXJmbG93Lg0KDQpJbiB0aGUgbm9uLW9wdGltaXplZCBwYXRjaCwgdGhlIHB1dCBjb2RlIHdhcyBt
b3JlIHJvYnVzdCB0byB0aGlzIHNjZW5hcmlvLiBJbg0KdGhhdCBjb2RlIGlmIGEgcHV0IHdhcyBk
b25lIHdpdGggdGhlIHJlZmNvdW50IGF0IDAsIHRoZSBwdXQgd291bGQgc2VlIGl0IHdhcw0KbGVz
cyB0aGFuIDEgYW5kIHRyeSB0byByZW1vdmUgaXQuIFRoZSByZXN1bHQgd291bGQgYmUgYSB3YXJu
aW5nIGZyb20gdGhlDQpTRUFNQ0FMTCBmYWlsdXJlLg0KDQpTbyB0aGlzIHBhdGNoIHRyYWRlcyBz
b21lIHdhcm5pbmdzIGZvciBwZXJmb3JtYW5jZS4gQnV0IHRoZSB3YXJuaW5nIGxvc3MgaXMNCnBy
ZXR0eSBzbWFsbC4gRnV0dXJlIGJ1Z2d5IGNvZGUgaXMgdW5saWtlbHkgdG8gZ2V0IGF3YXkgd2l0
aG91dCBhIHdhcm5pbmcuDQpNaXNzaW5nIFBBTVQgaXMgbm90IGxpa2UgZG91YmxlIGZyZWUgb3Ig
YnVnIGxpa2UgdGhhdC4gV2l0aCB0aGUgY291bnQNCnVuYmFsYW5jZWQsIHRoZW4gbmV4dCB0ZHhf
cGFtdF9nZXQoKSB3aWxsIGZhaWwgdG8gYWRkIHRoZSBEeW5hbWljIFBBTVQgcGFnZSBwYWlyDQph
bmQgdGhlIFREWCBtb2R1bGUgd2lsbCByZXR1cm4gYW4gZXJyb3Igd2hlbiBpdCB0cmllcyB0byB1
c2UgdGhlIHBhZ2UuDQoNCkdldHRpbmcgYSB3YXJuaW5nIGV4YWN0bHkgYXQgdGhlIHBvaW50IG9m
IHRoZSB1bnBhaXJlZCBwdXQgd291bGQgYmUgYmV0dGVyLiBCdXQNCnRoaXMgdmVyc2lvbiBoYXMg
b3RoZXIgY2xlYXIgYmVuZWZpdHMuIE9uIGJhbGFuY2UsIEknZCBwcmVmZXIgdGhpcyBvbmUuIEl0
IG1pZ2h0DQpiZSBwb3NzaWJsZSB0byB1dGlsaXplIHJlZmNvdW50X3QgdG8gZ2V0IHNvbWUgYmV0
dGVyIHVuZGVyZmxvdyB3YXJuaW5ncywgYnV0DQpwcm9iYWJseSBmb3IgdGhlIGNvc3Qgb2YgbW9y
ZSBtZW1vcnkgb3JkZXJpbmcgdGhpbmdzIHRvIGNvbnNpZGVyLg0KDQpIbW0sIGFub3RoZXIgY2hl
YXAsIGJ1dCBub3QgY29tcGxldGUgb3B0aW9uIHdvdWxkIGJlIHRvIGp1c3Qgd2FybiBvbiBnZXQv
cHV0IG91dA0KcGF0aHMgaWYgYW55IHN0cmFuZ2UgcmVmY291bnRzIGFyZSBzZWVuLiBTaW5jZSB0
aGUgcG9pbnQgaXMganVzdCB0byBjYXRjaCB0aGUNCmVycm9yIGNsb3NlciB0byB3aGVyZSBpdCBo
YXBwZW5zLiBJdCdzIGp1c3QgZGV2ZWxvcGVyIGhlbHAuIFNpbXBsZXIgY29kZSB3aXRoDQpsZXNz
IHdlbGwgdGltZWQgd2FybmluZ3Mgc2VlbXMgbGlrZSBhIGdvb2QgdHJhZGVvZmYgZm9yIGRldmVs
b3BlcnM/DQoNCj4gLS0NCj4gDQo+IC0tLSBQYXRjaCBbMTFdOiBbUEFUQ0ggdjcgMTEvMTFdIHg4
Ni92aXJ0L3RkeDogT3B0aW1pemUgdGR4X3BhbXRfZ2V0L3B1dCgpIC0tLQ0KPiBjb21taXQgZjNi
ZGU4Y2NmOTY1OWY4YjFlMWNlZGI5YjgxZGYwYjNiMjA5YTlmYQ0KPiBBdXRob3I6IEtpcnlsIFNo
dXRzZW1hdSA8a2FzQGtlcm5lbC5vcmc+DQo+IA0KPiB4ODYvdmlydC90ZHg6IE9wdGltaXplIHRk
eF9wYW10X2dldC9wdXQoKQ0KPiANCj4gVGhlIER5bmFtaWMgUEFNVCBnZXQvcHV0IGhlbHBlcnMg
dXNlIGEgZ2xvYmFsIHNwaW5sb2NrIHRvIHNlcmlhbGl6ZSBhbGwNCj4gcmVmY291bnQgdXBkYXRl
cyBhbmQgU0VBTUNBTEwgaW52b2NhdGlvbnMuIFRoaXMgZ2l2ZXMgY29ycmVjdCBiZWhhdmlvciBm
b3INCj4gY29uY3VycmVudCBjYWxsZXJzLCBidXQgbGVhZHMgdG8gY29udGVudGlvbi4NCj4gDQo+
ID4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L3ZpcnQvdm14L3RkeC90ZHguYyBiL2FyY2gveDg2L3Zp
cnQvdm14L3RkeC90ZHguYw0KPiA+IGluZGV4IDY5ODM0YjBkM2U2MDIuLjQzOTRiYmE3YzlhN2Mg
MTAwNjQ0DQo+ID4gLS0tIGEvYXJjaC94ODYvdmlydC92bXgvdGR4L3RkeC5jDQo+ID4gKysrIGIv
YXJjaC94ODYvdmlydC92bXgvdGR4L3RkeC5jDQo+IA0KPiBbIC4uLiBdDQo+IA0KPiA+IEBAIC0y
MjE0LDE3ICsyMjI3LDEzIEBAIHZvaWQgdGR4X3BhbXRfcHV0KGt2bV9wZm5fdCBwZm4pDQo+ID4g
IA0KPiA+ICAJcGFtdF9yZWZjb3VudCA9IHRkeF9maW5kX3BhbXRfcmVmY291bnQocGZuKTsNCj4g
PiAgDQo+ID4gLQlzcGluX2xvY2soJnBhbXRfbG9jayk7DQo+ID4gIAkvKg0KPiA+ICAJICogSWYg
dGhlcmUgaXMgbW9yZSB0aGFuIDEgcmVmZXJlbmNlIG9uIHRoZSBwYW10IHBhZ2UsIGRvbid0DQo+
ID4gIAkgKiByZW1vdmUgaXQgeWV0LiBKdXN0IGRlY3JlbWVudCB0aGUgcmVmY291bnQuDQo+ID4g
IAkgKi8NCj4gPiAtCWlmIChhdG9taWNfcmVhZChwYW10X3JlZmNvdW50KSA+IDEpIHsNCj4gPiAt
CQlhdG9taWNfZGVjKHBhbXRfcmVmY291bnQpOw0KPiA+IC0JCWdvdG8gb3V0X3VubG9jazsNCj4g
PiAtCX0NCj4gPiArCWlmICghYXRvbWljX2RlY19hbmRfbG9jayhwYW10X3JlZmNvdW50LCAmcGFt
dF9sb2NrKSkNCj4gPiArCQlyZXR1cm47DQo+IA0KPiBbU2V2ZXJpdHk6IE1lZGl1bV0NCj4gSWYg
YW4gdW5iYWxhbmNlZCBwdXQgb2NjdXJzIG9uIGFuIHVuLWFkZGVkIFBBTVQgcGFnZSAod2hlcmUg
dGhlIHJlZmNvdW50DQo+IGlzIDApLCBkb2VzIGF0b21pY19kZWNfYW5kX2xvY2soKSBsYWNrIHVu
ZGVyZmxvdyBwcm90ZWN0aW9uIGFuZCBzaWxlbnRseQ0KPiBkcm9wIHRoZSByZWZjb3VudCB0byAt
MSBpbnN0ZWFkIG9mIHByb2NlZWRpbmcgdG8gdGhlIFNFQU1DQUxMIGZhaWx1cmUNCj4gd2Fybmlu
ZyBhcyB0aGUgcHJldmlvdXMgbG9naWMgZGlkPw0KPiANCj4gbGliL2RlY19hbmRfbG9jay5jOmF0
b21pY19kZWNfYW5kX2xvY2soKSB7DQo+ICAgICAvKiBTdWJ0cmFjdCAxIGZyb20gY291bnRlciB1
bmxlc3MgdGhhdCBkcm9wcyBpdCB0byAwIChpZS4gaXQgd2FzIDEpICovDQo+ICAgICBpZiAoYXRv
bWljX2FkZF91bmxlc3MoYXRvbWljLCAtMSwgMSkpDQo+ICAgICAgICAgcmV0dXJuIDA7DQo+ICAg
ICAuLi4NCj4gfQ0KPiANCj4gSWYgdGhlIHJlZmNvdW50IHNpbGVudGx5IGJlY29tZXMgLTEsIHdv
dWxkIGEgc3Vic2VxdWVudCBjYWxsIHRvDQo+IHRkeF9wYW10X2dldCgpIGZvciB0aGlzIFBGTiBp
bmNvcnJlY3RseSBzdWNjZWVkIHdpdGhvdXQgYWRkaW5nIHRoZSBQQU1UDQo+IG1lbW9yeT8NCj4g
DQo+IGFyY2gveDg2L3ZpcnQvdm14L3RkeC90ZHguYzp0ZHhfcGFtdF9nZXQoKSB7DQo+ICAgICAu
Li4NCj4gICAgIGlmIChhdG9taWNfaW5jX25vdF96ZXJvKHBhbXRfcmVmY291bnQpKQ0KPiAgICAg
ICAgIHJldHVybiAwOw0KPiAgICAgLi4uDQo+IH0NCj4gDQo+IFNpbmNlIC0xIGlzIG5vdCB6ZXJv
LCBhdG9taWNfaW5jX25vdF96ZXJvKCkgd291bGQgaW5jcmVtZW50IHRoZSByZWZjb3VudA0KPiB0
byAwIGFuZCByZXR1cm4gdHJ1ZSwgYnlwYXNzaW5nIHRoZSB0ZGhfcGh5bWVtX3BhbXRfYWRkKCkg
U0VBTUNBTEwuDQo+IA0KDQo=
