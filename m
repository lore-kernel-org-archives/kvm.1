Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567DE22423A;
	Tue, 14 Apr 2026 10:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776161412; cv=fail; b=OdnhTB1b8/+LyF9TpSkY0zdRc+t6WelXvbqtJvLx6/iCiZpghHzbTMPxQTQMJ5LLhB28EiMZSZe8+nXDfx2b7JLSvibN93EFKNYJyAwLkhFovnEX8R1HbyaCLKoyP6lh23Q+Jt8HzBuL7Jis2nHUpRNXcO5knaR6zF7QwegXrFQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776161412; c=relaxed/simple;
	bh=JKmwCGxR9kZQM0/l16gQdsRQyDehYHt0b9LZs4uZejA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VON338UJQNo9zv3Sx0YO5B4rNUI3NWX7Th415ul6Q8R6JC4N+7/OOPmyH5T14q4jIDP/eS7iW7uTmFwjAiGiZ1b4veLDGSPILlP8dxJoBTym2Y183j6IA0AWITkUC181AZhDIV5OXL/yX6iu+w9tVM+0bS/4pP6P9DPo5qlO2Po=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fW8V6a08; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fW8V6a08"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776161411; x=1807697411;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=JKmwCGxR9kZQM0/l16gQdsRQyDehYHt0b9LZs4uZejA=;
  b=fW8V6a087R2Ay/uJ+tkai3+rqA0Dr3LcXCguH/z0KIVwBC5ajxt5QWor
   ROlaaeqYDyV2TbQ0twx2ZKkkjwVAIAukRIvqtbXHx0eCmvphySvCe4EHi
   vILBmfcnNcYmgyB19loXBkDA9cl92awRdSjeHkAFqHdY+CHH475yHayTf
   lKNjMuiTOEqM+79/xjdp3wCXREzbnkgghs41e1hJ+1BxIKwfwMYsbG9fg
   kq+3f59YTfA7nxTxXqBel71xk1qBrUtdrxyQ3XVg+iJ9qX5mX+sMke26r
   +gKfn+1iIpW4ndt1oRlTci09ZhTkmePg3j6AZdvzWbQq95O80V1QkVQ+/
   A==;
X-CSE-ConnectionGUID: HDv4qY7sQZmRB5/kaNTLVA==
X-CSE-MsgGUID: usoTdMTnQ6m6madSFK/SKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11758"; a="94513913"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="94513913"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 03:10:11 -0700
X-CSE-ConnectionGUID: PJGxOxqjTDmaq3/s0NoNPA==
X-CSE-MsgGUID: 50KgqsxmT/2UB1by7P3fMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="227393549"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 03:10:05 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 14 Apr 2026 03:10:04 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 14 Apr 2026 03:10:04 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.30) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 14 Apr 2026 03:10:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U5JEAJZSQXdoI7YChpSLKlgIBTkKU0U3blQHFvoJUuffoV6a/gW8Z5MZT7s3qE4NKGtUrCA/4uj4HZh4EDpiiKWKBU+ZxBKY/vAsQQaWVElRd2wx9FUmTwTDD5Eo1MnhRhaOTB6fBodripDYlmruqtxc4uCtBtmycDPlYhMkP+pOkFwqI5ODe7hCMVB8CQPBySpNSqq2mbR2IrLcX9TM74ycpqRrP4tX1fngP7SVo0UmDN0uH72EUN3QxaIiJ8bYjpYbB8yNpYP9S2n/rF2xJ2b/dNe40dG8zCyA8pzMbhd+N2H45w8KSJ+l8SPVuzkkS28IRjlSbkazRvTs+Fsf7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P5h8S3f25OF7WOmD9VbVVnTeCMUWrNxgfzcuwKxVV18=;
 b=TXJhjgdJMm66hF34IcJ0GLeIaPqWVZE/dtKOXCPzboidGycqwauRQ2EgG0iuqTmVA3IUkyMBfqNJZdHldtL/9+h+EoMpXXEpYigjmPbiDH6Cw5lsnuxfS/Bf4JMaS8NqQbuwZl8OC3hDYbatrLcmeDRKWmTFt8oky1v9gfc2ilSvxT0kixbNSyBii3DOHXOkoiKPYBYOYlMzdp8jZqydFJYeAccSlJXJ+QQHCue50yHkDAwjonMuho9sUIuGdFMvq00DSKXplayw6K3qIq71aM+53dsK3E9gMn1PHrReYCM68zNPh3ARbpcpPQAvgFQ+4X27GdQ+lxFLtvY8bV1DPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by MW6PR11MB8412.namprd11.prod.outlook.com (2603:10b6:303:23a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Tue, 14 Apr
 2026 10:09:55 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf%3]) with mapi id 15.20.9769.046; Tue, 14 Apr 2026
 10:09:55 +0000
Date: Tue, 14 Apr 2026 18:09:41 +0800
From: Chao Gao <chao.gao@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Li, Xiaoyao" <xiaoyao.li@intel.com>, "Huang,
 Kai" <kai.huang@intel.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "kas@kernel.org"
	<kas@kernel.org>, "seanjc@google.com" <seanjc@google.com>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "Chatre, Reinette"
	<reinette.chatre@intel.com>, "Verma, Vishal L" <vishal.l.verma@intel.com>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "Weiny, Ira" <ira.weiny@intel.com>,
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>, "Annapurve,
 Vishal" <vannapurve@google.com>, "sagis@google.com" <sagis@google.com>,
	"hpa@zytor.com" <hpa@zytor.com>, "tglx@kernel.org" <tglx@kernel.org>,
	"paulmck@kernel.org" <paulmck@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
	"yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>, "x86@kernel.org"
	<x86@kernel.org>
Subject: Re: [PATCH v7 11/22] x86/virt/seamldr: Shut down the current TDX
 module
Message-ID: <ad4SZdlybWkLtLEm@intel.com>
References: <20260331124214.117808-1-chao.gao@intel.com>
 <20260331124214.117808-12-chao.gao@intel.com>
 <a50bb8a4d8c2bdcb0795eca4551567fb5a577215.camel@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a50bb8a4d8c2bdcb0795eca4551567fb5a577215.camel@intel.com>
X-ClientProxiedBy: SI2PR01CA0003.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::16) To CH3PR11MB8660.namprd11.prod.outlook.com
 (2603:10b6:610:1ce::13)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|MW6PR11MB8412:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d50a9d9-ce08-443f-056d-08de9a0df9ae
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|18002099003|22082099003|56012099003|18096099003;
X-Microsoft-Antispam-Message-Info: jFT89e5AuggFFL6XBEZ8VZ0iAYQIZcLs/EKteEmUPnb6Ob0uspe8yKC8LGsjhTKtSTOXy6rGrD5qg66d7g42IkeqejGddMOFD2isaNJaAcuYzYYUSTDI3Pem9FDO019LPcsOTfiHmm+oJzWUTauRkvePX1LOKkv9lS/yQiFB/5vVXvaMOMDyzV8FGgH4xzwP0Gygqiw2jsBWshRVhaxTvZpBTEHvOLSgvM4RvINzF+F11lakj3RU5NhYLd1ouINlhIusGdP3xoMFiHXsk0zTlt4Lu0mEXw/fQ0N7+vRS9a98A4AP/dN14AG4IURvsth6miP7ILB3bcSS4Wltbt8L8CNLd/GdqjFdbxeDiqwaXk2L0j6vhPkp5JjCFzaSnHRlWx+vc+FYBOK2z1sCcawYmjt20t1FvJQLFtxHOj9BB0JKjtwPpwrFbEKALoiuYtxgVl/R/alrly9omtQFCSmt6f2CF+AH8KxGMwgI07OktJ6i92PSmmQ6J0HchaPfoGD9oPHUjiv3z8Ubz0dqGtU4LWLmaTbJnxGNQlt5vQnexc0sXaDQX/l9j3w88ug7cXZSXguYTAguHJJJnikhmg8Ojehoid45kRiSxt6vPDU2iul6ZhX7Xs+3DZlXuvL+GWUSpVMEYa+PoZ78IVQlMU09jJCwqd248St2FL4piCVxZxc6APgCFEHUsZXQwZ8tt5Ip6jRUrb82VKXo1K4Jbj9dTyRJjVO1evViSKMLkXhgq6Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(18002099003)(22082099003)(56012099003)(18096099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?lb6L1tdYSYWBl8l72dQHY5xPOmOyWsm8HHeyxGx1h85z7C6uJRMbvZogQ5?=
 =?iso-8859-1?Q?64/+vbjdYLS1TW9wLO32/Y3Jvpqbb717+GNdlK35ET5/MrgfE3z+kc8kmm?=
 =?iso-8859-1?Q?NIQrG6iWdLLG3ApZn5Cn4LBDOfQzTUDcGnpohFlMCXwqWdQbHe4ntVE8zb?=
 =?iso-8859-1?Q?W22TtdsnMmD86gnyM/ckLljHCtQQZkV9ZADBmbTs4Lb0+JhxTPkynJ3+Zp?=
 =?iso-8859-1?Q?DJyBLmHquurVEqulZT52TqT3i3uNue6MNINvKZrMk9Bp5g3k2dlEzzAhTx?=
 =?iso-8859-1?Q?8hRLUfTmvf0g242qcW/CVwHfGC1u/WpNukt9zPXe23T91ttOv12S89//pa?=
 =?iso-8859-1?Q?Ps1s9TpNCYTU/Bfyxn0MEQ9PVKx15woWa/5nSG3ka1ENv7haMu4d/VlwDL?=
 =?iso-8859-1?Q?HGL4E2IGQ5BQfeAZzHSfnu3KxBc6o7BpzFiE5+a62tSp0uxtVrNE4zA614?=
 =?iso-8859-1?Q?Wu7DWAH/T30tk8ocl8fU62WSATXVd1gzqpprfJbq9qav3QBj8OXeD1HmHB?=
 =?iso-8859-1?Q?ZZGdSk1V30H4p4rmA+D4edefMosPnOL8pG2WLE/ZxG4pSpeodUJp/NfVMw?=
 =?iso-8859-1?Q?F9QvMtA49MPCaiyHIFRLI7EZ6aGzMKp0TiHTGhGKmsJrUYh9xWEQypgThp?=
 =?iso-8859-1?Q?QSKcEjwi7/iCz8O+xFLtCegJNpzTIwNnmphteJH2T8jepBgstr/+l/RUUr?=
 =?iso-8859-1?Q?BuhHHfHvoYMbLPcLJo8lQ5BcXXp+X/9hj+DglvblTK7Sc64I5HZ14ByKoW?=
 =?iso-8859-1?Q?BFGftKBIjACh2oqQTtyLpCHeJZ5JGeDRhbtZYRqu2XhJ24wGywTobLrz+s?=
 =?iso-8859-1?Q?70B55z9RI1dkp8Y4MU3eK2D/GYJ2kaTsY2VAZJrrpOMMob8JoRCExt8/gO?=
 =?iso-8859-1?Q?+TBIe4a+DUboTRcmMPqlr3Lr/lKNgy03MQyhI/xMtzCbecxX4Vb3PLJU4R?=
 =?iso-8859-1?Q?ATY3oDCZhMq7t2JGGrY+RY5sZY9bh6VJXmoMOsv5Bu/MYIMqBT+E8TVMtr?=
 =?iso-8859-1?Q?6xEt/xEVEt5WaC/A39N/T4WGq+UCA/y9M5/3UcB3YHTcZ0AUDrSuUWC0qs?=
 =?iso-8859-1?Q?sSr92DAclr5+PgbruC5FWReqS8LiZVHBpjZ9hEyKcKQqTDGOpqsivG0gB3?=
 =?iso-8859-1?Q?EnNySXH9alwcROYMLC1hoBzEsZ98i94f3JkYdVEe4V3NM4TrE9++ohiu8u?=
 =?iso-8859-1?Q?AGZ3t1ykaXy17fz/cUqZapParOvoDiJ5qYdLUrryqXMol643aED6V/HREj?=
 =?iso-8859-1?Q?0wF0k+pj9vJZ+8sn7KXf7ndIq9hYQvmh7u/hNkS7IEiz9spBLvm115D2+y?=
 =?iso-8859-1?Q?ydanWsj9WKfbyeGnALR9bJWOkCBnoOiCxZd9aNAZNhXWR77i7rzSj04gen?=
 =?iso-8859-1?Q?rOaQzbOws2IWI4T2FwoJ599/d34KF7KVMNT1qp8QCw7FduaVADVcJv7+X0?=
 =?iso-8859-1?Q?T5xFi4PDo/QMXHM/yLggsSwzxOKrqwI9s9KyY/Y+alYct4oBA86CjaSKY+?=
 =?iso-8859-1?Q?UvO3mZMQPgI71Ub7Qp8VwsGjwHbK6nSgo+TXuHKn46lttl+GhrwgL7XPwo?=
 =?iso-8859-1?Q?Flpy8SBLW84rcF0ICdxvQ0DCXlpO2zZSS2aosdJ8WkmRQvjFwjJEXQ4RzZ?=
 =?iso-8859-1?Q?NWNiDMsRy8pFY5gD5pGAblAldZENgREf2+Aj0p2DDS0erpRSO7w3GVAesG?=
 =?iso-8859-1?Q?qzHDSckRmdycOiQplUQK/loVdv7kfpMIztlYoS0ABuBzkRMQ9hcR6PMsXG?=
 =?iso-8859-1?Q?E0Muu57pWQHHbeCAbTYywyMurnLiy3I1y6S/qr80Z07/8OqY4RtjzAWNSL?=
 =?iso-8859-1?Q?NpmfDpfpuA=3D=3D?=
X-Exchange-RoutingPolicyChecked: plzR2Qmfo70LSide6YVA1ZorT8C+Q4dl3xYXcNuldrRVQcMvYxleVF7O1F+eeKOPGL5cqZkxqQy6o7GQt2FWbbF4iyj2S3bD4ry0ejDO/lgTW3jS9f5LPDOQYgFEHYUDdfof39EA7gd4uiwoPzljdZFXGCW3ZfjLQZQ8ObBgHRpGwr72sjA+Ov4WOqYi/GFgKtRZ7MZ+aI1749I4g8dUwxkSq68tSbL7aPaTs0WYB+O+omub0Me0XTQAAKYf9uwdtQC0IKXfg5fOqqAw2NFHVa0socCiGb0WgyChKobnYcLh99N3N1IdRqQ9mhlXFxl2BH2YLLBIOHzR3O04eyoc9Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d50a9d9-ce08-443f-056d-08de9a0df9ae
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 10:09:54.9129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sMMOd+nbVQPs6uaCl/NNnR4k1biKaFarLDI6Ps03574VZttVus1BvsYT6Ljruc+ZHgzxrVMn5wOlZ+hr0eo7gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8412
X-OriginatorOrg: intel.com

On Sat, Apr 11, 2026 at 09:35:32AM +0800, Edgecombe, Rick P wrote:
>On Tue, 2026-03-31 at 05:41 -0700, Chao Gao wrote:
>> The first step of TDX module updates is shutting down the current TDX
>> Module. This step also packs state information that needs to be
>> preserved across updates as handoff data, which will be consumed by the
>> updated module. The handoff data is stored internally in the SEAM range
>> and is hidden from the kernel.
>> 
>> To ensure a successful update, the new module must be able to consume
>> the handoff data generated by the old module. Since handoff data layout
>> may change between modules, the handoff data is versioned. Each module
>> has a native handoff version and provides backward support for several
>> older versions.
>> 
>> The complete handoff versioning protocol is complex as it supports both
>> module upgrades and downgrades. See details in Intel® Trust Domain
>> Extensions (Intel® TDX) Module Base Architecture Specification, Chapter
>> "Handoff Versioning".
>> 
>> Ideally, the kernel needs to retrieve the handoff versions supported by
>> the current module and the new module and select a version supported by
>> both. But, since this implementation chooses to only support module
>> upgrades, simply request the current module to generate handoff data
>> using its highest supported version, expecting that the new module will
>> likely support it.
>
>I feel like somewhere it's missing what this patch does. It explains the
>reasoning for the handoff version selection, but nothing about implement
>"MODULE_UPDATE_SHUTDOWN" or anything like that.

Yes. How about:

Retrieve the module's handoff version from TDX global metadata and add an
update step to shut down the module. Module shutdown has global effect, so
it only needs to run on one CPU.
