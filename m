Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C757344DA8;
	Thu, 10 Sep 2026 20:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789072793; cv=fail; b=jf/D4B8rxj9PRYYq/Sw4pSUDMb2whO+oULlVtTzANncF86nruseBsjg6NHpBdAorQ12Nkr4dYoUNbxCxqySGSYXMTVsjVD13FP0SP/CzWpI1SH2buBwmLKuT2t4ed3GQ+lMALuJnkXx/DP3aYsEfUjZkxdU3iHP2f97743dGBlY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789072793; c=relaxed/simple;
	bh=H9AHgrd3o6H+WGVHlPX0jWLdTDNiYwR4+Beultkf5tA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nOfggHY46qvcriyAHXlwY8YSgMaLaqflnf0nR76xp8Z5N/65b5Xlodf2hhZn/DzzL7RWspuPPXsyHcH5oZuq8Z6xSqHgQIz34YSgQYu4VEY0i4hb7u89bMy9EQcWqo/hqFn1OGzfTEBUD5f/sDF7g/WtqBpdTaAnPv3tp2Gqwxo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DsluloSu; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DsluloSu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789072791; x=1820608791;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=H9AHgrd3o6H+WGVHlPX0jWLdTDNiYwR4+Beultkf5tA=;
  b=DsluloSuvU8eR3ON4ib9pI2w6redn3x20U03ljzHQBNvlwRIMAreXk20
   cHN1yemYt5N6Kb8rlTZIi9mJcrkJfM6uwnifrx2cR0/apwoKFziPzTRD3
   41/qqhPE66brWuGhafzd14z8S7rYwbcFZtVwozRCz3XDuSpcP6T1nL+m8
   QiDGFpwqkLGDYZQJYF3tG3ljfsd+ry9YIK6DE69BTPWFVMZmE6QlP0pI5
   CPcAFayYRL80oulEcSLa7H6RRg7VoS0amvyLAMwpgCPWEQ8lpF7liqCXp
   Z2aEtIJKFTbmBaRKWLRDgOcAmlBC4rDFq5OftQCFZT34qCbHEJDmuGby+
   Q==;
X-CSE-ConnectionGUID: T3YcgIsQQMquomfBVjmtsQ==
X-CSE-MsgGUID: gn+VoybVRpqe9qG2f5uBow==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="89548058"
X-IronPort-AV: E=Sophos;i="6.27,96,1787036400"; 
   d="scan'208";a="89548058"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2026 13:39:51 -0700
X-CSE-ConnectionGUID: cYhcHiVVSGCzH3yu8fmOaw==
X-CSE-MsgGUID: qnQ2W+yXQ/uTk+h/fZX49A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,96,1787036400"; 
   d="scan'208";a="275887421"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2026 13:39:51 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 10 Sep 2026 13:39:50 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 10 Sep 2026 13:39:50 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.33)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 10 Sep 2026 13:39:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZJgLOt905B9QzlErY6yjt4KtO9v7CjJq1BEfxIJZLM7MrO3LbzJhAfjAnf2OUZzRnlK9lNT/sQ2uXCUIsyxKRV1kOZBx78gbOf5TZyinAuUZkNvXiRdGo3z9o7Llb9p5rIALzupMOqMDHAp+1W+e9Z0O/rZApBma8qdOsYtu3dGw/7uxxyR9esiyCAtvS5MzbmxfLyXDiYwI3npGHIcJ1NXe0C1KS8PTW7PuPMmuhBRafXr7suEh7/uhhdYFDQ9cY+g7GamkeTUQfG7O1KAAMlh75f4qZixDorbQJls3pY6j4khH5n/HZvcf/mlju5vvf9ujtGh4DfbvJaZld0d12g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H9AHgrd3o6H+WGVHlPX0jWLdTDNiYwR4+Beultkf5tA=;
 b=bTk1u4YK31ydrsYJsvE4/Qc3aGq+FhH1kT0oI/UwpxCnQMU5Cy6QBihyB5I/0i6uLhXhgsslUi04SDQQ7dyWkHnccTRx0hZzslE58kGPxHhcrUA0jplwb7mpxScqEqTm0vf53Zv5Wt7h6r0VMFEKvDbZCcZGE6FP3i9GYHoAeWPjoD1VbOfJE75GM2jm+7nIHhQ668PtjfpauW8dulOczO0chBTjdHR8VX5fBE1puZ2536cWGFrqJlSGL2SGgeE6Ne3rrLJGFDfQssfS34grCH8JieWw/jKtQXYALGvnCkuMyfYb9MolIHtjsDMA478UfRvtu8W0+Kub4rqnRGw4ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by DS6PR11MB044113.namprd11.prod.outlook.com (2603:10b6:8:4c4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Thu, 10 Sep
 2026 20:39:48 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 20:39:47 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Verma, Vishal L" <vishal.l.verma@intel.com>, "kas@kernel.org"
	<kas@kernel.org>, "x86@kernel.org" <x86@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "ak@linux.intel.com" <ak@linux.intel.com>
Subject: Re: [PATCH] x86/tdx: Remove the early #VE handler
Thread-Topic: [PATCH] x86/tdx: Remove the early #VE handler
Thread-Index: AQHdQVJIriwy64Eilke8gkXVO7WINbbIRmSA
Date: Thu, 10 Sep 2026 20:39:47 +0000
Message-ID: <b41da075607d1eaa9d96eddbf3acc24502edd604.camel@intel.com>
References: <20260910-b4-tdx_remove_early_ve_handler-v1-1-bf47a4d360c5@intel.com>
In-Reply-To: <20260910-b4-tdx_remove_early_ve_handler-v1-1-bf47a4d360c5@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|DS6PR11MB044113:EE_
x-ms-office365-filtering-correlation-id: 07f32aec-a0ce-46bf-7c0c-08df0f7ba7a4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|38070700021|3023799007|10067099003|11063799006|5023799004|56012099006|18002099003|6133799003|22082099003;
x-microsoft-antispam-message-info: 7vIj311hg7QWEJP2OeiU0FXo2KNKJSq+1Dtc6hKsq7izHOzVBoBgNVQ+oZ9gNUs+zpH8OyN/gKUcVSC5DGKh5xv3X/y95r1kTaO0RefmmfOs1kY3VjHTliyDnM2Wg7RUhjLeBoKTfaJEYRM+XlMvMW/2xA0neasKVgkRYT//UG/Hmk3SlnH42ijYET49hkoTkLFz8e1+6Gm5bVzDB5FVTqR0ueAM0XybulqhtxPLzTceSYwVUuI+V6eQwaLlK629PZfL0UudFgEI43/gtUoTZ8hFaV+8T/BN7plFVjWiWwnOEpi+YyCTZPhR1Cd7xTd/PRwJn80lal54q8GCawkdOni+OwYrjTce8tWbK+YIPwD20JtGggyhZxUBTQOlhNRoCWkANHCemDulOm3n8EJOmxcMVjFH+YNqOEf34WNArkmnmXVLzpudB92xcDwsv2RdkepBlkkcAF+vkf2tVqkd/HbiSJz1K5FYk33gmK+C+F75SJjzOasqBnc9kYYXZhI2HvdqI2ZwU3ToXQVs2kYoFQn1KHVCuDBrPD6FM2IBu4gNFs5zQY0ap4fLVSfZ4/gRugsoxJEVAUu7RPkOSH8nv2c2GcAuUxfx2NsymbXccBQq9JHgF6zvVoJWvh8HNdYkAcUpjaMjGXkb5qcnDCSxkere/DVWnono8YAA8v4aR5ME97zR+NZGWKS0kFMxeWXjYoWW3AqUU2RJG9EsR3fpRN9Tj5gBxRGrd9E4Pida7fQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(38070700021)(3023799007)(10067099003)(11063799006)(5023799004)(56012099006)(18002099003)(6133799003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VVB1UXNmN1d3VTFXaXhuWnphb1hBZjBaSEdiZTh1alhsWHhHeXk2WGMrbGlO?=
 =?utf-8?B?a0ROWkY2MU9vVzVHb1pXc1EvQVpCUm1EMjVwNGQ1NGwrWGh0MFRzby8yZkFF?=
 =?utf-8?B?eFdqL3RDMGpMaUx3SW9RRWlxK21BSG84ZW96bEV4dlNUTnRWbFNhcGdscjJL?=
 =?utf-8?B?MFdpQVh3cVRhWE9Wcjl5aVhieGxORVZaUitqcW5TOGo0N21ZRFEzaGlDb21n?=
 =?utf-8?B?dkoxSXNnMFJFOXVySzc3czRoN3BqbEQyTlozazRxN2Y5Y24vUVVqQjF1dEkv?=
 =?utf-8?B?Q0M2cGFJSWxTajhpbzVYZDJxM0NSdTg1Tmk0cHNBMUluSVVjSEduYnhRemh2?=
 =?utf-8?B?Y25kTHJxbWx6dEdZdkNYTDY2SWdVN3ZJenlUYTl3Ri9UTkQ2THMvOG5ZVVFR?=
 =?utf-8?B?RzBsMjcvMzdBOEtvck5qTGxkY01xRVpHZkhjU0JqMUhuTFpXU2M2b1VWdHRY?=
 =?utf-8?B?ckQ4c29EN0V4TDQ1UlFOczV3VVhNUThrTmRlUkF1TE5oRDZqTWhNR2lHN2Y5?=
 =?utf-8?B?eFJNVXRWN2ttb2w0Z2xNT21ib2dnV1pWQzVnVld3VEx2K2Vab3ZZNjBtbDhQ?=
 =?utf-8?B?c0F5bnMzUkx5OFZTRTBIcDBzTkhMOUtva2Rjd2RVNjR1eDBYWCtFUHJwbEdt?=
 =?utf-8?B?dEliZ3JVc3Z1bU00ZTFoQ2pvTDF2dDlqd0lGcnFvTDhaOEluaUVMM2MvU1pI?=
 =?utf-8?B?UVBHekZWcjByNk1HczRqTUJaVktiajBQamZFOUZyMUN6VE9GZ1V1MUJFWWM4?=
 =?utf-8?B?S3UyMG12ZXZNVmN1d0RKVHF2WnlNUFJsVGd3ZnA1WXVkQTBXelhXQnl3ZjNx?=
 =?utf-8?B?Y0ZwalNBRVpIU1NBTFkrUU1tckdPWWZLT2grV3M0Q3JPODFGd1pQSE9ZdkNC?=
 =?utf-8?B?anhzQUVCMHY2RkdQdzlENGF0ais5OHo1ZWN2M0NweG5mWDk4U01FYStudUhZ?=
 =?utf-8?B?WnFZSElnZ1B4d2xaZ1hzNnBXTmI4U0hndFZSc05LTTRmQ2VHT1F1cFpOd0o3?=
 =?utf-8?B?Q08wT1FDcUs0cUFtWTRPWmxxczhaVU1PL05uSEl3N1czcDBhc1A5NXFwcDZZ?=
 =?utf-8?B?ekFXalRWekIzZzR6QUp3TGpPR1FwK25HY0hkNmtjLzdCVndnNmpqc01aRnU3?=
 =?utf-8?B?d2JGZlk1TnV3dnVrK3lmNVpVWUJJcHBsTjlGYlM2d1I1QTVRN0ttUHNBWEVW?=
 =?utf-8?B?Y2NzMC9yMWdycnAwNzlsL3lkaHFMZ1M2a3grN0FXbW1vVDJkMDlYQ0M4QkNj?=
 =?utf-8?B?Ri80WnU3bHBUekR4eHN1a1lpRTJzeWVwOGpMa3FUM1JTQUFMakFMTTRyaTEx?=
 =?utf-8?B?Q0l3VEdTOHp4YUVpdWliZVBVQmFTTHVZZXZid09KL2JrR050dTFpK3ovSTlW?=
 =?utf-8?B?QVhPaUNNUnJOTGc5RE9iY1FOQjlBUzRwdmV6LzRJVWxoSVBGOHRnM3hiSjY0?=
 =?utf-8?B?RXhWZzFiTmdNbjdvUFYzc3ZPWWVJaWlUaWVsVHlmWkZaL3ZJVFJNMXVOcS9l?=
 =?utf-8?B?Nm1TOFN6dXJhbjdxUzA0TWJUZkhmMjh5d2ZJd204Z0l2UGNBT2NlNENha3ZB?=
 =?utf-8?B?SWJoT2NKZkhvY2RPVmhJYm1FQmNHZ2k4b1JLcjkwR2s0akVwL3BYTzRaaWVX?=
 =?utf-8?B?Z2k3TnUzK3R4UERGR0dmaHdjMWpra00rSlRRdmlPRTFCK3MxS3dWb0N5eVBS?=
 =?utf-8?B?amNBZjRZUWI0am9WUG5ieCtoOGMyQWZIUjRQTHZwNFhvUG5QdkgwVDUyVUhN?=
 =?utf-8?B?dzRoa2lxaWJmR0V6R2d5ZThjVm9NakNOL0VlMXp3Z01aK0xoYjJabURjVnov?=
 =?utf-8?B?cThucS84bStDUXdSTENTdUZvY0tOY05ZUWlHSGxUSm5ITTFZaC84QTh3MnR5?=
 =?utf-8?B?QjNNd3FrV29FMXRWU2k3TU5keng1L3hHRTY2UWVuTTZWVFJ6ZVZlWUVuMEps?=
 =?utf-8?B?eE1WSUp3TEp5UG1neGVNSWxXYUtLbVlteEhsMzNMQk1lL2RqQXRLdUVlMlFU?=
 =?utf-8?B?b21NSGRySEhlN2V2bXdlbFZ5RnhsdUR2YVloRHNhVnFhMjNaOVQ4Yms5RjNq?=
 =?utf-8?B?ejJLWWY5ZzZrclpSWkc2M3l5UTZNeStnUzNwRE4wTU91MFNQeFRDSmtoL1FR?=
 =?utf-8?B?amJPMTNFTVEyRFlCSzlEOXRmMjkvT2lmZzZzVno4RktZenN2UkFOMk1MUE5L?=
 =?utf-8?B?ME5rYzlMK2hvY2s3OUxQVHB6NFY1MW1LRUM1TTZGc2tycWJrZjdHSEdKMlpv?=
 =?utf-8?B?WVNVTTRKNEl2a1NQZUk3OU1VM2U5Q1JRMG1kTXB6TEdPeVdzZStzSnVjRnlZ?=
 =?utf-8?B?aTlEWDUxSXFKNXpHYXUxUVlCU1hXSGNSNkpIOXpGeHNFclV0SUtORUhKVmlp?=
 =?utf-8?Q?ExQ0LvAME5MQZgSY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <728C64FE2503794F90C4C116314631FB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: xMfZU57DKnO9O9Y9Th/4mcHrbfA+x4jQd2TFyAVSlXg/+98PDFc1zEVKb/Yah98kURXJ+lo8lBwsbEpnciU0jwbZ70e/9+kFqrH3jUIWXNY99gK/dVdkfSUVBIKPvLQgBHdMueHgpzKq7v0RVfuDJKli/uO1EHQLATF1q6h/rfhI/yzpvVU8uhGP6R/7dnzQll97UHBWdrPi22b35eICU74XPjo1tPNQUZATi6tvI9PDXbL9jClqhGf8IOgsy2PjyQ/1O7P4KJ+uqkKgbvWNDthjiDvV/JS5YgGAAlYVKiKOertgO9SGFH0uB7WcsoFTqpOhdAV/0rP899b6rP8nTg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07f32aec-a0ce-46bf-7c0c-08df0f7ba7a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2026 20:39:47.7724
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jy9VRelCOvmvcBboLU+3fkHCfGUFvHgN3wqfVvF9zzk03CW3xhE4HLne3XsqCqwm06KTvSyy15SVFPqNhDycG/Q7JfSdKvNUhHgHk/r3ttE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR11MB044113
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI2LTA5LTEwIGF0IDEyOjI4IC0wNjAwLCBWaXNoYWwgVmVybWEgd3JvdGU6DQo+
IHRkeF9lYXJseV9oYW5kbGVfdmUoKSBlbXVsYXRlcyBwb3J0IEkvTyBmb3IgI1ZFcyB0YWtlbiBi
ZWZvcmUNCj4gaWR0X3NldHVwX2Vhcmx5X3RyYXBzKCkgaW5zdGFsbHMgdGhlIHJlYWwgI1ZFIGdh
dGUuIFBlciBjb21taXQNCj4gMzJlNzI4NTRmYTVmICgieDg2L3RkeDogUG9ydCBJL086IEFkZCBl
YXJseSBib290IHN1cHBvcnQiKSwgaXQgZXhpc3RzIHRvDQo+IHN1cHBvcnQgZWFybHlwcmludGsn
cyBzZXJpYWwgZHJpdmVyLg0KPiANCj4gImVhcmx5cHJpbnRrPSIgYW5kICJlYXJseWNvbj0iIGFy
ZSBib3RoIGVhcmx5X3BhcmFtKCkgaGFuZGxlcnMsIHNvIG5vDQo+IGNvbnNvbGUgY2FuIGJlIHJl
Z2lzdGVyZWQgYmVmb3JlIHBhcnNlX2Vhcmx5X3BhcmFtKCksIHdoaWNoIHJ1bnMgZnJvbQ0KPiBz
ZXR1cF9hcmNoKCksIGFmdGVyIGlkdF9zZXR1cF9lYXJseV90cmFwcygpIGhhcyByZXBsYWNlZCB0
aGUgZWFybHkgSURULg0KPiBOb3RoaW5nIGluIHRoZSB3aW5kb3cgYmV0d2VlbiBpZHRfc2V0dXBf
ZWFybHlfaGFuZGxlcigpIGFuZA0KPiBpZHRfc2V0dXBfZWFybHlfdHJhcHMoKSBkb2VzIHBvcnQg
SS9PLCBzbyB0aGlzIGVtdWxhdGlvbiBkb2Vzbid0IGV2ZXINCj4gZ2V0IGNhbGxlZC4NCj4gDQo+
IFJlbW92ZSB0aGUgaGFuZGxlci4gQW55ICNWRSBpbiB0aGUgZWFybHkgd2luZG93IG5vdyBmYWxs
cyB0aHJvdWdoIHRvDQo+IGVhcmx5X2ZpeHVwX2V4Y2VwdGlvbigpLCBhcyBpdCBwcmV2aW91c2x5
IGRpZCBmb3IgI1ZFcyB0aGF0IHdlcmUgbm90IEkvTw0KPiBpbnN0cnVjdGlvbnMuDQo+IA0KPiBG
b3VuZCB3aXRoIHRoZSBoZWxwIG9mIGFuIExMTSBvYnNlcnZpbmcgdGhhdCB0aGUgcmVhbCBJRFQg
aXMgaW5zdGFsbGVkDQo+IGJlZm9yZSBwYXJzZV9lYXJseV9wYXJhbSgpLiBMTE1zIHdlcmUgYWxz
byB1c2VkIHRvIHZlcmlmeSB0aGlzLiBPbiBhIFREWA0KPiBndWVzdCBib290ZWQgd2l0aCBlYXJs
eXByaW50aywgYSBjb3VudGVyIGFkZGVkIHRvIHRkeF9lYXJseV9oYW5kbGVfdmUoKQ0KPiBmb3Ig
dGVzdGluZyByZW1haW5lZCAwIGFmdGVyIGJvb3QuDQoNClRoZSBsb2dpYyBhbmQgaGlzdG9yeSBt
YWtlcyBzZW5zZSB0byBtZS4gSSdtIHN1cnByaXNlZCBlYXJseSBwcmludGsgaXMgbm90DQp1c2Vm
dWwgdGhpcyBlYXJseS4NCg0KUmV2aWV3ZWQtYnk6IFJpY2sgRWRnZWNvbWJlIDxyaWNrLnAuZWRn
ZWNvbWJlQGludGVsLmNvbT4NCg0KSSBzZWUgZG9fZWFybHlfZXhjZXB0aW9uKCkgLT4gaGFuZGxl
X3ZjX2Jvb3RfZ2hjYigpIGhhcyBzb21lIGVhcmx5X3ByaW50a3MoKS4NClByZXN1bWFibHkgdGhl
c2UgZG9uJ3Qgd29yayBmb3IgdGhlIHNhbWUgcmVhc29uPw0KDQo+IA0KPiBTaWduZWQtb2ZmLWJ5
OiBWaXNoYWwgVmVybWEgPHZpc2hhbC5sLnZlcm1hQGludGVsLmNvbT4NCj4gQ2M6IEFuZGkgS2xl
ZW4gPGFrQGxpbnV4LmludGVsLmNvbT4NCj4gQ2M6IFJpY2sgRWRnZWNvbWJlIDxyaWNrLnAuZWRn
ZWNvbWJlQGludGVsLmNvbT4NCj4gLS0tDQo+ICBhcmNoL3g4Ni9pbmNsdWRlL2FzbS90ZHguaCB8
ICA0IC0tLS0NCj4gIGFyY2gveDg2L2NvY28vdGR4L3RkeC5jICAgIHwgMjIgLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLQ0KPiAgYXJjaC94ODYva2VybmVsL2hlYWQ2NC5jICAgfCAgMyAtLS0NCj4gIDMg
ZmlsZXMgY2hhbmdlZCwgMjkgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC94
ODYvaW5jbHVkZS9hc20vdGR4LmggYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS90ZHguaA0KPiBpbmRl
eCA4OWU5N2Q1NzYxZDguLjQ5NTE1NGE3ZDc3ZCAxMDA2NDQNCj4gLS0tIGEvYXJjaC94ODYvaW5j
bHVkZS9hc20vdGR4LmgNCj4gKysrIGIvYXJjaC94ODYvaW5jbHVkZS9hc20vdGR4LmgNCj4gQEAg
LTc1LDggKzc1LDYgQEAgYm9vbCB0ZHhfaGFuZGxlX3ZpcnRfZXhjZXB0aW9uKHN0cnVjdCBwdF9y
ZWdzICpyZWdzLCBzdHJ1Y3QgdmVfaW5mbyAqdmUpOw0KPiAgDQo+ICB2b2lkIHRkeF9oYWx0KHZv
aWQpOw0KPiAgDQo+IC1ib29sIHRkeF9lYXJseV9oYW5kbGVfdmUoc3RydWN0IHB0X3JlZ3MgKnJl
Z3MpOw0KPiAtDQo+ICBpbnQgdGR4X21jYWxsX2dldF9yZXBvcnQwKHU4ICpyZXBvcnRkYXRhLCB1
OCAqdGRyZXBvcnQpOw0KPiAgDQo+ICBpbnQgdGR4X21jYWxsX2V4dGVuZF9ydG1yKHU4IGluZGV4
LCB1OCAqZGF0YSk7DQo+IEBAIC05MSw4ICs4OSw2IEBAIHZvaWQgX19pbml0IHRkeF9kdW1wX3Rk
X2N0bHModTY0IHRkX2N0bHMpOw0KPiAgc3RhdGljIGlubGluZSB2b2lkIHRkeF9lYXJseV9pbml0
KHZvaWQpIHsgfTsNCj4gIHN0YXRpYyBpbmxpbmUgdm9pZCB0ZHhfaGFsdCh2b2lkKSB7IH07DQo+
ICANCj4gLXN0YXRpYyBpbmxpbmUgYm9vbCB0ZHhfZWFybHlfaGFuZGxlX3ZlKHN0cnVjdCBwdF9y
ZWdzICpyZWdzKSB7IHJldHVybiBmYWxzZTsgfQ0KPiAtDQo+ICAjZW5kaWYgLyogQ09ORklHX0lO
VEVMX1REWF9HVUVTVCAqLw0KPiAgDQo+ICAjaWYgZGVmaW5lZChDT05GSUdfS1ZNX0dVRVNUKSAm
JiBkZWZpbmVkKENPTkZJR19JTlRFTF9URFhfR1VFU1QpDQo+IGRpZmYgLS1naXQgYS9hcmNoL3g4
Ni9jb2NvL3RkeC90ZHguYyBiL2FyY2gveDg2L2NvY28vdGR4L3RkeC5jDQo+IGluZGV4IGY5MDRh
NjM2ZDQ0OS4uOWJjNzhjYjI4NzEwIDEwMDY0NA0KPiAtLS0gYS9hcmNoL3g4Ni9jb2NvL3RkeC90
ZHguYw0KPiArKysgYi9hcmNoL3g4Ni9jb2NvL3RkeC90ZHguYw0KPiBAQCAtNzU1LDI4ICs3NTUs
NiBAQCBzdGF0aWMgaW50IGhhbmRsZV9pbyhzdHJ1Y3QgcHRfcmVncyAqcmVncywgc3RydWN0IHZl
X2luZm8gKnZlKQ0KPiAgCXJldHVybiB2ZV9pbnN0cl9sZW4odmUpOw0KPiAgfQ0KPiAgDQo+IC0v
Kg0KPiAtICogRWFybHkgI1ZFIGV4Y2VwdGlvbiBoYW5kbGVyLiBPbmx5IGhhbmRsZXMgYSBzdWJz
ZXQgb2YgcG9ydCBJL08uDQo+IC0gKiBJbnRlbmRlZCBvbmx5IGZvciBlYXJseXByaW50ay4gSWYg
ZmFpbGVkLCByZXR1cm4gZmFsc2UuDQo+IC0gKi8NCj4gLV9faW5pdCBib29sIHRkeF9lYXJseV9o
YW5kbGVfdmUoc3RydWN0IHB0X3JlZ3MgKnJlZ3MpDQo+IC17DQo+IC0Jc3RydWN0IHZlX2luZm8g
dmU7DQo+IC0JaW50IGluc25fbGVuOw0KPiAtDQo+IC0JdGR4X2dldF92ZV9pbmZvKCZ2ZSk7DQo+
IC0NCj4gLQlpZiAodmUuZXhpdF9yZWFzb24gIT0gRVhJVF9SRUFTT05fSU9fSU5TVFJVQ1RJT04p
DQo+IC0JCXJldHVybiBmYWxzZTsNCj4gLQ0KPiAtCWluc25fbGVuID0gaGFuZGxlX2lvKHJlZ3Ms
ICZ2ZSk7DQo+IC0JaWYgKGluc25fbGVuIDwgMCkNCj4gLQkJcmV0dXJuIGZhbHNlOw0KPiAtDQo+
IC0JcmVncy0+aXAgKz0gaW5zbl9sZW47DQo+IC0JcmV0dXJuIHRydWU7DQo+IC19DQo+IC0NCj4g
IHZvaWQgdGR4X2dldF92ZV9pbmZvKHN0cnVjdCB2ZV9pbmZvICp2ZSkNCj4gIHsNCj4gIAlzdHJ1
Y3QgdGR4X21vZHVsZV9hcmdzIGFyZ3MgPSB7fTsNCj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tl
cm5lbC9oZWFkNjQuYyBiL2FyY2gveDg2L2tlcm5lbC9oZWFkNjQuYw0KPiBpbmRleCBmZDI4YjUz
ZGJhYzUuLjdiOGIxM2Y0NTQ1NCAxMDA2NDQNCj4gLS0tIGEvYXJjaC94ODYva2VybmVsL2hlYWQ2
NC5jDQo+ICsrKyBiL2FyY2gveDg2L2tlcm5lbC9oZWFkNjQuYw0KPiBAQCAtMTY2LDkgKzE2Niw2
IEBAIHZvaWQgX19pbml0IGRvX2Vhcmx5X2V4Y2VwdGlvbihzdHJ1Y3QgcHRfcmVncyAqcmVncywg
aW50IHRyYXBucikNCj4gIAkgICAgdHJhcG5yID09IFg4Nl9UUkFQX1ZDICYmIGhhbmRsZV92Y19i
b290X2doY2IocmVncykpDQo+ICAJCXJldHVybjsNCj4gIA0KPiAtCWlmICh0cmFwbnIgPT0gWDg2
X1RSQVBfVkUgJiYgdGR4X2Vhcmx5X2hhbmRsZV92ZShyZWdzKSkNCj4gLQkJcmV0dXJuOw0KPiAt
DQo+ICAJZWFybHlfZml4dXBfZXhjZXB0aW9uKHJlZ3MsIHRyYXBucik7DQo+ICB9DQo+ICANCj4g
DQo+IC0tLQ0KPiBiYXNlLWNvbW1pdDogZGYyOTA4MDkwY2RhMzY4YjAxZmY0MzcwOWY1MTg5MDA3
NmM1NjE1Nw0KPiBjaGFuZ2UtaWQ6IDIwMjYwODI4LWI0LXRkeF9yZW1vdmVfZWFybHlfdmVfaGFu
ZGxlci03YzE0NjNjZjBmNjMNCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gLS0gIA0KPiBWaXNoYWwg
VmVybWEgPHZpc2hhbC5sLnZlcm1hQGludGVsLmNvbT4NCj4gDQoNCg==
