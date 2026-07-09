Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A1C1A683B;
	Thu,  9 Jul 2026 00:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783557229; cv=fail; b=GZd0P02PEfONQcp44/XV7iUuOSIJmHFkrn6vkIrbE6H31slkIiPb8yucqOnD7uAgM8QJBOX45mHlEsC/6T6wtihUhCiaHmhxKYbJzWZ+mhe60v7YbhYRnujv2mTHF1Bs2dLl+na3fm42GsL+rwQraMEQEiaJMOMN0RZ+6lF0paA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783557229; c=relaxed/simple;
	bh=eecVyJTj3S5X4a0LJLzTTk5sjvpwRK2ozqUuuoMDXXY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bMV/pL6Qg3793AIhjIl9TX/5qVarSCAyCi1ZPZXUv740lhRmhjtutn081ewix08B4RvCEPjs1FSgk676q7AoChCZlhAfgXdp6BY076pmN9LFRMbbOslmLgIP3DTVq1cXh81rTO7jHiEf3ffT8fE6yszWOIqp8aFgnUiWyJNSRB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XlYVdtdk; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XlYVdtdk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783557228; x=1815093228;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=eecVyJTj3S5X4a0LJLzTTk5sjvpwRK2ozqUuuoMDXXY=;
  b=XlYVdtdka20b76MGICawA/VGeWTz07a86bimlHm2jo7k1uAYyLjMRA+f
   kzZem3J1TMrNXsrs40qnD9ZLKAU7jyjG/g2BieS1ASNnk4qImeThV+6SU
   +3w8wlDhpkDOumHriTidGXtpAGtPMP39xFH4Ixtzb59azdeQkl8ZoPOqH
   7GqE6QJcwSYsiMy5TEnRUAa/J1P0jDxp+GVr7lq3vkrx6PiOXZyKcpXXZ
   gVbuKJa8GqB9QvWz3g3gltwhy6JI9FudzyPWXVS86fL9JtvYVmMAHR+LO
   MHWPEPMk5vrDUbFIC0CV/puBDax1H2os3yBDJIFz+TdKucKXAvbZHF18h
   g==;
X-CSE-ConnectionGUID: 4a92aHYmR3+SuN9chAU+7g==
X-CSE-MsgGUID: /EUDece6R+2Nx4H5gSOKFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="94879820"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="94879820"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 17:33:47 -0700
X-CSE-ConnectionGUID: DUoAqqgrRbuJVFB8xX75QA==
X-CSE-MsgGUID: Ly5AphVMSOGZiOkIDVlVsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="254536999"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 17:33:46 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 8 Jul 2026 17:33:45 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 8 Jul 2026 17:33:45 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.31) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 8 Jul 2026 17:33:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DXDmY0+1liCqSu2KtQvCQ1hOHRPwu3HO49lGt6pYWxvwneaateceWbi+skxouvzcoCzJ0qtzH31r91JB3Peneg9WLCkNoxFok4XveoFOafRoOi+GMVWR23UdPy/TQINyHv81NFt1BWrxbSaAnO9HNeWNijDStPfuau+hQqoBXwckJK8/+B731bTm3laJdaBnGKna24DRdynMRdz5FIIEMMa0qXuzUyc6Ao5U8VDQt7D2HIRcKAbH2l/puzNQoT+9oKFgANd/74DyjiBV/3Mol3ty3rjhOWASrNZrfNavqXPHdizM6i5QGpeX0CA5Dpb+JCB78tpcg7YMpJN7O+MQ6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eecVyJTj3S5X4a0LJLzTTk5sjvpwRK2ozqUuuoMDXXY=;
 b=NywnScJgf+cMfmtPKNfXfrG6ysOTVN7mmiqHiK/VVqlo5MgMnjvNebdqp0Imthe8oI6fE8JW63awGxP+Pzb+BfH33l9783Kb54SA693g3cDWczb8GbrJXB3pEx1+txS57LxNOV1eiaGs1+nbWrtr190KU59KxfFupjXeTS+6zp58cF+6XtL7Ts0hEPsfsRtsTTuHxerxfNJyZlOqgyjoWkn7vky3BA58wNFvBJroLbt70m40vLauNzRM0mgoLTqlv76mhgG2lPsYeuizqgk5DiTXEGL+A5hpEgS/Vp9VMH20uvsLGbZpA64X/1er6bxmwOxOLzh8IRCWIPDHV/b6Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by PH0PR11MB7587.namprd11.prod.outlook.com (2603:10b6:510:26d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 9 Jul
 2026 00:33:41 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 00:33:41 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Zhao, Yan Y" <yan.y.zhao@intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Huang, Kai" <kai.huang@intel.com>, "Hansen,
 Dave" <dave.hansen@intel.com>, "kirill.shutemov@linux.intel.com"
	<kirill.shutemov@linux.intel.com>, "kas@kernel.org" <kas@kernel.org>,
	"seanjc@google.com" <seanjc@google.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"tglx@kernel.org" <tglx@kernel.org>, "Annapurve, Vishal"
	<vannapurve@google.com>, "bp@alien8.de" <bp@alien8.de>, "Gao, Chao"
	<chao.gao@intel.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v6 05/11] x86/virt/tdx: Handle concurrent callers in
 tdx_pamt_get/put()
Thread-Topic: [PATCH v6 05/11] x86/virt/tdx: Handle concurrent callers in
 tdx_pamt_get/put()
Thread-Index: AQHc7LhXfoCfkuUFmkqKqK55gbUxZLZjcZUAgAEqJQA=
Date: Thu, 9 Jul 2026 00:33:40 +0000
Message-ID: <9aa0694b9f0e2057808ed7c69ba6796a1d629bf7.camel@intel.com>
References: <20260526023515.288829-1-rick.p.edgecombe@intel.com>
	 <20260526023515.288829-6-rick.p.edgecombe@intel.com>
	 <ak3ySL89u5+1oCZB@yzhao56-desk.sh.intel.com>
In-Reply-To: <ak3ySL89u5+1oCZB@yzhao56-desk.sh.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|PH0PR11MB7587:EE_
x-ms-office365-filtering-correlation-id: 706dfd70-a046-4933-2b84-08dedd51b9a5
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|23010399003|376014|11063799006|4143699003|56012099006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: NYviHQNV7jdCkzNjdAoXS6xZ6SYJlgTkVIyGuALeqyICS00UP34SymJLVXp8ggGrRb7FkvW7NeJCyOAj/XQnyowfFlQJiloCyrnlWgiPF9QWIYfIo8AqHin7yW+AHZI/pJ2jqwVwkMJMmYigVT/5ucPTDy8B6RD7mBBrBEbPLVvlwPEQAqqAQcv66l2vbo+8GjcAMKTPgC9l4vXc+Q3RWfR5TIaq9kRiPgyG/xNBoNvfIqKuftESWvN0fPJF2em3lTtqHVVF3fxrcrnZB6d1T7vXPGpExIGDQ3QaLW/yAGKh8kM1VqtI+3j+gVNKZDBvGPl2Rc3JWzT2Qyt5LsyFTFGJAGkbcs91xjHtOqEpN4KIO9f255KaHXxMYmqQrL8IaUfFcl77mx3OsljoU0GiO0xlZQ/SjYWUua5F1VL3Fv82qsRoBh12aUQ/TIMyYzzP+uM36U2WFC3w7Nboy/vdnPaEaaeYAtouBpSgU2o0SdALiNiWMxhU/ccgOTgHVAitE7jLHjshGNcTIsiwU8fNISQaGggxvFrH6Ix90hlGC7kZy5WTLbSsW3k7nRNJ7CpvAURaNt+HR48NK9Hz7HKe38GANw5X9RWbK9N7xuMtfY7970QFZa38QEq6HlCM1gPHKUWNM6bSD3KkOhc63zxcxTEzfWSopJodLnGirehynBk5lqivNqTo/ahQxhyQ7Lv7ZIJEAufFdOOlViBn1QICFfcrVhfSO7HuA77l+naWlC0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(23010399003)(376014)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZE13OHFpWGZGWWcvaEQyWjRFaUtsdUF0S1ZPZS8wOUFmOFZnVVl1M3BKc2dt?=
 =?utf-8?B?ZlFObjFHbkI4U2djc3gwb01EeGxESDgzZ21RbUJBRGZTMjFWQUtWNUc2WlNp?=
 =?utf-8?B?ekxqVGxSeXN5TGxhc0hJTW9mTjlRakJPbElQT1gzMUdYb1VXZysyN2xSVUVJ?=
 =?utf-8?B?cisxanUxM01KTUpaRHVRa2RmM3NyYlhpMVNWNXByTkIxbnFHUG9TK1VjZVpU?=
 =?utf-8?B?MzBCQ0cwU1BERmFiaTBvd0pyYzYvTG9PVjduVmNiY0pOTkJTVFY1TTg3UzVJ?=
 =?utf-8?B?Uk5kWnFqc29uSG40d2swSHh1bzZmRkJCa1YwVFA5a1M5MGUydGhFcCtmSkcv?=
 =?utf-8?B?R2RybStqa2wxRXluaENLSkRHN0JveWxzdDR6TDUzQ2dwMFZNcE14RWc5OEpl?=
 =?utf-8?B?M0g5WGlsd244MkY1Z2RWOGs1cC9YTmp0RUZxZVJnUHY3WmdPcjhsaE55T0Rp?=
 =?utf-8?B?K0ZEUnpTYUtBQUNPRU1JdDkrblB6TWVJS2JFV2hwQkkvcEx6SSs1bXZzWHRE?=
 =?utf-8?B?bjlTMENNWnF4VlFYSjg0MnlPU1FhQXhhVEZyWEc3b0ljVEMwWVhFQlZndTNK?=
 =?utf-8?B?VzN0bFdTOVlLR3ZBWjQ3Wm5vam5ubkFCRGNMRjZlZ3BoL1FFNEhqLzVCRUNa?=
 =?utf-8?B?WHdhSVkvZGk1V1FudmZVZWNVUTk1YXVaV3oyOW5VVVlDeGdTZGJLT3Mxdk5x?=
 =?utf-8?B?amtxdDFiUXRZR2tVa2lyN0UxRlhoNHY5bFhVQ0ZrTGVKblo5YXZpVG16N1Jl?=
 =?utf-8?B?RVhDRkpITUYwNHBycmN2eXFGTEFNa0lLVVJBZ3k2ZXVTK1BoUG5UT1c4Tnl2?=
 =?utf-8?B?b1ExMjdHcmZTTjlTejNGU2xFN1FtcGpZRFZlaUNQYVpLT1RpS3B1elJxMUl5?=
 =?utf-8?B?VDFDYWpueWtVdDVBN0Mva2I4L1UrM3pMMEViYm5zM2YvVytrMm9xMHIvYXZQ?=
 =?utf-8?B?Y2I1Tlhxd2xUL0kvNkkrc1JxTDZhYVU4L0l3dG9LUlUvSGp4NFlSNkJyZ1VR?=
 =?utf-8?B?YjVtSFpndEhuVXNQb25iV09BQ2l6TWdFQXpBQnplWi9DdTJ1V2ZxckxVNU1U?=
 =?utf-8?B?RTd0N3QrNzBNNitNZVhqdnRzOVo0cGc5VmJ5MXVIWHpvOFpUTlNIbTVyc0U4?=
 =?utf-8?B?anJBanBld2JSZXlwN1pRUGtBeVNMVE54VUZIRGJWczIydmlqejNLZkNuMmUr?=
 =?utf-8?B?Vy81TG02Rk9SMXdReEFjWTViMDZYSXp6Z0dlalVxNEg2WEZteUNybEEwSDNH?=
 =?utf-8?B?RGtIejJrRUU2OHJZdDNVOFpNWGtHVDR0RHlNMXd0LzAwcXh6UlJPQis1OGV4?=
 =?utf-8?B?QVdKU2x5blp0M04rTU1Sa25pZXZKNUxSbWptTk44Y2NvQlllcERrU2IzbU9a?=
 =?utf-8?B?YWd5RDZMUE9wdWc5MW1qQ3VaVVZRakNmMlIyOVNiQUJGVHd5NWZCSGppTGJz?=
 =?utf-8?B?NzZSTUFMRGkxOFJsNTYzRmdDZTcwOTg1Lzl0eGVMekdVWi83dGxCYlhVdWY0?=
 =?utf-8?B?L3ZobGpwaWU1WitoZVJ4Y2FzUkcrcUY4RjZWQXJxVFFDS1pGa1VPN1JGcU9z?=
 =?utf-8?B?eDlxOXRqR3l6MFczZ0k2KzM5b0NaSC9vRko1SW1Ed3JYWW90Rk1GNDk2VUVx?=
 =?utf-8?B?ZUVyN3gzdWhTQnRhcFdEa0FTY2VjRFA1Q0gxanlzU1BlN2VOWFh2eGxGK2Nq?=
 =?utf-8?B?U3U1WHp0dGp4YkIydHE5U1NNamNmRWVEcmZEdWZCYVNGODJHUzcvSW9ydm1p?=
 =?utf-8?B?cnBFcStuV0UxYlRLWWZ5bS9ta3BZOTEvM002YUJyeEREQkdKQUZqcnEwRjZ2?=
 =?utf-8?B?ZkM1d2phV1ZYV1EzaFh1MTN3Rk54V1NoT0RJOE5kT2tvWWhGQjhyZGNqZUx4?=
 =?utf-8?B?NTVkMTk3aDIyTnNQd09FNXRNOHRWaE04QWVSOVNITVFibDVEL3BvYlZZMlJs?=
 =?utf-8?B?d2dBYWxIakhsNjd3UjEzSTFxNXJucjNZV0tGZE00NlFMZVYvSGdnYTlaM0E5?=
 =?utf-8?B?M2ZSekdkckdvdXkrLzJtVlB3ZVhLYXlvb2ExTHVsWk9lbUxtTFBYSU44UlJB?=
 =?utf-8?B?WHlsREJsVUJaUUw4c21QRmtoZkNYYnlUOFFLK2ZrWjdpREMxSWU3d1JXMnlU?=
 =?utf-8?B?R0pVNERZOEhtT25BdHJHN2c1cjNhWHg4aVR0aTUweDdXZTA5N0pVQnU5Y0h4?=
 =?utf-8?B?aUN3NzByLzRxdWlzVXBnamJVcW1UWmErdDN0aTdqOTBBUi9rcXVXOE9WVHlT?=
 =?utf-8?B?YkI0THdVWW9VMlB1ZWpQTnUrOWpsTzdPMHVxOG5WWjg0YVROK2p6T2pqTDQ1?=
 =?utf-8?B?aGJSRjN5cStFNEV4cTdHRmwxL2VNaVFDL2dpNCtHOE9wK3A0RjJ6cHhvSXNx?=
 =?utf-8?Q?OGECbiNZVtIAzWoY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B3C471E765FEB14386927F7A8BF5B8EF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ZkllEkBNbg1ZdDcuJlTeXKCyE/OI5wkIkkrX0YdJ0B81Q6wSreHqqmzG9/aE5v78fOMs1KB9CrY0qbkV4375UO/UmsEhKgooyYO6ua4VbgnzaO0fuWXzDB2dpnNG7TgkBepprhlCAZ37G23CpOyPhtJnyvdeAT6Hu0PuvfjJIIW9z/h+YugkztmOYPuRjS6NZ1eGSLkxJkRTPmEGzdilaCbUq6OXygHBI8I2Oi5DI5UdNxQruhPh8Iv6+znhZctuntlUpeBWAHnshX6JZagUGElOdetV7zydKj7Ne6ujk3RMi2Tl3hhDBVn5xm0wYo+xXdZj3fNq6Eit+7nOp6892g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 706dfd70-a046-4933-2b84-08dedd51b9a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2026 00:33:40.9776
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G5V+WrqYvyAq2LLAQRvSy6VBJ4kotTPwIqF0p+KqmNSyWtmMYz8FDGxLDUDYkoz5sx/NPl7cPUxGyp3bgZLMFwMooGpEtwQI3xH8yXLK0Hw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7587
X-OriginatorOrg: intel.com

VGhhbmtzIGZvciB0aGUgcmV2aWV3IQ0KDQpPbiBXZWQsIDIwMjYtMDctMDggYXQgMTQ6NDYgKzA4
MDAsIFlhbiBaaGFvIHdyb3RlOg0KPiBPbiBNb24sIE1heSAyNSwgMjAyNiBhdCAwNzozNTowOVBN
IC0wNzAwLCBSaWNrIEVkZ2Vjb21iZSB3cm90ZToNCj4gPiBGcm9tOiAiS2lyaWxsIEEuIFNodXRl
bW92IiA8a2lyaWxsLnNodXRlbW92QGxpbnV4LmludGVsLmNvbT4NCj4gPiANCj4gPiB0ZHhfcGFt
dF9nZXQoKS90ZHhfcGFtdF9wdXQoKSB1bmNvbmRpdGlvbmFsbHkgYWRkIG9yIHJlbW92ZSBEeW5h
bWljIFBBTVQNCj4gPiBiYWNraW5nIGZvciB0aGUgMk1CIHJlZ2lvbiBjb3ZlcmluZyB0aGUgcGFz
c2VkIHBmbi4gSG93ZXZlciwgbXVsdGlwbGUNCj4gPiBjYWxsZXJzIGNhbiBjb25jdXJyZW50bHkg
b3BlcmF0ZSBvbiA0S0IgcGFnZXMgdGhhdCBmYWxsIHdpdGhpbiB0aGUgc2FtZQ0KPiA+IDJNQiBy
ZWdpb24uIFdoZW4gdGhpcyBoYXBwZW5zIG9ubHkgb25lIER5bmFtaWMgUEFNVCBwYWdlIHBhaXIg
bmVlZHMgdG8gYmUNCj4gV2hhdCAidGhpcyIgc3RhbmRzIGZvciBpcyBub3QgY2xlYXIgYW5kIGEg
Y29tbWEgaXMgbWlzc2luZyBhZnRlciAiaGFwcGVucyIuDQoNClJlYWxseSB0aGlzIGlzIG5vdCBj
bGVhcj8gVGhlIHByZXZpb3VzIHNlbnRlbmNlIGlzIGFsbCBhYm91dCBhIHNlbmFyaW8gYmVpbmcN
CnBvc3NpYmxlICJtdWx0aXBsZSBjYWxsZXJzIGNhbiBjb25jdXJyZW50bHkgb3BlcmF0ZSBvbiA0
S0IgcGFnZXMgdGhhdCBmYWxsDQp3aXRoaW4gdGhlIHNhbWUgMk1CIHJlZ2lvbiIuIFNvIEkgdGhv
dWdodCB0aGlzIHdvdWxkIGJlIGNsZWFyLg0KDQpJIGNvdWxkIHNheSAiV2hlbiB0aGF0IHNjZW5h
cmlvIGhhcHBlbnMuLi4iPyBCdXQgdHJ5aW5nIHRvIGtlZXAgdGhlIHdvcmQgY291bnQNCmRvd24u
DQoNCj4gDQo+ID4gaW5zdGFsbGVkIHRvIGNvdmVyIHRoZSAyTUIgcmFuZ2UuIEFuZCB3aGVuIG9u
ZSBwYWdlIGlzIGZyZWVkLCB0aGUgRHluYW1pYw0KPiA+IFBBTVQgYmFja2luZyBjYW5ub3QgYmUg
ZnJlZWQgdW50aWwgYWxsIHBhZ2VzIGluIHRoZSByYW5nZSBhcmUgbm8gbG9uZ2VyIGluDQo+ID4g
dXNlLiBNYWtlIHRoZSBoZWxwZXJzIGhhbmRsZSB0aGVzZSByYWNlcyBpbnRlcm5hbGx5Lg0KPiA+
IA0KPiA+IFVzZSB0aGUgcGVyLTJNQiByZWZjb3VudHMgZnJvbSBwcmV2aW91cyBjaGFuZ2VzIHRv
IHRyYWNrIGhvdyBtYW55IDRLQg0KPiA+IHBhZ2VzIGFyZSBpbiB1c2Ugd2l0aGluIGVhY2ggcmVn
aW9uLiBHYXRlIHRoZSBhY3R1YWwgRHluYW1pYyBQQU1UIGFkZCBhbmQNCj4gPiByZW1vdmUgb24g
cmVmY291bnQgdHJhbnNpdGlvbnMgKDAtPjEgYW5kIDEtPjApLiBTZXJpYWxpemUgdGhlIHJlZmNv
dW50DQo+ID4gY2hlY2sgYW5kIFNFQU1DQUxMIHdpdGggYSBnbG9iYWwgc3BpbmxvY2sgc28gdGhl
IHJlYWQtZGVjaWRlLWFjdCBzZXF1ZW5jZQ0KPiA+IGlzIGF0b21pYy4gVGhpcyBhbHNvIGF2b2lk
cyBURFggbW9kdWxlIEJVU1kgZXJyb3JzLCBhcyBEeW5hbWljIFBBTVQgYWRkDQo+ID4gYW5kIHJl
bW92ZSBTRUFNQ0FMTHMgdGFrZSBhbiBpbnRlcm5hbCBURFggbW9kdWxlIGxvY2tzIGF0IDJNQiBn
cmFudWxhcml0eSwNCj4gImFuIGludGVybmFsIFREWCBtb2R1bGUgbG9ja3MiIC0tPiAiaW50ZXJu
YWwgVERYIG1vZHVsZSBsb2NrcyI/DQoNClllcCwgdGhhbmtzLg0KDQo+IA0KPiA+IHNvIHNpbXVs
dGFuZW91cyBhdHRlbXB0cyBvbiB0aGUgc2FtZSByZWdpb24gd291bGQgY29uZmxpY3QuDQo+IEhv
dyBhYm91dDoNCj4gIlRoaXMgYWxzbyBhdm9pZHMgVERYIG1vZHVsZSBCVVNZIGVycm9ycywgYXMg
RHluYW1pYyBQQU1UIGFkZA0KPiBhbmQgcmVtb3ZlIFNFQU1DQUxMcyB0YWtlIGludGVybmFsIFRE
WCBtb2R1bGUgbG9ja3MgZm9yIHRoZSAyTUIgcmFuZ2VzIG9mDQo+IHRoZSBzcGVjaWZpZWQgUEZO
IGFuZCB0aGUgUEFNVCBwYWdlIHBhaXIgUEZOcywgc28gc2ltdWx0YW5lb3VzIGF0dGVtcHRzIG9u
DQo+IHRoZSBzYW1lIDJNQiByYW5nZXMgb2YgdGhlIFBGTnMgd291bGQgY29uZmxpY3QuIiA/DQoN
CkhtbSwgeWVhLg0KPiANCj4gDQo+ID4gVGhlIGxvY2sgaXMgZ2xvYmFsIGFuZCBoZWF2eXdlaWdo
dC4gVXNlIHNpbXBsZSBjb25kaXRpb25hbCBsb2dpYyB0byBrZWVwDQo+ID4gY29ycmVjdG5lc3Mg
b2J2aW91cy4gVGhpcyB3aWxsIGJlIG9wdGltaXplZCBpbiBhIGxhdGVyIGNoYW5nZS4NCj4gPiAN
Cj4gPiBBc3Npc3RlZC1ieTogR2l0SHViIENvcGlsb3Q6Y2xhdWRlLW9wdXMtNC02IENsYXVkZTpj
bGF1ZGUtb3B1cy00LTcNCj4gPiBTaWduZWQtb2ZmLWJ5OiBLaXJpbGwgQS4gU2h1dGVtb3YgPGtp
cmlsbC5zaHV0ZW1vdkBsaW51eC5pbnRlbC5jb20+DQo+ID4gQ28tZGV2ZWxvcGVkLWJ5OiBSaWNr
IEVkZ2Vjb21iZSA8cmljay5wLmVkZ2Vjb21iZUBpbnRlbC5jb20+DQo+ID4gU2lnbmVkLW9mZi1i
eTogUmljayBFZGdlY29tYmUgPHJpY2sucC5lZGdlY29tYmVAaW50ZWwuY29tPg0KPiA+IC0tLQ0K
PiA+IHY2Og0KPiA+ICAtIFNwbGl0IGZyb20gIng4Ni92aXJ0L3RkeDogQWRkIHRkeF9hbGxvYy9m
cmVlX2NvbnRyb2xfcGFnZSgpIGhlbHBlcnMiDQo+ID4gIC0gUmV0dXJuIDAgaW5zdGVhZCBvZiBy
ZXQgdG8gYmUgY2xlYXJlciAoQmluYmluKQ0KPiA+ICAtIENsYXJpZnkgbG9nIChOaWtvbGF5KQ0K
PiA+ICAtIEp1c3RpZnkgd2h5IHRoZSBwYXRjaCBpcyBub3Qgb3B0aW1pemVkIGluIHJlc3BvbnNl
IHRvIGNvbW1lbnRzIGJ5DQo+ID4gICAgKE5pa29sYXkpDQo+ID4gIC0gTW92ZSB0ZHhfZmluZF9w
YW10X3JlZmNvdW50KCkgdG8gZmFjaWxpYXRlIHBhdGNoIHJlLW9yZGVyDQo+ID4gIC0gQWRqdXN0
bWVudHMgZnJvbSBkcm9wcGluZyBlcnJvciBoZWxwZXIgcGF0Y2hlcw0KPiA+ICAtIExvZyB0d2Vh
a3MNCj4gPiAtLS0NCj4gPiAgYXJjaC94ODYvdmlydC92bXgvdGR4L3RkeC5jIHwgNzIgKysrKysr
KysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNTYg
aW5zZXJ0aW9ucygrKSwgMTYgZGVsZXRpb25zKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2Fy
Y2gveDg2L3ZpcnQvdm14L3RkeC90ZHguYyBiL2FyY2gveDg2L3ZpcnQvdm14L3RkeC90ZHguYw0K
PiA+IGluZGV4IDY2NThhNmJlNjY5N2MuLjUwMzMzZWI5NmVmYTYgMTAwNjQ0DQo+ID4gLS0tIGEv
YXJjaC94ODYvdmlydC92bXgvdGR4L3RkeC5jDQo+ID4gKysrIGIvYXJjaC94ODYvdmlydC92bXgv
dGR4L3RkeC5jDQo+ID4gQEAgLTIwNDMsMTAgKzIwNDMsMTQgQEAgc3RhdGljIHU2NCB0ZGhfcGh5
bWVtX3BhbXRfcmVtb3ZlKGt2bV9wZm5fdCBwZm4sIHN0cnVjdCBwYWdlICoqcGFtdF9wYWdlcykN
Cj4gPiAgCXJldHVybiAwOw0KPiA+ICB9DQo+ID4gIA0KPiA+IC0vKiBBbGxvY2F0ZSBQQU1UIG1l
bW9yeSBmb3IgdGhlIGdpdmVuIHBhZ2UgKi8NCj4gPiArLyogU2VyaWFsaXplcyBhZGRpbmcvcmVt
b3ZpbmcgUEFNVCBtZW1vcnkgKi8NCj4gPiArc3RhdGljIERFRklORV9TUElOTE9DSyhwYW10X2xv
Y2spOw0KPiA+ICsNCj4gPiArLyogQnVtcCBQQU1UIHJlZmNvdW50IGZvciB0aGUgZ2l2ZW4gcGFn
ZSBhbmQgYWxsb2NhdGUgUEFNVCBtZW1vcnkgaWYgbmVlZGVkICovDQo+IEhvdyBhYm91dA0KPiAi
QnVtcCB0aGUgcmVmY291bnQgb2YgdGhlIFBBTVQgcGFnZSBwYWlyIGZvciB0aGUgZ2l2ZW4gUEZO
IGFuZCBhZGQgdGhlIFBBTVQNCj4gcGFnZSBwYWlyIG9uIHRoZSBmaXJzdCByZWZlcmVuY2UuIiA/
DQoNCkkgdGhpbmsgSSBzZWUgd2hhdCB5b3UgYXJlIGdldHRpbmcgYXQuIEhvdyBhYm91dCB0aGlz
IGluc3RlYWQ6DQpCdW1wIFBBTVQgcmVmY291bnQgZm9yIHRoZSBnaXZlbiBwZm4gYW5kIGFsbG9j
YXRlIFBBTVQgYmFja2luZyBpZiBuZWVkZWQNCg0KDQo+IA0KPiA+ICBzdGF0aWMgaW50IHRkeF9w
YW10X2dldChrdm1fcGZuX3QgcGZuKQ0KPiA+ICB7DQo+ID4gIAlzdHJ1Y3QgcGFnZSAqcGFtdF9w
YWdlc1tURFhfRFBBTVRfRU5UUllfUEFHRV9DTlRdOw0KPiA+ICsJYXRvbWljX3QgKnBhbXRfcmVm
Y291bnQ7DQo+ID4gIAl1NjQgdGR4X3N0YXR1czsNCj4gPiAgCWludCByZXQ7DQo+ID4gIA0KPiA+
IEBAIC0yMDU3LDEwICsyMDYxLDI2IEBAIHN0YXRpYyBpbnQgdGR4X3BhbXRfZ2V0KGt2bV9wZm5f
dCBwZm4pDQo+ID4gIAlpZiAocmV0KQ0KPiA+ICAJCXJldHVybiByZXQ7DQo+ID4gIA0KPiA+IC0J
dGR4X3N0YXR1cyA9IHRkaF9waHltZW1fcGFtdF9hZGQocGZuLCBwYW10X3BhZ2VzKTsNCj4gPiAt
CWlmICh0ZHhfc3RhdHVzICE9IFREWF9TVUNDRVNTKSB7DQo+ID4gLQkJcmV0ID0gLUVJTzsNCj4g
PiAtCQlnb3RvIG91dF9mcmVlOw0KPiA+ICsJcGFtdF9yZWZjb3VudCA9IHRkeF9maW5kX3BhbXRf
cmVmY291bnQocGZuKTsNCj4gPiArDQo+ID4gKwlzY29wZWRfZ3VhcmQoc3BpbmxvY2ssICZwYW10
X2xvY2spIHsNCj4gPiArCQkvKg0KPiA+ICsJCSAqIElmIHRoZSBwYW10IHBhZ2UgaXMgYWxyZWFk
eSBhZGRlZCAoaS5lLiByZWZjb3VudCA+PSAxKSwNCj4gPiArCQkgKiB0aGVuIGp1c3QgaW5jcmVt
ZW50IHRoZSByZWZjb3VudC4NCj4gPiArCQkgKi8NCj4gPiArCQlpZiAoYXRvbWljX3JlYWQocGFt
dF9yZWZjb3VudCkpIHsNCj4gPiArCQkJYXRvbWljX2luYyhwYW10X3JlZmNvdW50KTsNCj4gPiAr
CQkJZ290byBvdXRfZnJlZTsNCj4gPiArCQl9DQo+ID4gKw0KPiA+ICsJCS8qIFRyeSB0byBhZGQg
dGhlIHBhbXQgcGFnZSBhbmQgdGFrZSB0aGUgcmVmY291bnQgMC0+MS4gKi8NCj4gPiArCQl0ZHhf
c3RhdHVzID0gdGRoX3BoeW1lbV9wYW10X2FkZChwZm4sIHBhbXRfcGFnZXMpOw0KPiA+ICsJCWlm
IChXQVJOX09OX09OQ0UodGR4X3N0YXR1cyAhPSBURFhfU1VDQ0VTUykpIHsNCj4gPiArCQkJcmV0
ID0gLUVJTzsNCj4gPiArCQkJZ290byBvdXRfZnJlZTsNCj4gPiArCQl9DQo+ID4gKw0KPiA+ICsJ
CWF0b21pY19zZXQocGFtdF9yZWZjb3VudCwgMSk7DQo+ID4gIAl9DQo+ID4gIA0KPiA+ICAJcmV0
dXJuIDA7DQo+ID4gQEAgLTIwNjksMjYgKzIwODksNDYgQEAgc3RhdGljIGludCB0ZHhfcGFtdF9n
ZXQoa3ZtX3Bmbl90IHBmbikNCj4gPiAgCXJldHVybiByZXQ7DQo+ID4gIH0NCj4gPiAgDQo+ID4g
LS8qIEZyZWUgUEFNVCBtZW1vcnkgZm9yIHRoZSBnaXZlbiBwYWdlICovDQo+ID4gKy8qDQo+ID4g
KyAqIERyb3AgUEFNVCByZWZjb3VudCBmb3IgdGhlIGdpdmVuIHBhZ2UgYW5kIGZyZWUgUEFNVCBt
ZW1vcnkgaWYgaXQgaXMgbm8NCj4gPiArICogbG9uZ2VyIG5lZWRlZC4NCj4gSG93IGFib3V0Og0K
PiAiRHJvcCB0aGUgcmVmY291bnQgb2YgdGhlIFBBTVQgcGFnZSBwYWlyIGZvciB0aGUgZ2l2ZW4g
UEZOLCBhbmQgcmVtb3ZlIHRoZQ0KPiBQQU1UIHBhZ2UgcGFpciBpZiBpdCBpcyBubyBsb25nZXIg
bmVlZGVkLiIgPw0KDQpNYXRjaGluZyB0aGUgYWJvdmU6DQoNCkRyb3AgUEFNVCByZWZjb3VudCBm
b3IgdGhlIGdpdmVuIHBmbiBhbmQgZnJlZSBQQU1UIGJhY2tpbmcgaWYgbmVlZGVkDQoNCj4gDQo+
ID4gKyAqLw0KPiA+ICBzdGF0aWMgdm9pZCB0ZHhfcGFtdF9wdXQoa3ZtX3Bmbl90IHBmbikNCj4g
PiAgew0KPiA+ICAJc3RydWN0IHBhZ2UgKnBhbXRfcGFnZXNbVERYX0RQQU1UX0VOVFJZX1BBR0Vf
Q05UXSA9IHt9Ow0KPiA+ICsJYXRvbWljX3QgKnBhbXRfcmVmY291bnQ7DQo+ID4gIAl1NjQgdGR4
X3N0YXR1czsNCj4gPiAgDQo+ID4gIAlpZiAoIXRkeF9zdXBwb3J0c19keW5hbWljX3BhbXQoJnRk
eF9zeXNpbmZvKSkNCj4gPiAgCQlyZXR1cm47DQo+ID4gIA0KPiA+IC0JdGR4X3N0YXR1cyA9IHRk
aF9waHltZW1fcGFtdF9yZW1vdmUocGZuLCBwYW10X3BhZ2VzKTsNCj4gPiArCXBhbXRfcmVmY291
bnQgPSB0ZHhfZmluZF9wYW10X3JlZmNvdW50KHBmbik7DQo+ID4gIA0KPiA+IC0JLyoNCj4gPiAt
CSAqIERvbid0IGZyZWUgcGFtdF9wYWdlcyBhcyBpdCBjb3VsZCBob2xkIGdhcmJhZ2Ugd2hlbg0K
PiA+IC0JICogdGRoX3BoeW1lbV9wYW10X3JlbW92ZSgpIGZhaWxzLiAgRG9uJ3QgcGFuaWMvQlVH
X09OKCksIGFzDQo+ID4gLQkgKiB0aGVyZSBpcyBubyByaXNrIG9mIGRhdGEgY29ycnVwdGlvbiwg
YnV0IGRvIHllbGwgbG91ZGx5IGFzDQo+ID4gLQkgKiBmYWlsdXJlIGluZGljYXRlcyBhIGtlcm5l
bCBidWcsIG1lbW9yeSBpcyBiZWluZyBsZWFrZWQsIGFuZA0KPiA+IC0JICogdGhlIGRhbmdsaW5n
IFBBTVQgZW50cnkgbWF5IGNhdXNlIGZ1dHVyZSBvcGVyYXRpb25zIHRvIGZhaWwuDQo+ID4gLQkg
Ki8NCj4gPiAtCWlmIChXQVJOX09OX09OQ0UodGR4X3N0YXR1cyAhPSBURFhfU1VDQ0VTUykpDQo+
ID4gLQkJcmV0dXJuOw0KPiA+ICsJc2NvcGVkX2d1YXJkKHNwaW5sb2NrLCAmcGFtdF9sb2NrKSB7
DQo+ID4gKwkJLyoNCj4gPiArCQkgKiBJZiB0aGUgdGhlcmUgYXJlIG1vcmUgdGhhbiAxIHJlZmVy
ZW5jZXMgb24gdGhlIHBhbXQgcGFnZSwNCj4gcy9JZiB0aGUvSWYNCj4gcy9yZWZlcmVuY2VzL3Jl
ZmVyZW5jZQ0KDQpZZXAsIHRoYW5rcy4NCg0KPiANCj4gPiArCQkgKiBkb24ndCByZW1vdmUgaXQg
eWV0LiBKdXN0IGRlY3JlbWVudCB0aGUgcmVmY291bnQuDQo+ID4gKwkJICovDQo+ID4gKwkJaWYg
KGF0b21pY19yZWFkKHBhbXRfcmVmY291bnQpID4gMSkgew0KPiA+ICsJCQlhdG9taWNfZGVjKHBh
bXRfcmVmY291bnQpOw0KPiA+ICsJCQlyZXR1cm47DQo+ID4gKwkJfQ0KPiA+ICsNCj4gPiArCQkv
KiBUcnkgdG8gcmVtb3ZlIHRoZSBwYW10IHBhZ2UgYW5kIHRha2UgdGhlIHJlZmNvdW50IDEtPjAu
ICovDQo+ID4gKwkJdGR4X3N0YXR1cyA9IHRkaF9waHltZW1fcGFtdF9yZW1vdmUocGZuLCBwYW10
X3BhZ2VzKTsNCj4gPiArDQo+ID4gKwkJLyoNCj4gPiArCQkgKiBEb24ndCBmcmVlIHBhbXRfcGFn
ZXMgYXMgaXQgY291bGQgaG9sZCBnYXJiYWdlIHdoZW4NCj4gPiArCQkgKiB0ZGhfcGh5bWVtX3Bh
bXRfcmVtb3ZlKCkgZmFpbHMuICBEb24ndCBwYW5pYy9CVUdfT04oKSwgYXMNCj4gPiArCQkgKiB0
aGVyZSBpcyBubyByaXNrIG9mIGRhdGEgY29ycnVwdGlvbiwgYnV0IGRvIHllbGwgbG91ZGx5IGFz
DQo+ID4gKwkJICogZmFpbHVyZSBpbmRpY2F0ZXMgYSBrZXJuZWwgYnVnLCBtZW1vcnkgaXMgYmVp
bmcgbGVha2VkLCBhbmQNCj4gPiArCQkgKiB0aGUgZGFuZ2xpbmcgUEFNVCBlbnRyeSBtYXkgY2F1
c2UgZnV0dXJlIG9wZXJhdGlvbnMgdG8gZmFpbC4NCj4gPiArCQkgKi8NCj4gPiArCQlpZiAoV0FS
Tl9PTl9PTkNFKHRkeF9zdGF0dXMgIT0gVERYX1NVQ0NFU1MpKQ0KPiA+ICsJCQlyZXR1cm47DQo+
ID4gKw0KPiA+ICsJCWF0b21pY19zZXQocGFtdF9yZWZjb3VudCwgMCk7DQo+ID4gKwl9DQo+ID4g
IA0KPiA+ICAJZnJlZV9wYW10X2FycmF5KHBhbXRfcGFnZXMpOw0KPiA+ICB9DQo+IA0KPiBBbm90
aGVyIG5pdDoNCj4gSG93IGFib3V0IHJlbmFtaW5nIHRoZSB0aXRsZSBmcm9tDQo+ICJIYW5kbGUg
Y29uY3VycmVudCBjYWxsZXJzIGluIHRkeF9wYW10X2dldC9wdXQoKSIgdG8NCj4gIkhhbmRsZSBj
b25jdXJyZW50IGNhbGxzIHRvIHRkeF9wYW10X2dldC9wdXQoKSIgPw0KDQpJJ20gbm90IHNlZWlu
ZyBhIGJlbmVmaXQuIEp1c3QgYmVjYXVzZSBpdCdzIHNob3J0ZXI/DQoNCj4gDQo+IA0KPiBSZXZp
ZXdlZC1ieTogWWFuIFpoYW8gPHlhbi55LnpoYW9AaW50ZWwuY29tPg0KDQo=
