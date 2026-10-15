Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434A54A2E1F;
	Thu, 15 Oct 2026 15:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792079214; cv=fail; b=Kv2XYYFKKnH8Yu+c25ETkhomCUgJFKPX94qS5rytscJ5er2D93LiIuJj75BIhb7u1MOGR8GWia0vN0kbML2H7+wkPUMHCEE4hubhGcx5J6R4uilhJaODZbNsOcBU2M3tMKtwI/OxqkoPvpGzhES8xrSZvHExZF1wBwnLQyb4VJk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792079214; c=relaxed/simple;
	bh=BPMPHu7maBlHLFho18llMAc63lSdoA1RmLVfxxDMAAs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QewmI7wzuJHhVDtGQLVvteq9Lwm5e323fj8IZR93vToXrypQYfu8L8mhLa8aO2kgz022i8Suw0+p5msUJtM3WOizYPm9EuS4JtVqhCh3144dBxNSbyX9Kii2IF3ap+I0fzzO0x0gRujDxjo5xwCBjvnf5+MnSYcIj1UOCKROWDA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N6MXTSXc; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N6MXTSXc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792079195; x=1823615195;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BPMPHu7maBlHLFho18llMAc63lSdoA1RmLVfxxDMAAs=;
  b=N6MXTSXc0cSmjq8F0QwAHJWswYniCmy1WiIckEHjj+eyyDbm7ZvZN/5+
   rvi31NdiAbasI2zBUkPDuuByFnRmaW0rW7F9fOkK2pQmxsMBzJT+rtenC
   ICkGJyTej/qCj4kBmBtyyL+rEpHXN7k8xtxi8rPH+N10ArwXFq3dPOwnb
   DPMgjJrAusCFSaCu2AQeApEu3ue0XpKgmhxl9t+9sSgGGrdqlequVvHFB
   hN4wdqtblQlnaTmNS23qLPEpcJ15/geIlwxWS2InxsA8ziSAfuobUf9WE
   vVBjtkl4mnNFqKLa3b0D4Cqhu8BL7jmORGDmr7Uout4vhSGUtGBdTWCub
   w==;
X-CSE-ConnectionGUID: RpVgOVAHRza5GXJ4Ue00xQ==
X-CSE-MsgGUID: q3z8+xMtS+mqzZQWyin7UA==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="958074"
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="958074"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 08:46:34 -0700
X-CSE-ConnectionGUID: xVtaikZiQ5WrfTEaWidS+Q==
X-CSE-MsgGUID: t1f1jx08TI6Tqjn/BWCBUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="1737497"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 08:46:34 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 08:46:34 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 15 Oct 2026 08:46:34 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.30) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 08:46:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mc38od9DCqkByoNqkPwMTJxMJ035onFDjSSU4YDsYHglSDc0gIpwejc9mUr5skY+bpMeyP4eHdKiFETbAOfRS/M5OgIeZ2Kc07wg1XIZr7F7+S54k2AHy5bDi+JowV30Mq9BRx9sBCn2u7GLxE30LfnQPfbyLBqh5QH52NJDc0Ja+ePoZVGxX370GkvChg1azXEGVbOCsv4w7boITtvcEwJiVcN2mX1V4wl6ezffjLF9l+UzZFcHZejtsQmLUJsshWmUTlC8loXkaFPAI9QODS9V1svuQnmZQOJ+bnVuvOuYj8YNlHmwF0WovWwKSrjyX3DUpdUZ/iUnQ+ePM57V8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5NBtpPYc98QkdHwl2yCR+DVT9vcqA7QCNcHwlV7saek=;
 b=BRtXyZH2tXRx8tqBV+l6duzKsg+ahCjhIX1psqWX3ItOu3XQ94fTT4sAL3U5cFE3FeJzjJhHYCiIsKmqSkre+6t8vu05hp7CJq5Eh6Xvv8989I+wy2jNKG2lOOK49dO2OEtK24Vx45ufZuOx77E7d6wOMCXpJ8HlvtzNg1XedAx40Hq4PMrjSBFtINyut32D+fI7hrRx3bRDIgO/yaBv7QokdhU5fdVcDhiBRRDmHnCmzke26q+/TYUodKFp6qrVrrHXW9k8xBia/8XbfHgtTt+oJKEk3Yp18zsO+nT5Zb6b9mjKpImazB0QyRxaWj8i6z3Z8A6pmOKI40t+S81njA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB8370.namprd11.prod.outlook.com (2603:10b6:a03:540::20)
 by SJ5PPF8EC896901.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::844) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Thu, 15 Oct
 2026 15:46:30 +0000
Received: from SJ2PR11MB8370.namprd11.prod.outlook.com
 ([fe80::b6cf:ce77:3cdf:7cc]) by SJ2PR11MB8370.namprd11.prod.outlook.com
 ([fe80::b6cf:ce77:3cdf:7cc%6]) with mapi id 15.21.0496.021; Thu, 15 Oct 2026
 15:46:30 +0000
Message-ID: <c600a240-ed11-4e31-b3c3-779f01175f28@intel.com>
Date: Thu, 15 Oct 2026 08:46:26 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 14/18] fs/resctrl: Control visibility of global per-CPU
 kernel mode group files
To: Babu Moger <babu.moger@amd.com>, <tony.luck@intel.com>, <bp@alien8.de>,
	<ben.horgan@arm.com>
CC: <corbet@lwn.net>, <skhan@linuxfoundation.org>, <rdunlap@infradead.org>,
	<x86@kernel.org>, <Dave.Martin@arm.com>, <james.morse@arm.com>,
	<tglx@kernel.org>, <mingo@redhat.com>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <fenghuay@nvidia.com>, <kas@kernel.org>,
	<rick.p.edgecombe@intel.com>, <akpm@linux-foundation.org>, <rppt@kernel.org>,
	<dapeng1.mi@linux.intel.com>, <elver@google.com>, <enelsonmoore@gmail.com>,
	<jlayton@kernel.org>, <kuba@kernel.org>, <ebiggers@kernel.org>,
	<seanjc@google.com>, <ewanhai-oc@zhaoxin.com>, <binbin.wu@linux.intel.com>,
	<peterz@infradead.org>, <ashish.kalra@amd.com>, <superm1@kernel.org>,
	<chang.seok.bae@intel.com>, <prathyushi.nangia@amd.com>,
	<kim.phillips@amd.com>, <ackerleytng@google.com>,
	<elena.reshetova@intel.com>, <naveen@kernel.org>, <darwi@linutronix.de>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <kvm@vger.kernel.org>, <eranian@google.com>,
	<peternewman@google.com>
References: <cover.1790867441.git.babu.moger@amd.com>
 <28d7e4484c93d899ed86ddafa13faccce0dedca9.1790867441.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <28d7e4484c93d899ed86ddafa13faccce0dedca9.1790867441.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0025.namprd03.prod.outlook.com
 (2603:10b6:303:8f::30) To SJ2PR11MB8370.namprd11.prod.outlook.com
 (2603:10b6:a03:540::20)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB8370:EE_|SJ5PPF8EC896901:EE_
X-MS-Office365-Filtering-Correlation-Id: 349ff20d-3338-4e9a-6494-08df2ad37b21
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|10067099003|18002099003|22082099003|11063799006|5023799004|261009223027099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: h6UZ7yrGNcvLCYjwA812NVXKe+Krlsuf/0IURwpdxhR7WrMK4IGr3bcrRo31ygKL9YNe8olTYgVijqgIpcycsiQXA/B3VxJVF34v0tsLwf8B9Ps6zeBb9qq27I1xFpnm1pNrQodmndYXUBc0R01KnqvYe8t1QNg3BDEfQ+R1uY7uwFBbc1P5QMPx7iVlJk6rgN6Kx5Z5SgRRSsOvpi5pkk/na4YAnnUECpmJ4/PZBn/SPEkcVnhhMlVrVcGQX8mmlyihE0R9nz07T2Bz7GxE+IAbZ4C/jPjn1kYIl9F7l331QcZcbNsTyJE0uJH59al+YXu+dp5jkSy3Ecu51QmvBItlUVgRh+mr4Sv+18At73PtM5uASObvckVxXXuhfCyGFzh0YmDwxWYnLMt5no+67VAMpeCvmV/zl7GvnQg+Pg6nYqA18Hp5tnMnaV+aIyRvrR9U63xUGyIhpSQbGXWeDBF13uKBy90vlv28k830sX8Nu8/tcyI/1XEUUOyuvIouLEo2TBgW3W5nZB6XY9a0s+K8cNOMs4Ii1xxGEecA396X0d6CpgOq3VB+RAm0NqlqukvtN/y0pA6b7+jm36j4JjJERLn51GpEc3Za9UFCoKc6gky4BZaVhuwdt4h0eQ9c
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8370.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(10067099003)(18002099003)(22082099003)(11063799006)(5023799004)(261009223027099003)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZjRHZWJkaklRbExNcnhDTUVhUDkveldJVmhtVTJOYmhwZitFZmZJRU9LNWov?=
 =?utf-8?B?c3pCVlZnRWNNNld3bWk0bG9SditQZUNVdlVnOUVZWVoxaE9zM3dRZGFHdHZx?=
 =?utf-8?B?VEx5N3QxSGRzWjh5eHl2QTE4OTJMQjNUd1RlOFgxN2RoNHloYk1tYUdJQ1dD?=
 =?utf-8?B?bklRNmV0R3ZtOVE4UWJhRjZWZ3Y4SG9XVEN3R2MyaE96S0p6N1dhRGR4ekdI?=
 =?utf-8?B?NXZaRDFBUjdsRjZuZ3lBQU52cTYzQ0xLc20zaVNuUFNZenZKSHdPY21KTXNR?=
 =?utf-8?B?TTNIb0RrNnMxWTJiRzlIZzhhNEFkS2lTY3dxTGxNQlpjRXladFRIb3pFR3BY?=
 =?utf-8?B?c1Fpbktxc296bDJTUGxNb01WamF6eERMT3lKNjNWbENNeVRnalUvMlh1QWRq?=
 =?utf-8?B?VDErSGNqY01EYU1FakRYeWthcXlDT3hqOUNyM21IbytZQ3gzQWlVS25SbVpw?=
 =?utf-8?B?b1FEdzZkZWhiUTloUjg3M09MTWJBVjgxWDMrUkNTR3poSWZyZGlOa29kWXVs?=
 =?utf-8?B?N2NuOUhuT0F6RlM5VUFRT05sRXVTQW9aSjhkbDQxSk5kM0o5MGZhNW45TEVv?=
 =?utf-8?B?Zk5YVEJMdWZiSnNzVmM2TGhLTC8xaU5RWWQ4N2lBM0tKdkF0ei9veUNNL1Nr?=
 =?utf-8?B?bVRMUXZIYzYxYzJGZVA1eS94ZG9maTVNRkRuUnk3T3dpQzdiMEM0NTNPaFMw?=
 =?utf-8?B?Tkw5am1FK1FEbmM2YTMwNFdiWlJyMW9TU010RXZNaU9KNEtRSjNNZFdoMEdW?=
 =?utf-8?B?aEE1cHZWeEJnd2lKbVpIS3RvNERMSWhWK2JyTzJNMjRuSkxOdHFkVG11RUpF?=
 =?utf-8?B?ZDcwR0x2Mlh0RzFQK1RBN2NqR2F1WUlXYkp1ejFLbUtyZVBSeVFkUUdja0N1?=
 =?utf-8?B?bEJnK2kyanhPOWNTL3FXeUNleHlqdlU5Tzk2ZmxHUXoyY3dFUW5GR0JkTUxj?=
 =?utf-8?B?M1g0YmJ3cWlvdW9qUW5lc1RLNURDbWpQL3Ayc2pYZnVsOS9MQktlUVBtN2RU?=
 =?utf-8?B?WEo4MzBqNmltdWlxL0xhZmNaWDN3V0k1Q3NSMWNVMlRWZlR1QzRjVGVlYkFy?=
 =?utf-8?B?c0QwdFA0RGY5dnNzQTFQbXR5Z2pJT0IwUmtzMGs4UzJrUEZoR3NYY21McVlY?=
 =?utf-8?B?RU01OUI5RTQ4VG5hZE14WXJqT2xvdEsyNyt5Mm4xZG9ncUVjRDhGbXkvR1Zy?=
 =?utf-8?B?VGNWNUxadytjcTRKRGw3ekJCMVkxVU95TTdLY3dnSXFGSm1Wck5DSEpkUHEw?=
 =?utf-8?B?UTB5K1ZWemtiUmlKZEtrMU5jQTN1aDZtdG9jMUMxcWNicmoyVEQ2ZC9LRzJ2?=
 =?utf-8?B?MXBpQzQzY1ppZG1YbXRNUnI2RGhzL0lNYnRtazRqeHl5b2tha0JtM09vS2Z4?=
 =?utf-8?B?cmR4TDlEbytzOHJQUmFNNGdlekwvYlpBcThjNnVDRElpV3dkYS9XUVQ2dTcw?=
 =?utf-8?B?b2ZUSEoyZDJacUFqRGVuVWNjVTRsRVZZL1dzelBpQ1NtcDZObnZFWFVhV3Rs?=
 =?utf-8?B?N1pMdTdkREo0a3g2bC9pd0xqaGI0NkJ4VTNmSlk1TVJOZEpoeVpVV24xSkJL?=
 =?utf-8?B?TXo4OFVrakFHWDBWYmdNd0tJQVpJM3hkMTMvSml3V0N6YWF5OTJqNkdCelhs?=
 =?utf-8?B?MG5Ea1hRNy9vUzcwS1U4cG1IZkkvdlh2bS94NVpGM2txT0w1c2pDMVpYd2gw?=
 =?utf-8?B?a3ZGMDhmdkVlSjMzOHl0T050SFZBMjlqcWVRb0hHSU9lb1NEVENlcUJNcjhH?=
 =?utf-8?B?S1Q4aVpuNnB6TXQxMFNuejBMbUo5UkhQRUc0cTVRa0p5SEZtdC92RGJHK3R3?=
 =?utf-8?B?V2grcmhVeFAwbWc5ZXdGa2pIQTV5WWJSekhNcVFyK0RVRWxvZ3dSbHlCZU1q?=
 =?utf-8?B?RGcwOGQrSkR2S1RaZWtlSkFpVThwM3pkS0hUVVlBZStTeHhYOVV2RUNuaUgz?=
 =?utf-8?B?WUIyNFNEQW9CTVNOa3NDU0lxYU1OT2VLQVVwSnVLNkZPV3J5Skx4THljaytT?=
 =?utf-8?B?TGtBazZBYXZIdVNEZUR2QjlqRDVTRzFWM3pUaHVnemVTZmVFM3Bhazl1emI4?=
 =?utf-8?B?SStsU0pBSk9GenVzYjZ2T1pSWFpJQzFrcVUrUXJmVUVMZEt5YVdhSTVZRnVr?=
 =?utf-8?B?RTlYRWk2QXVqb3V3OHN0OUhKNm5Sd1ZmSWh3UmdVQzhHa0Rpb05PbXdDZlhr?=
 =?utf-8?B?S2k4REpTWWpYNUtrV3pnNG1VMUlhekpVOXZqVEptWVY3YVdaN0FaVXdLOXZq?=
 =?utf-8?B?Smp0VlhZaG9SUkFseSttUC9SMlJFS21qZGdydDI5MDRvYVZEMDBQZlovOU9h?=
 =?utf-8?B?NnUxR0FOTGZ3SDRldVpQMG1wK0oyWmpSQVJZWWRFRDhDdXpERkR1b28yamZY?=
 =?utf-8?Q?CNbVcTmriPm75OMA=3D?=
X-Exchange-RoutingPolicyChecked: Z8QFIkyY4PQa5b3t8R77kalj2+HrVaGYXdjtiyq2djNhqFWWN5uvpVXBCbURA1W6GY2swWANVXeL9g3NZPCMrQd/zLiH0JxW6MkpMDw+10B+YWWZZKUPTWHKyJHavzQ9EEz1YkqMAm6lipYeU3IyMM6/yGGKousC5AVQ2s9YLEWxLoqIaw0y90YDPsDOv1g9MOSDsKvv4YEum3P4JRSdTCGcUoK2nKNpy1OjER+PmKvXYviLP5MZ4PPN/dSWNdcKi2anjjoduqnyu5YOW/iaKudykA1Gr4Stw6puhvQhblDQ+BtbyTMWsDr0kT66tUPLjcuXYAhqmXRkDVDdagAMUg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 349ff20d-3338-4e9a-6494-08df2ad37b21
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8370.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 15:46:30.4526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D/k738sl57buZJyeErtwYSwLUfMH/euaPKq/BPx7S0y54gjBWxYwfZ0XNM4zXimOWOV8dbm/cOZyEvS4SBPENc4AfODyzt79jSFDEeArdBk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF8EC896901
X-OriginatorOrg: intel.com

Hi Babu,

On 10/1/26 8:10 AM, Babu Moger wrote:
> The kmode_cpus and kmode_cpus_list files are specific to the
> RESCTRL_GLOBAL_ENABLE_PER_CPU kernel mode. These files are created in a
> hidden state when an rdtgroup is created.
> 
> Introduce resctrl_kmode_global_files_show() to manage the visibility of
> these files based on whether the global per-CPU kernel mode is enabled or
> disabled.

This does not sound right and does not match the patch. The visibility of files
is per group, not globally whether the mode is enabled or not, right?

It is ok to have cryptic changelogs when changes are small and simple but these
changes are not small and simple.

Sidenote (on topic of consistent terminology): Please stick to "activate"/"deactivate"
for the mode itself and use "enable"/"disable" when mode is enabled/disabled per-CPU.


> 
> Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
> v6: Helper named for the global per-CPU files instead of unhiding every
>     hidden file on the group.
>     https://lore.kernel.org/lkml/34aa4824-810b-4c81-8188-f2f37e1dc277@intel.com/
> ---
>  fs/resctrl/rdtgroup.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
> index 0cdc868a55b1..98451b417fe3 100644
> --- a/fs/resctrl/rdtgroup.c
> +++ b/fs/resctrl/rdtgroup.c
> @@ -1125,6 +1125,24 @@ static int resctrl_kernel_mode_show(struct kernfs_open_file *of,
>  	return 0;
>  }
>  
> +/* Show or hide kmode_cpus and kmode_cpus_list on @kn. */
> +static void resctrl_kmode_global_files_show(struct kernfs_node *kn, bool show)

I think this can be simplified by changing the signature to:
	 rdtgroup_kmode_global_files_show(struct rdtgroup *rdtgrp, bool show)

> +{
> +	struct kernfs_node *kn_file;
> +
> +	kn_file = kernfs_find_and_get(kn, "kmode_cpus");
> +	if (kn_file) {
> +		kernfs_show(kn_file, show);
> +		kernfs_put(kn_file);
> +	}
> +
> +	kn_file = kernfs_find_and_get(kn, "kmode_cpus_list");
> +	if (kn_file) {
> +		kernfs_show(kn_file, show);
> +		kernfs_put(kn_file);
> +	}
> +}
> +
>  /*
>   * resctrl_kmode_global_online_cpu() - Program kernel mode association for @cpu
>   * @cpu: CPU that has just been brought online
> @@ -1175,6 +1193,7 @@ static void rdtgroup_kmode_global_deactivate(struct rdtgroup *rdtgrp)
>  {
>  	resctrl_configure_kmode_global(&rdtgrp->kmode_cpu_mask, rdtgrp, false);
>  	cpumask_clear(&rdtgrp->kmode_cpu_mask);
> +	resctrl_kmode_global_files_show(rdtgrp->kn, false);
>  }
>  
>  /*

Reinette
