Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792653949;
	b=r3+o4VQ2Ux2PvxFLM+mlbYNw0x+PRYMpam6cgLcsCZO0jxN+FyXfom9ZsZXGJM3I5Dvh
	 rvYz7R4Wer+4Dogw7g6za0RXOPX2MMBI9g6b6xMfYbMtowwVrIn66ChOv2D4ooRSbTHJG
	 pq2xO+MNl9WNsY4ewsU8W/70hCHZu52S+0HMhAFFsokChvQqarhZ5QdcNZZjkZfny0N2O
	 cLaZJoAiHV7xIxixa2mLIiomE4dpgI1Qs+djF9KPv4q/6J/WNEKe0J5FcCHaJe03CuLN2
	 wiieLPUvqgH4Shqw590vUWMe3+9rwQzzNL0XfkUsDKm9/FbO696Sh8dbAsrrthE8JZg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792653949;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Date:From:To:CC:Subject:Message-ID:
	 Reply-To:References:Content-Type:Content-Disposition:In-Reply-To:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-LD-Processed:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=8BlXb50a2jjKH3zeuJhvT5UaNLUlQOZ1c9Bro10J6ng=;
	b=fOGjI7I8sVgfDiKEXZM8efjpBMuzycfazaGkdoBV6pyfR3IWYFZFeP6t9tJRuYlihbAa
	 RzVdQQA71dI7PRHRD754cXfO9nvvPV5RYWa2/MrmhDssyCfqU6XSA+/afpjtrATa1llPZ
	 JBFMGHSaq0a/AhWXky97ZSNJk1y9u101bdBceDOmVJjDEN2lRfbrtI8gcs12ATtS7jLHI
	 ouu/0fyiTwAbc8y5wQfKuXuc7mVIcDmDWo5cSViJXRTZh4gSen2gwWlL2BY5QaMeThSC3
	 B0aLD9SGxPFlF8JXoINJpHjfMGNyE7lYognC6NlE+hQ9EBysMQrnv4l3LwVgTmTTUBw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ABtlQcVl;
	arc=fail smtp.remote-ip=192.198.163.18
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA4A606A31B;
	Thu, 22 Oct 2026 07:25:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BFA4A606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ABtlQcVl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792653948; x=1824189948;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=HpcQYDV+BJZB+NPQT9lBO/5ljDv4zkIlQLBLOb5BScw=;
  b=ABtlQcVlJcsa0rqgO/Pmj5jBRMtMgfglwa6ZBXg3ykv97sEzdq3T0q0X
   kMz4Ganl+i1Y5LoFaG29KkrY55ILYRZqbJaGFGi1L208OGwMMylvq+N8j
   o2iN5IiMHFDXSbWHuO96FnfgihlYq7TR5QhqIuY6OIZcFVG68PTjU1PNj
   Zp1zO2tyYFcJHWWMOyBBmZH775oK8v2D3XMFJffUeD9DUs1YKwC2YCWAY
   nG/DxUdZeyFBt0Qva6g0bIzH+gg/vqNkgUwI+MlP+iGAmx7kEbAc02H9t
   +cVgrQrPGAOoDIAVCCpHaTzQRyDb4rpYwd8F9i6k4TZRQ7GHVH064pjIh
   w==;
X-CSE-ConnectionGUID: jMsSpGgGTj2MeNSutlr+Cw==
X-CSE-MsgGUID: tYFvVD0+Syme6v8rSTxCyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1430797"
X-IronPort-AV: E=Sophos;i="6.27,171,1787036400"; 
   d="scan'208";a="1430797"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 00:25:47 -0700
X-CSE-ConnectionGUID: nd5C6i+5Ti65YQH77onuhw==
X-CSE-MsgGUID: 2JqaFpDIQ+ixpWm4UOG/1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,171,1787036400"; 
   d="scan'208";a="3365722"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 00:25:46 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 22 Oct 2026 00:25:46 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 22 Oct 2026 00:25:46 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.44) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 22 Oct 2026 00:25:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MYebEcVklDcqRBp6hvHn4qFcsuLv8R+mrmK5blZTWGJgTRB27g7jmEx+S9qMJH0vpxRg6fHt4zwvgfhJ8h0zFE+cKem0QQ8FUWYOqs5DQQJWJWpMnq71pJkFied+FyjHtYzLCisVm865g8llKPyJZojl62/v1LBMRz+24UYf+8zYYodkdSUBZyHu8TiY42UeSWaXEKMuSHZgmB8fO7lNj0pBlQ8R9c7DZVjqxMvEAt/FHOT1SdHwWGxhms85SChwaIw6OGu4jUUWRWlczqfOR8CEgn+y1GvW1+bgQyis+u5xDu3dyM4x9/GvMWkAb/4P4Ym6jzODomJZf/Dx/M0D3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8BlXb50a2jjKH3zeuJhvT5UaNLUlQOZ1c9Bro10J6ng=;
 b=BQJQmYpIvr65Mip3lkWBWCY3y7f8V40HJ/DCsFYmEvNnGLagyEShUrG6pfpE6aVUS1O09+Gkb7x5yRyhT/u3GjdbucWiFNse0m3y6iRjRMMmRY1Qyk0//H52dd/HRA0yzJyYH1X36Pp9Im/YaeWKIGSNZbpakV2GoUnultNufliVkSyANfj+YHa3kdJlMRlIZNS/mrAx36FTRil2UEzKP2DFak6L8qCETyWIjoduXT3UIYC1OSOEHZgVPp/q473GjX6se7ISzDQv3N6GKG3LDc83pqB0+wcEgVkhKCpuFjWsGtQHJIfo7S9QpGT3VLT3Z3P3+JRQU4wqHhkvb+AV0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB3236.namprd11.prod.outlook.com (2603:10b6:208:60::18)
 by CC6PR11MB162545.namprd11.prod.outlook.com (2603:10b6:170:20a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.16; Thu, 22 Oct
 2026 07:25:33 +0000
Received: from BL0PR11MB3236.namprd11.prod.outlook.com
 ([fe80::b026:a3ba:5162:beb2]) by BL0PR11MB3236.namprd11.prod.outlook.com
 ([fe80::b026:a3ba:5162:beb2%5]) with mapi id 15.21.0546.012; Thu, 22 Oct 2026
 07:25:33 +0000
Date: Thu, 22 Oct 2026 15:24:36 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC: "Du, Fan" <fan.du@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"kai.huang@intel.com" <kai.huang@intel.com>, "Li, Xiaoyao"
	<xiaoyao.li@intel.com>, "Hansen, Dave" <dave.hansen@intel.com>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, "tabba@google.com"
	<tabba@google.com>, "vbabka@suse.cz" <vbabka@suse.cz>, "david@kernel.org"
	<david@kernel.org>, "michael.roth@amd.com" <michael.roth@amd.com>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, "seanjc@google.com"
	<seanjc@google.com>, "kas@kernel.org" <kas@kernel.org>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "ackerleytng@google.com" <ackerleytng@google.com>,
	"Peng, Chao P" <chao.p.peng@intel.com>, "nik.borisov@suse.com"
	<nik.borisov@suse.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "sagis@google.com" <sagis@google.com>,
	"Annapurve, Vishal" <vannapurve@google.com>, "Chen, Farrah"
	<farrah.chen@intel.com>, "Gao, Chao" <chao.gao@intel.com>,
	"francescolavra.fl@gmail.com" <francescolavra.fl@gmail.com>, "Miao, Jun"
	<jun.miao@intel.com>, "jgross@suse.com" <jgross@suse.com>,
	"pgonda@google.com" <pgonda@google.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v4 08/17] KVM: TDX: Adjust the topup count of DPAMT page
 pairs for splitting S-EPT
Message-ID: <atm6NBNrwYc+Y8yo@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <asivFAotV10NIZQL@yzhao56-desk.sh.intel.com>
 <594befb577b9142dc0c90b7be5bb65888a3a2523.camel@intel.com>
 <asnJcZsKdDzgaYzc@yzhao56-desk.sh.intel.com>
 <ae995b5ec798491c3a5511fc44b6308e9664a53b.camel@intel.com>
 <as8UwKoAaT/1HgNr@yzhao56-desk.sh.intel.com>
 <71682b712350b5270e4a0f5cddceb1da12341b9d.camel@intel.com>
 <atBaxwAG84jlOywE@yzhao56-desk.sh.intel.com>
 <25927de50b85816956e8989f402ff6ccfa8fa0ba.camel@intel.com>
 <atV5fDnckj+3V0D/@yzhao56-desk.sh.intel.com>
 <ca53c3bd37218828822a9b990a0900ca2541fd9e.camel@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ca53c3bd37218828822a9b990a0900ca2541fd9e.camel@intel.com>
X-ClientProxiedBy: SG2PR02CA0128.apcprd02.prod.outlook.com
 (2603:1096:4:188::20) To BL0PR11MB3236.namprd11.prod.outlook.com
 (2603:10b6:208:60::18)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB3236:EE_|CC6PR11MB162545:EE_
X-MS-Office365-Filtering-Correlation-Id: cbafbb8d-4286-4d0c-2146-08df300da88b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|4143699003|11063799006|56012099006|261021121427099003|261009223027099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: ZeGkrfT+Me+RPdMvK54bGYl6G6BkxOZxxgM1MOhu5cSk6eZ4rwCevROWAnWChycQaNPaPJ2XqdAk4a69Fxp8/sCYtOgDfsL4i1sl4b6K0j/SCo4GElFwodtKfzCO9YMLb1nYk9JGe5pCZEG7SkUDLklSW1dLnTcRExxfdG4QNUJZC2uVE53vTPu4HYC1SvG10X6HqDsSMdZnpt3vgn5S9WpgNzxn5jtPSsCEe/ADT83yQb2JcC8muatReb2iT5uVEtBLqxetGHPcQYdd10JwGBRuvkmgx3WWp91ZDcINIy7eQVxAWikTkxv9TWmikBWA76ktO8w0KzbG/8GpRS4jSgUJX8YG1QzgJ/4y083RrZXYlruHH2kdFpBq80xCxxEHVhEAhmJTbxLtnx2gdIChLdRphBub0jBP8Yk2Pto1ndQrxai934+fwDpOHYQLoBVgMlu8kuj/rnJUHp4MKuZrxP7NRTPc13lDVK+1y9f+WZ3NkWKsdTccQUovvYWRPTkgn1/pjqiv0DFHQHaV0iowB1Sb8UeHmKM2JRSEK6i2Iuskmy1uNghzHsnqKUQJH89hYqrRco3vrSrR8JrPTx+pQm65+TqNshtgQ7VZD8YCqRZof8eQlhYxffp67597QrGE6fjvbMSCEgvsiIMN2gHZReOhjo8hj2JgJBgm9cKjjnw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3236.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(4143699003)(11063799006)(56012099006)(261021121427099003)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r49NZB+oj08W5OO2M/tXHgQLzDopKhX9UNW4J9e6mmRjg84QDLkI+ciKapDu?=
 =?us-ascii?Q?TWNpkG2bab7xMl3BnVHwyZ6iPcf7tjgpOX2xLQd7DjPvBHrsUV8uCIR15KGE?=
 =?us-ascii?Q?BzpUVTRrS1KwOp+74b7iXOXh+g8DK+EjG+5xO+pzxicsE5sJa5Un4y5mHQcd?=
 =?us-ascii?Q?HI1mSlshCxoUW9b7VS2yMjJj/WSCSwHlpzwShsabaaVCCDHghX2SWDbFn76/?=
 =?us-ascii?Q?9njS9bUUHykbZVzK1/udRurjFlcm6M/n/8VO3aUvTdI+24xXBCKZGJvm5PrM?=
 =?us-ascii?Q?Hw5r4gxPdLCN9Mv96aMEtAWtd0ryKqPGriq43ApyHdVqyNpwMkumKb+Q1dw8?=
 =?us-ascii?Q?udkiPEgCb/X2PClYE0aaHebYmEZjvIAPfk9ogdacE9C0sjCY+VGN1jSK3qFK?=
 =?us-ascii?Q?5ikZk1FV+RhvvhrEnYX4Blea7yAeqHATaEjAW8m20Nl4vtlOm+c4H/NG2aqy?=
 =?us-ascii?Q?YvjbiIhs8Z58O9cLnYz9c5tdPQgfZm5BaCeKH3Rr99DXf4Pybl/hLPyI2eGv?=
 =?us-ascii?Q?mETuyftLlhwg9Az5pRF8bo4dSU4dAZYKmLl4fvIOdU8+IiS2AJfJWRGO8h4c?=
 =?us-ascii?Q?p4A6Arqpt+jgP7vI5pIY8zu/QZ5PxBdCoRYD1XRzQSIRORrZ1YXSY/h4L2BD?=
 =?us-ascii?Q?cujF7FVCu26M8GIR8xVqk6G058xU6aspMJoEp8gQERqYmxvimj568we/xti5?=
 =?us-ascii?Q?Uc3ScgJjOkIcxztWd4a8ATtJhsWJlf9tz0udAkpoDSPqY4/xkplj5rphv7gS?=
 =?us-ascii?Q?c/d7kvATMLYuocfIcvIC50iGs+bxyFcLuynRfuIi0ZBl+mOm1nmRoRPSCJx3?=
 =?us-ascii?Q?TtzGR/XzSqVgRTGMKeo//la8ks+74Jn4Xz6UVC/S/G7nEDVZ8TorQEAqY8nI?=
 =?us-ascii?Q?JfvaP9WBdi6QlH4Fcnc7jsF0wZK6FXq3eOUnknQmY2DZIDHUNYwT67+JKC4e?=
 =?us-ascii?Q?h/DqhK4FPTPe/tMhVHCQviW0wpVDy1nEbpG9N/FKdYxDVOmZkUt+9/TF5bzv?=
 =?us-ascii?Q?3qrBbwrR5UFkojnFw3m3QcoXBjCPGlYs4sn9FxIO9Qt26ANT81e7aolln9wl?=
 =?us-ascii?Q?qDnbEzG5vkClYov4g3cBJ60Z6WuclAmZkq7SdHu5ryYzpnQc1259g/wrIuVf?=
 =?us-ascii?Q?nqY7UW4nHZRgmZQTq8LVPTzRoCLsD15dQxS5VJzbNPSkb+SFrnAlAnldSk7x?=
 =?us-ascii?Q?OI/0yTlkZzfBZG5cGKd2w9ITLVFZ2hGTUyw690z+UPggLpHluAmuSMzqer09?=
 =?us-ascii?Q?l/OjdOBC1PptYeFori9aHpRFZF4RkSt+c5cbVu+p/dJcbuq0khjwbkFy8m4U?=
 =?us-ascii?Q?9OSl8mLWlkAAN3eFK1GqgRbBDDy64QfEcJc7D1vHpq3pMe0kt2AhmJ0Sz4OD?=
 =?us-ascii?Q?zXrPeJllr0WhlT0GyFFCvcnwfXjxAojjsnLABCvqJjKRe/BhBpak8W0B9vxu?=
 =?us-ascii?Q?tNKnj78uqUCtW2gw/CoPGOii4y/pM1GSXgWGE+pa/qcEjkqHEe6pAjFj51sC?=
 =?us-ascii?Q?sTSFN7AsZANUkBCDls6mPFsSm2Fdj6CIEoMzhsMj0LuN+mPKrFbFpDuMF2JC?=
 =?us-ascii?Q?AcUm5Jk67a8UH53Rx+uiSX84H6ehqoSx7d8ibEwHEDuYzq8eq1JfnLzUgk6C?=
 =?us-ascii?Q?cAGUmEkjDT7xH2KglH1xzSkdjp0KIGLYb+k5HF9HFPyObvXZXwUXOr1ujKzR?=
 =?us-ascii?Q?i5BbjVn6xIezqMGDWR8TFMhuCdLqvZ+1y5GP5MMht5A07EKISyfe2dWTyLYm?=
 =?us-ascii?Q?/fsSBFMJ1w=3D=3D?=
X-Exchange-RoutingPolicyChecked: KtKc4+maBSZsv1aNo7lX1zj/su4D2jw7PFpuNxVKeQLhNC594CGVcM/JnYYao6+/nhrUDkG4YnHZnf13nOdvIHc82CVyugF3PyodZj0dMje79OkqEwnpfU6E4A8IABP5kYlHrrCGMUuZGKc02bIi9NIznlVHD/hn+XtuAgD7UaHgAZbxmqWzhVu2neEYBn58mdQb42eQL+eN1wu1KH8cU2S8JivcU9OvZdVdiN+JA0ILfzME5YV5Wh5gmd9ZVgToRNv2ZIwD6Dzmh+88Hss1IvZ0re+O0KulcWjFTnRDvSZmUvfKf5+p1+p8CGP6G29KdJgm+v4CgjwVt2cnxmz26A==
X-MS-Exchange-CrossTenant-Network-Message-Id: cbafbb8d-4286-4d0c-2146-08df300da88b
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3236.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 07:25:33.2883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YGi+2OG/KytaTuxiD+lip5S7xgc4aCsH0rKPZtXHI025asrnClK/m1RfMOp8e8gZn1w2rFzYiOSMP8ufSHBTOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CC6PR11MB162545
X-OriginatorOrg: intel.com

On Thu, Oct 22, 2026 at 06:28:16AM +0800, Edgecombe, Rick P wrote:
> On Mon, 2026-10-19 at 09:59 +0800, Yan Zhao wrote:
> > On Fri, Oct 16, 2026 at 01:21:14AM +0800, Edgecombe, Rick P wrote:
> > > On Thu, 2026-10-15 at 12:47 +0800, Yan Zhao wrote:
> > > > > The point of spelling it all out was to make the contact clear and the
> > > > > implementation doesn't have to assume anything about the callers.
> > > > Hmm, but it's hard for the caller to know if private_page is true.
> > > > We should avoid leaking TDX specific knowledge to KVM MMU, right?
> > > 
> > > Wait, why won't the caller won't know if it might map a new private page? This
> > > is basically to cover the +1 part of the "+ 1 -1" in the calculation. I was
> > > thinking to set it to true for normal ept violation (like an accept) and false
> > > for split.
> > In TDX's .topup_external_cache() hook, tdx_topup_external_pamt_cache() always
> > needs to allocate DPAMT pages for guest private pages, even for the split case.
> > 
> > However, from KVM MMU's perspective, it is unnatural to specify "private_page"
> > as true when tdp_mmu_alloc_sp_for_split() is preparing the mid-level page table
> > page.
> > 
> > So, I think we should keep the current convention of just specifying
> > min_nr_spts, and let the TDX-specific tdx_topup_external_pamt_cache() account
> > for the +1 part for guest private pages, which is invisible and should not be
> > exposed to KVM MMU.
> > 
> > So, what about
> > 
> > topup(bool with_root_spt, int min_nr_spts) ?
> 
> Hmm, ok I think I see what you are saying. Because each 4KB page will be
> confined to a 2MB aligned region, we need at most 1 extra page pair. Not 512.
> But the core MMU should not know this at all. Hmmm....
> 
> Yea let's go with your suggestion. Can you share the implementation here first
> though so we can close it without risk of more respins?
Sure.
Here's how tdx_topup_external_pamt_cache() looks by the end of the series:

static int tdx_topup_external_pamt_cache(struct kvm *kvm, struct kvm_vcpu *vcpu,
                                         bool with_root_spt, int min_nr_spts)
{
        struct tdx_pamt_cache *pamt_cache;
        int dpamt_pairs = min_nr_spts;

        pamt_cache = tdx_get_pamt_cache(kvm, vcpu);
        if (!pamt_cache)
                return -EIO;

        /* DPAMT page pair for the root SPT has already been installed */
        if (with_root_spt)
                dpamt_pairs -= 1;

        /* +1 pair for 4KB guest private page */
        dpamt_pairs += 1;

        return tdx_topup_pamt_cache(pamt_cache, dpamt_pairs);
}

In the fault path, mmu_topup_memory_caches() calls:
r = kvm_x86_call(topup_external_cache)(vcpu->kvm, vcpu, true, PT64_ROOT_MAX_LEVEL);

In the split path, tdp_mmu_alloc_sp_for_split() calls:
kvm_x86_call(topup_external_cache)(kvm, kvm_get_running_vcpu(), false, 1);
