Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1FB27FD76;
	Wed, 19 Aug 2026 05:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787115794; cv=fail; b=JeDY9lfgW4yHEA56pSVMmkEbNoNWLgr+VuDt9ZnNA8F0OIja1gBMae/UDR7kDA05z23yg4CSSBhJrdV+rQDVSoq/39C2X8Yu3amRDDtz6EaSD7d48fQqSrh0KjD6vZiOHA6qJAcQVo6qYRq6eEnrcWsaMk00ZFLLEJIAF+YVJ1w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787115794; c=relaxed/simple;
	bh=iNC7Qb259Z1EBK+a51UM9x6QzQW8pBULkS2CeQB621w=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dQ1HGEtZ7q6tZ+Yf5q1dXKfk/KMtTFd4KqaOYLOVdBIVwakYN9ZoDFM2pmmUJwE5Fm+jomxOY/EYdsElhB7cpklFX9OttYJQRG14qhHHIX7ogbOu5QxlSvV19+UYGhS9uHvRDYuAoYGu7kQATde18o9U76rskrf3QqicOXZ1h+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TW7KXvSG; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TW7KXvSG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787115793; x=1818651793;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iNC7Qb259Z1EBK+a51UM9x6QzQW8pBULkS2CeQB621w=;
  b=TW7KXvSG/zFfUVpVu1X9Ndx3wtN71p1fNGHyS2gTfD8glFynaI1sf6U7
   pcvfggQ4aQH+PXQJugLMZBXikxAORrr540ZDaT4blOnjsN0jDvA3lnD9n
   6LyDw3+jR7EjjkgTx9SffWp8JGkQaulk3GjZyurPPu7nT3AnQ/ikj96Hp
   qcCq+kA0wLEMcJjfUwWRB/aNr+b45gu2XkmZx9+QntoeM+Mis7g6llJ1p
   rO1D6Nvz3DY9JIKQxNB+ppPChzMI7K9CH5z8zAiDyyiUygPLhig5hpYFP
   RsSBQfZ+kOIhbSDQlXu2CWa2P4viNAHseErOR+MN0dk44WUbOVM0ae5zR
   w==;
X-CSE-ConnectionGUID: 7qUOI8uVTpKci8N32Wh3/Q==
X-CSE-MsgGUID: DklHCgdQRTGJT/dGE7i6IQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11879"; a="98978093"
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="98978093"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 22:03:11 -0700
X-CSE-ConnectionGUID: cq9Tp05wQEGCGzFcKqyY9Q==
X-CSE-MsgGUID: ybuWzuUwQRKcMhwffLqa8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="267396416"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 22:03:11 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 18 Aug 2026 22:03:10 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 18 Aug 2026 22:03:10 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.18) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 18 Aug 2026 22:03:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YVA/bNlePwulUc3X5Dy/SxziTOiXWWcXcxgPfP0YbxPHx+Tti5gF6z2O0XvCHHVtNldV+SPZOX6NM6S8ydnYbETUFy3qK3ETOjxWLrSpreLkIgO8YOrBHUPOTOue6EG8oeM35XkIFywVmWIc8hnKw7ImgSMXrgArXtmn/9POnn36rgAS5/xBN7S5fDpfmbjM6XJWH6byxtLxRs8vOfiz3To4q2IQ2GYSj3yYJPS8RDAk7ttzqTY7Q4MHpQdJlLYjQ1caA3kqPdEoYsF+IVtUZfNTOj7EJuN0+p0d8WlqeE81mYV08L1XW7ZcnDlnEu8eWRdJoqypzMi49uRTysnM0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Ecxfp+1qvG8vzZUfe2z+hm/yU4+le08w111PVXsfes=;
 b=Sxou7sOQu5ZOLSwOsN21PsqhInqGMXD6LBKF13h8nQbGJJgNlmPEqIyuiRAUcA2HpkJXO2InP26B6fMujw9dmguTmTqUUBnWb4qRp33CbDEBuVI+8n+u8JeG/CCTNOy0lr7++U17Fh40u5BUqPsN/nV3QNjpFiMm/t0yV9gRtBhGMoXNoJ3zERjwC3xXfu6PwLU35PNjrgEcbqFVoj+7T0xWkbDEeAx1I7NqPFi0Sre0wfG+e0VmKcfq1IGZ6D0JiQKeWRnblxIaGmJYXD5RXL8qpvN89KBTuhCDPTMrCudemXig8o5eM4T8vzPsLHjIluwJ+myJDPR+MV7md1TCdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7997.namprd11.prod.outlook.com (2603:10b6:8:125::14)
 by DM4PR11MB6407.namprd11.prod.outlook.com (2603:10b6:8:b4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 05:03:07 +0000
Received: from DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::24fa:827f:6c5b:6246]) by DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::24fa:827f:6c5b:6246%5]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 05:03:07 +0000
Message-ID: <2f8e907e-1c77-416d-90be-9428ce8242f6@intel.com>
Date: Tue, 18 Aug 2026 22:03:03 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/7] KVM: x86: Use linear_read_system() to read the TSS
 I/O bitmap
Content-Language: en-US
To: Binbin Wu <binbin.wu@linux.intel.com>
CC: <kvm@vger.kernel.org>, <x86@kernel.org>, Sean Christopherson
	<seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner
	<tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin"
	<hpa@zytor.com>, Shuah Khan <shuah@kernel.org>, Peter Zijlstra
	<peterz@infradead.org>, "Chang S . Bae" <chang.seok.bae@intel.com>, Kai Huang
	<kai.huang@intel.com>, Fuad Tabba <fuad.tabba@linux.dev>, Chao Gao
	<chao.gao@intel.com>, Yosry Ahmed <yosry@kernel.org>, Claudio Imbrenda
	<imbrenda@linux.ibm.com>, David Matlack <dmatlack@google.com>,
	Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>, Kishen Maloor
	<kishen.maloor@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
References: <20260806011536.4172258-1-sohil.mehta@intel.com>
 <20260806011536.4172258-3-sohil.mehta@intel.com>
 <41a327bd-cbbd-4530-9f30-9175c5840014@linux.intel.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <41a327bd-cbbd-4530-9f30-9175c5840014@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0007.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::12) To DS0PR11MB7997.namprd11.prod.outlook.com
 (2603:10b6:8:125::14)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7997:EE_|DM4PR11MB6407:EE_
X-MS-Office365-Filtering-Correlation-Id: a5cb5997-2a98-4cc7-62dc-08defdaf281d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|18002099003|3023799007|22082099003|56012099006|11063799006|10067099003|4143699003;
X-Microsoft-Antispam-Message-Info: 9D9fIi/N8wiv3NhfY+QX7J6tdDT0FvHuOsVBNalh9xcf2iHatPVyceaOFI2ub7gKDBi+FN1VNojZgJULMF6wUb7uqHKhT4xFShYc9RDpUCgxszXAfW9rSa5d7j2oTZgwjbbluPkm567mSiRBjeCtmkTG0Ki/kkauswe8g0u5r+et5lVs1Ha2ovr9HVBJdKKj0XnSdDbkGa8vj0jKOR3HOpAqtRWRs2qZ2CuQey1wkiISl0rwISsg1K8rHB09Xk2VZSxrnosIY7GjJ0d2l1jXsJBQaooJKHn2NmnECmdHK9FWLATvXs1xAxSWHKhU1mI+2+Y2ocIBhjeyzyXv+ejpEMAsO7Jh/uPAMTU/Tm7CZq7Mc7VBmxOhIM1dNZhpZvQsqVguAQy3KBs0t25XW6JI/bC43QwnNxg9Gvs+0yycVGh6ukdBhR+81BQjOJ3ZMGL98t1UA170L8SqxPNE/F48JddZT5Ar3LuWkcIe61Sm8zmdggcjQMNJEMUfm7vPjaVSRQEOl4aIDpNiVLIX+16u1jWDg3C6a9HFwWtDdBz5COSABKHrseVQJfOJ+KBDWKup7F/KoREzYLAOeFaY1/LwruT0afbr5SXSUgnJWei3lLaJDSWsquX/lrvqU3O6BRxJgSr5zeLzjrrh6V4n2B3W1PxR9iYUVemI4bYbieVCDgk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7997.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(18002099003)(3023799007)(22082099003)(56012099006)(11063799006)(10067099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?KzVxdldXN01MSWh5d25aMkU1SkdVV0JENGc0SXRiTVZXTXlyWVRWU2dDR2xV?=
 =?utf-8?B?eDlQQWFyTy9ubzBGaW5DVFRGV0dreTh1UHpxbjA5NENXTThkY3NkYWtTZ2hs?=
 =?utf-8?B?ZlhqbW9yQVVxRnZQV3lmUEljcHo1aXVzN0xRaFRJWmNVb0FGN283WTFjUlMw?=
 =?utf-8?B?UzZCbVJvMjBsSHRMUy9UVUljbnBqVzJZRllOVzkzRlFmMEZya1E3MVBIM096?=
 =?utf-8?B?YldqVnc3RGhCNmhaL0VpYU4rSU1xTVNhUVR1OHBnOC8wWkpVNFBxekZsQjln?=
 =?utf-8?B?NjNBSitJQ3o3UjA1Mis3UDZvcEs1K2x3VVk1cGdMR1BZRm1mVFREK2Z1T0pz?=
 =?utf-8?B?MWFGeXcrSTZTcGpjTWhQWm5mSzdUSHgwUk9Jbml5b0J6cXAwNnpmQWtrelZJ?=
 =?utf-8?B?UlpjekpUNkM5MUNBWFBNaXRCQ0pBcGVqQVI2SUpJNWFMbVB3aGplaXRpZW96?=
 =?utf-8?B?M25mVWh6akRGWEJ5TFZUN3NNUUxSalpZYXNxNkFQemMwaHkzamtnT0hmV29Q?=
 =?utf-8?B?aDRsdFdBNTl6VzJMbUxtcHNsZHN4ei8wRlg2eWZkTzBBQjAzRmd0dkNoYnB4?=
 =?utf-8?B?WkE2V3pzS0ZOYjR0SDQrMVNveklRQjErUVZXc2laZVQ1OWJ1UmRSOU5WVkdq?=
 =?utf-8?B?V01EL2RRY1dHNVQ4WStsZURDMnhveG1uQTlJRnZjR2xiaU1vL2hZaTFXemVv?=
 =?utf-8?B?dTlZKzc2cUlUaUswZEpFK2NvQ1FHak5hUTJjUDd3ZVFvZExoRmdENkdRMkY3?=
 =?utf-8?B?ajYwQW5oOGNTdEIyS0xuTTdFMWFyNzhyTVVUSDJScGZvYWVRczBLODBiblZw?=
 =?utf-8?B?aVBYNFFGV2QvUVBXSTkzbmlTQnlNcXZUTFVVbVkxay95UUhVclV4Ny9LcXFH?=
 =?utf-8?B?NGpPZGFQc3pvclpEblkrd0k2UDRHeFBkRXJoVU5JZ3kzakxaRjFPRTFlNXY0?=
 =?utf-8?B?YUxsMGJmN3hKM2NHTXUraWwzK0RLRWRTZVpiUnhqbXlrVEV3cFY5Nnh4anho?=
 =?utf-8?B?SFdnTy9kL0tSMVJyT0JjMHlQR2ZiNm1vZ3NDQUNGNm0yYkhXcktZTHhnM2ZV?=
 =?utf-8?B?d1N1dG9pMEFNOWlCVXhzdVdCZHFLS1IxVlpoQnBJV281Zy9hcmNJZENYSEEw?=
 =?utf-8?B?WkhoMkp5c0JPaTBDZ210WU1oOUV0TUZKdGVXL3BoTkczSmNSREQzUlUxK3M1?=
 =?utf-8?B?cjVnbzk5bGZmK21tRUVsSTJ4WVJOZTV4ZjJqMnNNcElsNkhpQVcvWWNPRmNs?=
 =?utf-8?B?RnZpbEFjakYrM1NZTllOT2RxVjV3dTRvM1R2UGY4UkFmbS9MdGtETUpSTWhE?=
 =?utf-8?B?U1hwVitVZmJxcktDczJSQ2R6eVhkenY5eisrSzFFUVdFR050Q09NNU43RUx3?=
 =?utf-8?B?WmlqTWRUMWVDNWo2R2xha2hvQVlDM1psR2pkR1pZTmFjb3ZvWTlUQVhFcXFo?=
 =?utf-8?B?bVgwUGRwYkNJZ296c0JFYllHQi9IK2c4QlZrR2xDUlZIbVU4aW9HYVNPNmR3?=
 =?utf-8?B?ZkxyZGxMNlFpeVR4aTc5bDJnbW5BRjlSVjRIcUR1N3I4NnAwSWlnUFAvNWxP?=
 =?utf-8?B?Yi9wVkhSR0FGcE95aUZ2eDdVM3p6Y0hDam82RkVDTDNwZXpOWFBONUtIcVk1?=
 =?utf-8?B?UmFFTE5DK0pvUzR5OEVSOEovM1RwN29mNnVHekdtSXYrNldUK3cxWmVrK09i?=
 =?utf-8?B?Zzk0bnFLRTh3RFMvUEh1YlNKM1gwbmg0OGhtS1k1U052MGwzRlFXdVovL05v?=
 =?utf-8?B?SEFjRUpkRlpqay9sd2M2T3R4VnVhWmlyTTg3UmdZSWk4cUs4NWpzQ0dEQ3dk?=
 =?utf-8?B?S0lZR21UR2ZEdXlCSENZZEJPSU1mV3FuUEsraW4wRzhlS3FkcUsva1pjZFFj?=
 =?utf-8?B?MWk4WEl5MEJxTEtjWTRROGM5RXdIb0xKYWh0VDJwTW5EYXRweVo3UjRmL3VS?=
 =?utf-8?B?c0x3ODdRWkxPejRpZysrR21VYndxQkYxcktDRzR6eTZsb29QTndsUXp3K0Uw?=
 =?utf-8?B?VktlVDNva0Z5SXBnWWNlUG1DdGRmRHIwN2NXSGxNaVJlOTQ0R2kyY3VxcXRW?=
 =?utf-8?B?M1VuakN6RFJ1WHZaVnZTVWcwNDZQRklDeW15YVdoMHZzVGJqNE9JWU5vTzZ6?=
 =?utf-8?B?cmFGdEFiempJczVXVlI3eWJWVXVqNkl3ZkxRUHlpczRNVE9xczBOdzhqRDY1?=
 =?utf-8?B?QzYzWE9MU0pWNm5TQ29kelJZRysvQ3VOSjdHWkNJdkcxQ09taFdPcUdiMWVs?=
 =?utf-8?B?NDVUZ09Va1BPYzFKV2NWcWNZdUdpYVA0b2hUVWVCOFFzdlhKTWFtNHFuQW9B?=
 =?utf-8?B?K3NHUUpNSU42dERka1BrVE5PQ2VVblcrcDl4VGtqcjNvQTJ2TUV1dz09?=
X-Exchange-RoutingPolicyChecked: gFaW6X77eF1YqwXLTZfRUX/Iz+jH5sZDAQiWsNacSiBrz4Y1r0aSCU2/rNmn9LD5zgoP25vePvgwo618na+QSDZCWD0/P7zZenD2AHSOG5sP6FBHnwr+yOXdo0xfq6TaC2upzM9Upa0wlXZ1+2TRSJ4RlrP8cKQGyQ/6v0iOGSHJhVnbFtcjLeYb0iuu3stW86HsWMCw0+xWSr2JFsfn/BU8N0SWPiZptmxRoFD/lhGeqlBrvAFZZGGckL6GxtPoQ+qCgPVl50oSEv1vyZKNXanU9oY9SwGo+1jJVpO90rZAKEsKUsMgyfJN/0juXjF6hncW+WApLIuFtAhKnHNHWA==
X-MS-Exchange-CrossTenant-Network-Message-Id: a5cb5997-2a98-4cc7-62dc-08defdaf281d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7997.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 05:03:06.8691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IqsR6gOzhkDy5XuNWoJ1SZDiPyxfck+cl4aeAeziSzlwdJyjs8YRPoq8q2lZBoPGQGcHpLkv04NkNaJT+QYfRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6407
X-OriginatorOrg: intel.com

Thank you for reviewing the patch.

On 8/18/2026 8:19 PM, Binbin Wu wrote:
> On 8/6/2026 9:15 AM, Sohil Mehta wrote:
>> TSS I/O permission bitmap reads are implicit supervisor accesses which
>> are subject to Linear Address Space Separation (LASS) enforcement.
> 
> I am not sure about it.
> 
> According to SDM vol 3a (253668-089US), Chapter "LINEAR-ADDRESS PRE-PROCESSING",
> section "MODE-BASED ACCESSES AND LINEAR-ADDRESS-SPACE PARTITIONING", it defines
> and limits "implicit supervisor-mode accesses" to the following operations:

The way I understand it, this list isn't exhaustive. The wording in
those sections, "Such accesses include the following.." and "Examples of
such accesses include.." suggests that this is not limiting.

> - accesses to the global descriptor table (GDT) or local descriptor table (LDT)
>   to load a segment descriptor
> - accesses to the interrupt descriptor table (IDT) when delivering an interrupt
>   or exception
> - accesses to the task-state segment (TSS) as part of a task switch or change of
>   CPL
> - accesses to a user posted-interrupt descriptor (UPID) during user-interrupt
>   notification processing
> 

For example, this doesn't list the SENDUIPI instruction's access to the
UITT (IA32_UINTR_TT). That one is an implicit supervisor-mode access to
a kernel address at CPL = 3.

In section 5.6.1 (Determination of Access Rights), immediately following
the above examples the SDM says:  "All these accesses are called
implicit supervisor-mode accesses regardless of CPL."

> IIUC, the TSS I/O bitmap read during ordinary instruction execution
> (under CPL = 3) rather than during a task switch or CPL transition, I don't
> think they fall under the classification of implicit supervisor-mode accesses.
> 
AFAIU, the entire TSS struct (including the I/O bitmap portion) is
mapped at struct cpu_entry_area using CPU_ENTRY_AREA_BASE with
PAGE_KERNEL_RO permissions. So bit 63 will always be 1 and U/S = 0.

Yes, the TSS I/O bitmap access happens at CPL = 3 but it still has to be
an implicit supervisor access. If it weren't, any user instruction
access to the I/O bitmap would always generate a fault (even without
LASS), right?


Sohil

