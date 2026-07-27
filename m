Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5284539CD0A;
	Mon, 27 Jul 2026 18:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785177468; cv=fail; b=TofuCciFUSBU1a9GniQ7bUumkWHLKrgDr96POjs5M3LJDF/1VnkEpDbx5o3qOYbfG/fJ4n8p8AOq/Hcxc8Pbf11d7wwIwWcEZFZo37uLOAe1e8RVuivwa0lxehAvdBXvFUSAD7xyhgHymtl++AZhnYWGlZZzHt7OGevgYOim1Fs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785177468; c=relaxed/simple;
	bh=TkDuWzqoGjuM3eo4aiVpLYqSxJjvbhzbOqdyIl+dXKM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ET1fPllwMsRWsb/A89zpdDokhJgTaSKKkw3gn3/5B2jerID7zfLRUKJqDul2OoI+FX73hSvZil38M1MWoofJvf5DUF552rW5QiqisMAgqnbm3QOsmraKqXudlD62QAXoxVlFfzUbpG2W42BO0KSnG0SMZZnUf9OEnR2DWrMHoAA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gVZq5YQ4; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gVZq5YQ4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785177467; x=1816713467;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=TkDuWzqoGjuM3eo4aiVpLYqSxJjvbhzbOqdyIl+dXKM=;
  b=gVZq5YQ47vtmfoqNEhQxMx0Q9GbjqlukiziNOgQQo4S5/W265SkEqcu8
   rKAgNBlrWKbxYlT+N0x+K3VRH3QRdhznyZHorRysogzT+0IXCEkKdz0nX
   0BY0ZLqmUzddIMQBcTX4FGOfoZTZ04m53s2MhS/40VgVAz5W+SzOtb4+9
   xuUWCPTFDnnHz312rreK33KT+uOTD2eKTXOBYidt3VbJU/b+ydgywTbkQ
   Lh1H/PawXYP11mAPRQtxwdX0ivwkLNsWAnboMWDDnKIKyRcT4WVPB6pcb
   2H/XLeK9EwU3OS+5k5PDkonJSUh2DRSgzrm/5KxILzc9sxx+FVqwA2Dl4
   g==;
X-CSE-ConnectionGUID: DLR8FgtqTTu870rVhOTZVQ==
X-CSE-MsgGUID: 4XmBjcInQxuxLuHtydyx+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11858"; a="111297957"
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; 
   d="scan'208";a="111297957"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 11:37:43 -0700
X-CSE-ConnectionGUID: BdMpIV6DSAaF7rUd01gdyQ==
X-CSE-MsgGUID: AkhqpVhqRAu0wsRhWpTSDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; 
   d="scan'208";a="256812997"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 11:37:43 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 27 Jul 2026 11:37:42 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 27 Jul 2026 11:37:42 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.39) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 27 Jul 2026 11:37:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u2FWKOO9xOBicFW3FmtHjov8iNlE1uWETHzmvnon+DFGu5P1yKOkjVRpjuDFs6W2VOlppRL9Np25KQwnPmQJcywJf5bKgQdsKvRL0vUkz+lep0LmJ2IGS49gFEMgWg5Z8/WKpv5xaC8vOkjWhHEFM3IZdK/U8KPqMb9bfTOPyUTgO3FXa1M7+c9YQBYJWnD+NR7rDA0h1wdoh99m+QJvbIp4milljC8uxhhgN/RbrTIlOmH2XOdmlsolu0g/gMMkqqFSsACxylv9X7ArmYzeRbANlZkC+7fkJ53K7X2zAVXOzjrzsZ+iyYjAW491bYvyThB7RbVkhXeewPbfBOxlWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TkDuWzqoGjuM3eo4aiVpLYqSxJjvbhzbOqdyIl+dXKM=;
 b=ep5UlqWDajuBCbRP3YVKjGkgcVNfXu3RPUGd5b2XDl/DhMi5t+nmfYGeeNuX5QLY/WmrDvl6LHR/6RX7CVWsSwmLM1bfNNAP2fy9FFBDvLffcKvMKG0YFKbNXKn4/D8Our5ym4mZtdpg8Uqk8uiwOTz8WKIx6YzJCONGGCC43YXeWsYZK2Rv7sPXv5B93O9hG+lmjI1V5TKoTnKyaJxQZDA1BfQJ1xWDtxxH8lJ9guRZgjVIlMg9GFOHaLZV6yMfLl7kszNXLMNp+UnsJK41ywqTATAzch7daqnlu2FIwU+C75JGs/Eec9iJx1rLVH/2YYprulDSwMaAozMLeK+Lyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by BN9PR11MB5260.namprd11.prod.outlook.com (2603:10b6:408:135::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 18:37:39 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 18:37:39 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Gao, Chao" <chao.gao@intel.com>, "yilun.xu@linux.intel.com"
	<yilun.xu@linux.intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Li, Xiaoyao" <xiaoyao.li@intel.com>, "Hansen,
 Dave" <dave.hansen@intel.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "Hunter, Adrian" <adrian.hunter@intel.com>,
	"kas@kernel.org" <kas@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Xu, Yilun" <yilun.xu@intel.com>,
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>,
	"seanjc@google.com" <seanjc@google.com>, "Mehta, Sohil"
	<sohil.mehta@intel.com>, "djbw@kernel.org" <djbw@kernel.org>, "Duan,
 Zhenzhong" <zhenzhong.duan@intel.com>, "Fang, Peter" <peter.fang@intel.com>,
	"Maloor, Kishen" <kishen.maloor@intel.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v2 06/17] x86/virt/tdx: Re-initialize the extensions on
 runtime TDX module update
Thread-Topic: [PATCH v2 06/17] x86/virt/tdx: Re-initialize the extensions on
 runtime TDX module update
Thread-Index: AQHc/v3/H6yI1AvBKUSJMqGdHr9fi7ZVQB8AgCywzgA=
Date: Mon, 27 Jul 2026 18:37:39 +0000
Message-ID: <603e7857a2036b0fef86dcf8ad0ab97e0232188c.camel@intel.com>
References: <20260618081355.3253581-1-yilun.xu@linux.intel.com>
	 <20260618081355.3253581-7-yilun.xu@linux.intel.com>
	 <akIo+E5hfQL7C30E@intel.com>
In-Reply-To: <akIo+E5hfQL7C30E@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|BN9PR11MB5260:EE_
x-ms-office365-filtering-correlation-id: bb2f4f16-147e-492f-01f6-08deec0e2301
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|56012099006|11063799006|10067099003|4143699003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: BsDSc9uaxMiMyZoFWi4pvy24pJsUUfAlTdOLA5m5NKOKJiNfNEQl8AKm1QcZtVAxDzUqHaAy4eExouhyJ50Zf5MrVXreVlDDil6JCpLkfTVqU6JL5dmxnRi2ACoxpvjPiWaFz0PadC7Cpv28w3MyerK4ylyHQMQzgfyZ0+QsMelsgtd+qaC1MoPcLqLtS4KKfgt2Yjp40Q+uZHMFF9bPsSiocXCt39xezHPxuxdf6o4fwsQQFzVYB5whTtwpjPymnSYtnZKpLxvWjheJnSTYHXq6NsSIyY5q5gyjtOkervn3te+D9Dgfr4xWeA6sCuc2n20yWyOJLzq2TfltIK/bSARLYuj93ShnCftlt0N1+XFiRRY8PGmc4nEp49PXfyMxL0hzSBkfIk8dMKPO9t2dNy6Cn9kfu5W8ox5XO1EdNcSoOAcYWKfSNOqL7NPn9tSw4Chm1sHBwhh17oHKRIMoZkB6LanaLRRZHZOMv7CI2hg38AUgLg9sCxGzoGDQfdBrKSZwUS0UtN7TnWIaNnO2i9akZcN4TVCx5R5M0+Xq9bN+liPlC0+4o8ah95KiRsymrlVxoKqBbyR8Bhbh6QCucxBMWBa65nQLcyZtmSdwViRYewWn0ow9E9is4Z8+N9MaMbcvPVpm4W/BkJOpHayzWjU28mD2t42ztBQyg+M7N8jDiz6cS/hr1RtPrEcUjTv2noFEuqMQuQw3WFJlXoBr5z1TDaCwaWWklBO+tYcZufk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(56012099006)(11063799006)(10067099003)(4143699003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b2hJc0JFRnE1NWZmVkdOR1VodFRFbjVNbjZORXdIeUx5WlZzaGFhN2FJL3o2?=
 =?utf-8?B?aHhHUGk4NjZvWFFJaXFITXNLaUtjZEl4RG92aWJNVm9WSlBRWGVjdU50ZXp5?=
 =?utf-8?B?TUxYaTlqS0hNdnQ1ak1oWVgyQldtdUdnVkhtYXA1d3ByS0VvYmlCanJwNnd2?=
 =?utf-8?B?N3I5bjZ6S1o5b0RIM1pWZFh1ZWtJTEFrRlFoWVF4ZzhScWFpL0xycm5rcEtY?=
 =?utf-8?B?VW1NajBGalNwSXZiUFNDZ0NFTE5JS3FMc21vYWRGRlphZDZZTWZBREFMd1Z1?=
 =?utf-8?B?QndWc2R5WXhYNVc3bFZ5eS9sTGdIUDViRC9JRVVIM241NUd3STZYVGR3aSs5?=
 =?utf-8?B?K2h2cDVWeW9DZjMxUkVXRDJjWnBEUExYalc0VEpTcGZvWldVWWFmeDBxNkNF?=
 =?utf-8?B?NTNWTTJCWmZrVDYvMTRUWnNiZDhveEJMbElsVGF5SFBEQjNhSi85VHZUYm8x?=
 =?utf-8?B?M0V3SmF6Rlh1MEhWZDBmL1pBdk03Y0FhUWdTUnBJRXVLbXFmdWFSZzR2VzFV?=
 =?utf-8?B?TFkvN2sycEYwanVxNEI1c1JyeFd1MjdaOVVFVTQ5QU1jSFlUSk5yR29PY0dq?=
 =?utf-8?B?TTAxN2Z4eHp0elF2SG5vdnc2ZUROSlVZRHV5SXVPdWRWb3RPZVpGT2gyUlJG?=
 =?utf-8?B?OG9mWDJXN0craGc2Vm1KZVloVHp6VVFMUUI5MnVDMElmbHhyM2hDSGRhRHZZ?=
 =?utf-8?B?WlRYeG9MYVhqMW9DTmdRcjZoN0VGUjB3SjhXNDVyeXJCNVIxSmYxUHpVRnBm?=
 =?utf-8?B?YlRpUk5teCtYY0tlUUdvMmJmNldiWWp3bGgvRVlHVllZRURuMXIwVUQrem8z?=
 =?utf-8?B?WGtqU1RKTTlwTzRNVzF0d3diZVZ2WUk2WXhzeUJNYzcxWlJhOTN0cXkwcXdi?=
 =?utf-8?B?eUwwSUh4a1ZlM0xwME5vbi9WamZUK2xRTVFFd29Hck9NOG1kT2ZxZHR5WXJC?=
 =?utf-8?B?Y1V0T1RDa0doTncxV1dnMG5wdnNnb1FyUGZTUUNwUFJUYUxkV3NRK3FwcVJr?=
 =?utf-8?B?SHQvWC9RS3l0eENyT0ZDSmJvN0t1cGdva0xtbHo2QzV5eHpSS2tlT1M3SlQ2?=
 =?utf-8?B?V0kzL2NnMjJ4YklqNkdobjJvMmM1TEMwcCtMRU5aYlpaWStLRDFQVDBKZTVT?=
 =?utf-8?B?YkNqSHM2Nm9FMXhyWVk4MXoweUNDR01CaEhFaDhYUktteXAyT2k5MC82dVZY?=
 =?utf-8?B?T3E3Nm02d2NrMW9ZblNKeithL0pOTytjWnBEcm5wczdGUGJKUlU2ZkN6Zy9H?=
 =?utf-8?B?Sk1GcE5mTE5YZ1JucUFBUkEvVDU1VDEzaUFQWkpneW0zdlZ0S3c2bWJTRDM0?=
 =?utf-8?B?VmhMS3NnblFkM0hUcGRpUmczRzl4TE5BejVlTjBVaDZRMmtIamZILzhlMHNZ?=
 =?utf-8?B?RDNMV21MTGR6MVZicHN4eVRiMGpKd05pT0NRTlpLVmp6WE9Nc0trVjZyRVd5?=
 =?utf-8?B?TlV6UXFVbUJpbUtNU1NPNFJ2a0o4R3RwaFFncTJiMzVESFBZT29NZ3VwZWo4?=
 =?utf-8?B?VnB5S0hQVm9Tc1dabnM2aE02OVFCYm5oOG9QZ2t5dlFkOHV2M2ZzNXVmTmVO?=
 =?utf-8?B?WlJpQWlZcDZ3VzlmNk1QQW5iZ3hPVjVzTEVMMWVLaFFJekltNUVuN3ZweUgw?=
 =?utf-8?B?TEIyLzdtNVlSMzFuZ0NLM1ZLMWhIQU8yNWlFc3FYTERWZWhyS3NLclAvZ0E0?=
 =?utf-8?B?SFlUbFk0RTJXNXlJOFNvUEpucjhrNE84NXA5VjNxTG96WTZJZFY1elZqeVRo?=
 =?utf-8?B?UmpjN1hDazdqY0Q3U1VhOHRGcExWLzdxemhqTE5BR2h0a1lRS3crV3pjOFYz?=
 =?utf-8?B?TGhsTExueHlnbFV4ZWtrMlRRZEZpV3R6TW5jSUo5SzZ0TUJlOFVjdUVudjdz?=
 =?utf-8?B?cTZlT29ENzN1bkNuL00rbEFBSGwvWnRLcU5KczVqZE1URVROL21RMXFJS0gx?=
 =?utf-8?B?emx5RVBsMUtiaXBpWkRBQklvNVVrNjEzY0JjQ3NKWGNUUDlvbmFJM2JsOER2?=
 =?utf-8?B?b3hVT1FWUmFhTDZERUJjQzJORnVsKy9UVmlGemhnc0wxVUQ1TklNQWxmM2lE?=
 =?utf-8?B?Z3NNT2tmUUN1SHdXcGJjOEZBVVFNR2lwUjAwU0E3SGFhWW90TkM5U1dTeFNy?=
 =?utf-8?B?VnY1VjdHazdQQ2JFelFvUlEzZFpwSThPVjN3eGxKbHpXa25wQmVHaStveHFW?=
 =?utf-8?B?Rzl1Rjl0RFFUOGdTSU9yb0tZOEdBVTNFelJwLzErUDRiSDh5QjBsY2FoRWlM?=
 =?utf-8?B?ZjdwTmUxL1FZYXFmWlptNUZZa25TWTFKQTltcjRVejBJa1RNcHpMV1QwdEV5?=
 =?utf-8?B?eERGZzB0ZUtTcFhOTzB3M0dOWDcwSFpuQnpRZEp5QmhTSmFuN0dDaFdmKytQ?=
 =?utf-8?Q?DkEPXkS3xVivXGxs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0973E8EFC25E9F4AAEBB980E0C83FE98@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: JFNVak3fGwDbDKGEvGt/gONvN1HWgOmve1f6u328aDXfeGGiDdsO7BUbesrqtZ4HF+3VdBuO/jZzrReyZsWBbfEO8UbfvbYa1L7N9ZwUqcOJJF6520X3x91O5AE3wyZ5BvANuQRwSW2Ib8FcuxvQut7IplwFHvLJw54okvskfhF6+BNhGknHdAgavdDAepgoPb/vpcDq45hAHzi3HpkqKTnViah3Zd0HGBn6TlQm/MkL2Lf39K31WuYjvdp4MFn16BW8vEowPiGrnOMEV3tpa0hAOyfHM49b1EOuzDuccy7j7YSMgnKMWguw3i3YiJcWccku45lzAljZsJbyD4Hu5A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb2f4f16-147e-492f-01f6-08deec0e2301
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2026 18:37:39.3615
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 85/xYvtv6gx3fM3ekMbq9Eb++bRYA5yKEKCDDVS8DhZ/W/AOTQFZ0N9C1KMR38shq5ER9ZeY4f4XZP5tLXMNSEuil9Q9M1QRUFOMU8q7wXE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5260
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI2LTA2LTI5IGF0IDE2OjEyICswODAwLCBDaGFvIEdhbyB3cm90ZToNCj4gV2ls
bCB0ZHhfZXh0X2luaXQoKSByZXR1cm4gYW4gZXJyb3IgaWYgbW9yZSBtZW1vcnkgaXMgbmVlZGVk
Pw0KPiANCj4gSWYgeWVzLCB3ZSBjYW4gbGVhdmUgdGhpcyBjaGVjayB0byB0aGUgbW9kdWxlLiBB
bmQgd2l0aCBleHRfcmVxdWlyZWQNCj4gcmVtb3ZlZCAocGVyIG15IGVhcmxpZXIgY29tbWVudCks
IHRoaXMgZnVuY3Rpb24gc2ltcGxpZmllcyB0bzoNCj4gDQo+IGludCB1cGRhdGVfdGR4X21vZHVs
ZV9leHRlbnNpb25zKHZvaWQpDQo+IHsNCj4gCWlmICghKHRkeF9zeXNpbmZvLmZlYXR1cmVzLnRk
eF9mZWF0dXJlczAgJiBURFhfRkVBVFVSRVMwX0VYVCkpDQo+IAkJcmV0dXJuIDA7DQo+IA0KPiAJ
cmV0dXJuIHRkeF9leHRfaW5pdCgpOw0KPiB9DQoNCk9oLCBpdCBjYW4gYmUgc2ltcGxpZmllZCBh
bmQgbm90IHNoYXJlIHNvIG11Y2ggd2l0aCB0aGUgaW5pdCBzaWRlLiBQbGVhc2UgaWdub3JlDQpt
eSBvdGhlciBxdWVzdGlvbi4NCg==
