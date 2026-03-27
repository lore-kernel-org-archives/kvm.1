Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E85D1EA7CE;
	Fri, 27 Mar 2026 22:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774649587; cv=fail; b=E81u8Y+0cZwNP/YvE6A1oJfzWmupTLfBG+OWJXPWOn3NNuW498HKmwnzRN9vHM7HOfogRYP++0p6KcU26nekQTJWILm5Mi+cdBWKl2JGKLqIheebcdbNiesJ3kRPrD89e7yvXRCXVRwKZmqN8eBu/+/+6LY3OgTrArrJt487cDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774649587; c=relaxed/simple;
	bh=sikzxkqmu6+t6TPjJBVkXSW8BuVnouvdagM2dhJ0a18=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IGYWMav4DoTGwNrlyhbRJCFu+k7dOTSxQlTVfWXuvnBbpM+A5ZCpWGPjllWXnEw4AAHeClt9Tlzys0fZjOjUwe7zoSqpsqupmrLQLp1TDPZqABaHrbbgLdIOUVGZk2Tx1ulJwMM+/5IIZNFPOF6cFW0HobbtrlbpoxoogqP+kyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SKzNaQDQ; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SKzNaQDQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774649585; x=1806185585;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sikzxkqmu6+t6TPjJBVkXSW8BuVnouvdagM2dhJ0a18=;
  b=SKzNaQDQhutfky2JAgpUXwR8rQ9GVZs5Peo2pXpEMrF9UuHSZj3CioOe
   ZJZD/IZnbUoTtiGaND734XPOMR6i5ZJAOHegVisGEqJf1RZ3Rp6S/YTG9
   9w0uckhmyJ3EjDOivQ9oQxShu1IW5on0FtzTvPby5NqVbM58ytq9NCbHt
   hNWT3ZYLsbEsWvHBcWUBcfjCIaUJAo6PcMC7EQCqUxErGjOC/4CoKECZ8
   23pR0IcujrYa9D0880w43QHRN49IZVXDVWQeA+xV4whKgXpr9zMaGLYYZ
   lqLXl1OaeZExfWbx6o4SSLgAC/qGWVsQvIE02nHGRpsAzq7PFfxTZHNS/
   w==;
X-CSE-ConnectionGUID: T9IO34QiRruje3NIcaUrAg==
X-CSE-MsgGUID: XnqKFW6WRuucc69t48/Wyw==
X-IronPort-AV: E=McAfee;i="6800,10657,11742"; a="75844172"
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="75844172"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 15:12:56 -0700
X-CSE-ConnectionGUID: q+Q/P2goQ6K3p6Ip2o1jDg==
X-CSE-MsgGUID: 3XTvaNOUTSqhM0/S5eQqLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="227039846"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 15:12:56 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 27 Mar 2026 15:12:55 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 27 Mar 2026 15:12:55 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.54) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 27 Mar 2026 15:12:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uj4ZJwheTklhILilt20s0866ycfEKLAoNJbwpCrg/XjAru94JUiN/g0hgWFqrjx4kLUK1aGpQgaiqOMR4kSkdrJeOD8UMA4x2qccZ2XpZkTkfDyACwP4nN3etGI/cHsozkLdc+M/U5jqb8j/7SlwHI5SxLO+IGUPEEAubLYz1988c22rVFLuXYBgRK+AClfWHOkilv66mbV/iqBNAaZ6d0s/8Xme1w3RBskMYuovTYrBgvlP4raNlBeerIF1rpPVFyc/FcRkKze3i4WqpLCBuXI2nl4QGmggZS7ukyYfQjjEWyV7yEDjp2kq2ELHV63iQPD3dvJO1PkSwR57ObjIaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Ir7zXXQFhdOr2MVCIdE7OA9SF5Ohqw2TpeehwZr2fo=;
 b=AOTV9FinOsJ4MGsWrWjXvEkPE1z2XDo2b5NTsFX+8GfHgySwOj0hZ/k4F2kC9R3ZS5VdZolKFwM9P4hEyYiLAadYWqLc0v6YdQ2rJ/+RZusxBNH8YNCdcdkhs/4uYJsZSzgRvNZEmm4pQxfQzAdttAfO5hinR5/VYW7VsZMIRCOdkh0e1fqdZDguZkR5i+b8bTyE0wLcm0ZtnVoIuSjjDiXV4h9kmDPv2lPbUvg9aau2miFl0P4nElN/3eCZGemloDWzCNmRHNsVHt4eonSj2y0HJA8vpZzw4w48t1BcsnOBtWU23QwrKFKwVhpEbK0QzGyKDlj+ZSdKPQHXGeEepg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CY8PR11MB7058.namprd11.prod.outlook.com (2603:10b6:930:52::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.8; Fri, 27 Mar
 2026 22:12:46 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bfe:4ce1:556:4a9d]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bfe:4ce1:556:4a9d%5]) with mapi id 15.20.9769.006; Fri, 27 Mar 2026
 22:12:46 +0000
Message-ID: <88eebfac-5286-4788-b244-911c659c0439@intel.com>
Date: Fri, 27 Mar 2026 15:11:44 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/16] fs,x86/resctrl: Add kernel-mode (e.g., PLZA)
 support to the resctrl subsystem
To: Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>, <tony.luck@intel.com>,
	<Dave.Martin@arm.com>, <james.morse@arm.com>, <tglx@kernel.org>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>
CC: <skhan@linuxfoundation.org>, <x86@kernel.org>, <hpa@zytor.com>,
	<peterz@infradead.org>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
	<vschneid@redhat.com>, <kas@kernel.org>, <rick.p.edgecombe@intel.com>,
	<akpm@linux-foundation.org>, <pmladek@suse.com>, <rdunlap@infradead.org>,
	<dapeng1.mi@linux.intel.com>, <kees@kernel.org>, <elver@google.com>,
	<paulmck@kernel.org>, <lirongqing@baidu.com>, <safinaskar@gmail.com>,
	<fvdl@google.com>, <seanjc@google.com>, <pawan.kumar.gupta@linux.intel.com>,
	<xin@zytor.com>, <tiala@microsoft.com>, <Neeraj.Upadhyay@amd.com>,
	<chang.seok.bae@intel.com>, <thomas.lendacky@amd.com>,
	<elena.reshetova@intel.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<kvm@vger.kernel.org>, <eranian@google.com>, <peternewman@google.com>
References: <cover.1773347820.git.babu.moger@amd.com>
 <14a8ad0a-e842-4268-871a-0762f1169e03@intel.com>
 <47c0db32-d0e0-4c53-90bd-b74863d233dc@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <47c0db32-d0e0-4c53-90bd-b74863d233dc@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR02CA0010.namprd02.prod.outlook.com
 (2603:10b6:303:16d::8) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CY8PR11MB7058:EE_
X-MS-Office365-Filtering-Correlation-Id: b0c1464a-70c5-49e0-d750-08de8c4df947
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|13003099007|18002099003|18092099006|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: FbctXdabwGd2vcGFH4k9pkEkY+u+cCJuuFisuLu18RvhHQuW8u1QeuZL18mfV10yQLT92eDOxsJAUyZI4u2PjfQUS+oFeLxJhz1cJfEOMa6ZuGEO7wTKffSMW6GfS1XnQGOhz/JVhAtwhNuwoO/E1sq+6o6R/wOSP1dUBx7u2pgN7KAMGhFr9YGNmEQ/Co2WDCL8qEiLnJh07VbzxDpLtS7ulwJpzIC5BMbdT44ZNUrIjuwMS7L+ByhecQhUZpWHUenBD12VtaQnBIoiUMypIXP4ljPEhYxWaBNvA3ejP8LQWacOmbs0eDYfNuCsR2QQ/hZsL4NU51P6xtY9g8IdU2YUjNvYNroODRQESum/MqhueQ5GD/7el2l4Sl+p3pe0z0j+EP+o7Rn8c+D9mW9zUn/4vt36hNe5AEmwkfxMiFIDH+W/qdCboGhMp5cY7Tl5fuAcLLx6R+dLP3RTtW30qEsRlKtUxYxvtehe2Hso0H1dDeaW1r8a/eclj3JGN5Wj+jO44MHvY5cJuBYNJRACpd+/2SiZN8AYAqO5vbuh22M8NtyG4FaoF6BGafDhC89Jgiiq2e9/FFJRgacxxJU1Hib4EYVfYrj8RSt6VKSF5vMNZ9AusNmGMTKJuGF7FS6iQhnelreLuA5jZGdBAxh/Aq+rrIktMwsFQPz0e7HDVCk2bmInSkLriexQCV0Kusde
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(13003099007)(18002099003)(18092099006)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWFWYjZyNVZ4QW5zeHd1OVNSNEl0NTZ4aUd2Ym54WGticFB2M0ZraFZ3SGxZ?=
 =?utf-8?B?dk9JYUFVWWl5aE5Wd21sb1pRMGdpaXZQR0FEemgrUDFwODRzc25PemhZNjdm?=
 =?utf-8?B?WGFZcXYzcG5oU2VyVGpZZXVWY1FvMzVEL2xxTSsyblBYL2x0Nkl1NVg4emtp?=
 =?utf-8?B?MStGRmdBV25ST3NPVnJ2Yk1ZUDF1WmkyOWVDWmd1N2wvaHR6S2F2a0lHRm1P?=
 =?utf-8?B?blYvZCtaaDFMeGJCZmpnSEt1WHBielZRekIrSEkxdlVYbHg2WWZlT3crNnJ3?=
 =?utf-8?B?bTdwM3I1NXVFeklwU25IdWxHZGZ6Y1FJM3FTZlUxWWxqcWdQNTZQU2hXZHJX?=
 =?utf-8?B?c21hdkZoemtESTg3em9xZHNtTjVlbzVKNXcwZ3lUSlExNzdOWFA1cGh6M3lE?=
 =?utf-8?B?a3V2MjZHVjZvVWhrOFVndHZGVkFrNVdyWWNaVTJZeExtRHlHMEl4SkpMc0Zt?=
 =?utf-8?B?QU4xUW5FVnp4dTNoUGxpc0t0VzNCdHlhREo4cG9RSzVFMU1JUTlnOEd6Y3Jk?=
 =?utf-8?B?RDNSaUZEelBSOW10QXVzU1orUW9yQXlyaE13MUJWa21IUGdjQmtleENqLytH?=
 =?utf-8?B?RURqR2NHbHI3Y1kxUFpmbTNPMlk1QmFQb0krRTkrRndWRmJVWGpMVDRQS21h?=
 =?utf-8?B?MUF2eUVMc05QcjJpMDNJb3BaWk0vTjZtNUZycUd5bzBYeWlzVkRwTE1wMmM0?=
 =?utf-8?B?VWZ4TllCK3ZaK2ZPSTZYMjdvZDRuc01tMUNZTC9oNVpOUVpSaUZwcWJqVU4v?=
 =?utf-8?B?czFibEhuUXB0MVZhQlZJTndIZmtqMjNqYU9jcjBqWjA3QkZNNFF1RS9CQlFO?=
 =?utf-8?B?U2hCeklLOHZuQnQybGdNTUUybFZkTzRQRGZkQ3FuYStUMUUrZmRvSjJzSWwy?=
 =?utf-8?B?UkhtZWtSVHB6WFRHOHBkRHVlK3dFbjB1Vk9OVzVyQVBPZEIzT3JtazFJM2lN?=
 =?utf-8?B?RnlxbTJiVWFCSDlyNW9hZlFSYitjNC92L0xWRDcza2x3S1luK2dwSEVqelJG?=
 =?utf-8?B?WUJYcGlNMkRObHhLTWtSWDkyQzUwTTQrT0I0SDduMjVSR1dSWlBDZlV0NWY0?=
 =?utf-8?B?MUliT1lEcy85OXdMcWlmWVBrWlg5ZittanN5T0tWdXNmQUtXZ2RlMTZRblA2?=
 =?utf-8?B?NFVpTWhSVkYvZnVVaVFkZlJhK2dTLzVsN3lVY0hrOUVFVHo4OEd1cStPUTNI?=
 =?utf-8?B?L1N1YW02RXRsaFZidHFOekMyTmdYL01ta2ZSaEJ4ajh3blZZbTg4RDR4TnZu?=
 =?utf-8?B?ZGZMaEdna1NML0t1U1dzcEJ0blNhcGJVQ3JoL0NNZURuSmZHKzgvR0lWdjdK?=
 =?utf-8?B?Sk81T29FUjhxaVMxb0JpK2pTOTM5VWpHY1hYd1J1RVhhWHdGYjBvUHlZWEtC?=
 =?utf-8?B?NG8rQVh5VlZFQW9VazgzT1N6b25qcmZmSFZzMElYSW1pNGNxbjQvaktxUE1L?=
 =?utf-8?B?aVdUVTZ1eElSV2Eyb0lxd2RZeDFudG9OTEJEUllnY0s3UTRVSzl2WjExb0Zt?=
 =?utf-8?B?UHpVTWdPOVh4dDVzRGF2VTY4WFFwMkJjU2ZQZi9LeTcwTnZ2aTVZS1BaemNK?=
 =?utf-8?B?YnZyRWFHSmF0UEpKV3piQk1lVFBQaldQUlRjVUlaQ2MyZWtsMWwzWXNBelVM?=
 =?utf-8?B?ME9uOExVU096ZnhFNTExUEtEeHFBNjFKNVN1ZGViTUxVU08xY2Q3S1NTZG5k?=
 =?utf-8?B?WmJTa0tTc1ZIZjVDaXF4TkNjOEM5YVN2ZVF1WUcrSnRYVTNqNlZSNVg1WkZN?=
 =?utf-8?B?VEhqSHpWaVRvTUxJcmd4c00zTlBEYjVHc0JxczVQV3c2Y003OUkrMXdlUWhI?=
 =?utf-8?B?dmFoTmplMnRjdjBSdG1Pblk4OEVRRlhSUGNKWDVKeUs3eGFCTC9mcWs3L0J2?=
 =?utf-8?B?U3FqRm4zNEZzRFk5citqVlFGQnQvNGtxM2xZaW1tRlNDRnpEWEFnM1FnUVo0?=
 =?utf-8?B?Q3hobjIwb3hWUmpFK0cxallCRTB6N1dRRVFRSTcvRkZBQ2NJb2dTdXNlNHl4?=
 =?utf-8?B?MWQyRmpPbVJFekdaRjVra3JCRXNiQkY1a1A2Z0hRMFBLdkZPK1FPRDFPTmg5?=
 =?utf-8?B?WktPV1gyUFdqYXRkcFdyV2FhRTRKNGFOaEJVSHFNNXJPYnhrZkRkUGdGVXZE?=
 =?utf-8?B?SlRoWHVtVkRlZzNzSzZjT0J0NjNMLzJlVXhaUjNaMkN0S2hYbVpnbmNlRWE3?=
 =?utf-8?B?dDdBY1dpbnZIdUpDOE5DTGpWUUZlZTUvTGJIYjhEbkZRczdrNmVCb0pqcmow?=
 =?utf-8?B?dVF0RHBYUkxnaEY1emw2ZTBSSXdydlg1aVJGYUY3UVBBekJhM2xnVCtmR0M2?=
 =?utf-8?B?T3hOSmZLRXRqUU5aaWpUK2dWcHNpUUVsZHZPRXVEVG52KzNzdDJlelJSTmFm?=
 =?utf-8?Q?BAwqdqOTTsmUJ6mo=3D?=
X-Exchange-RoutingPolicyChecked: Vfoh34BWjEz0VlW95/7kTrHuff+qmQrMBHdcvou/57NZtHADwFGfBpx+CSIPSWfY4uFJsT8JeNrS6g3J3NskwDwEyJEeigw2MbT1EI1mKQxui9UkOTERWmfRHFqvKKzceFcz1FvKJsxeulJPMNziJhfXl4sJEv7YbqbA78Z2OcPoBDAwsAXG431Pf9maaxKZMtxhuc55C8LpF33QV2IgZDLO0+I8R2tlq/88BVZtNwATIAkKuQ6EQ5vhXr3VxfAqNfXgwLA8vnNhnXcTcpRF9JPG+27Dl4wkIiIVGLFBGkHDGn4rzAfsR5Xk2J8MDZQb/1kWEtK0J4vXnC+JnC2FPg==
X-MS-Exchange-CrossTenant-Network-Message-Id: b0c1464a-70c5-49e0-d750-08de8c4df947
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 22:12:45.8077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PcYYmizyy8wNA8SENidmozDq/Y5sUvnE0yk5/uqWqBPzK53BX+z6ynuQtYCkdM/AtP+ivHSqNJnfwAU5gGOJvKEHyKpfjk1Xcnj8B41C22U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7058
X-OriginatorOrg: intel.com

Hi Babu,

On 3/26/26 10:12 AM, Babu Moger wrote:
> Hi Reinette,
> 
> Thanks for the review comments. Will address one by one.
> 
> On 3/24/26 17:51, Reinette Chatre wrote:
>> Hi Babu,
>>
>> On 3/12/26 1:36 PM, Babu Moger wrote:
>>> This series adds support for Privilege-Level Zero Association (PLZA) to the
>>> resctrl subsystem. PLZA is an AMD feature that allows specifying a CLOSID
>>> and/or RMID for execution in kernel mode (privilege level zero), so that
>>> kernel work is not subject to the same resource constrains as the current
>>> user-space task. This avoids kernel operations being aggressively throttled
>>> when a task's memory bandwidth is heavily limited.
>>>
>>> The feature documentation is not yet publicly available, but it is expected
>>> to be released in the next few weeks. In the meantime, a brief description
>>> of the features is provided below.
>>>
>>> Privilege Level Zero Association (PLZA)
>>>
>>> Privilege Level Zero Association (PLZA) allows the hardware to
>>> automatically associate execution in Privilege Level Zero (CPL=0) with a
>>> specific COS (Class of Service) and/or RMID (Resource Monitoring
>>> Identifier). The QoS feature set already has a mechanism to associate
>>> execution on each logical processor with an RMID or COS. PLZA allows the
>>> system to override this per-thread association for a thread that is
>>> executing with CPL=0.
>>> ------------------------------------------------------------------------
>>>
>>> The series introduces the feature in a way that supports the interface in
>>> a generic manner to accomodate MPAM or other vendor specific implimentation.
>>>
>>> Below is the detailed requirements provided by Reinette:
>>> https://lore.kernel.org/lkml/2ab556af-095b-422b-9396-f845c6fd0342@intel.com/
>> Our discussion considered how resctrl could support PLZA in a generic way while
>> also preparing to support MPAM's variants and how PLZA may evolve to have similar
>> capabilities when considering the capabilities of its registers.
>>
>> This does not mean that your work needs to implement everything that was discussed.
>> Instead, this work is expected to just support what PLZA is capable of today but
>> do so in a way that the future enhancements could be added to.
>>
>> This series is quite difficult to follow since it appears to implement a full
>> featured generic interface while PLZA cannot take advantage of it.
>>
>> Could you please simplify this work to focus on just enabling PLZA and only
>> add interfaces needed to do so?
> Sure. Will try. Lets continue the discussion.
>>
>>> Summary:
>>> 1. Kernel-mode/PLZA controls and status should be exposed under the resctrl
>>>     info directory:/sys/fs/resctrl/info/, not as a separate or arch-specific path.
>>>
>>> 2. Add two info files
>>>
>>>   a. kernel_mode
>>>      Purpose: Control how resource allocation and monitoring apply in kernel mode
>>>      (e.g. inherit from task vs global assign).
>>>
>>>      Read: List supported modes and show current one (e.g. with [brackets]).
>>>      Write: Set current mode by name (e.g. inherit_ctrl_and_mon, global_assign_ctrl_assign_mon).
>>>
>>> b. kernel_mode_assignment
>>>
>>>     Purpose: When a “global assign” kernel mode is active, specify which resctrl group
>>>     (CLOSID/RMID) is used for kernel work.
>>>
>>>     Read: Show the assigned group in a path-like form (e.g. //, ctrl1//, ctrl1/mon1/).
>>>     Write: Assign or clear the group used for kernel mode (and optionally clear with an empty write).
>>>
>>> The patches are based on top of commit (v7.0.0-rc3)
>>> 839e91ce3f41b (tip/master) Merge branch into tip/master: 'x86/tdx'
>>> ------------------------------------------------------------------------
>>>
>>> Examples: kernel_mode and kernel_mode_assignment
>>>
>>> All paths below are under /sys/fs/resctrl/ (e.g. info/kernel_mode means
>>> /sys/fs/resctrl/info/kernel_mode). Resctrl must be mounted and the platform
>>> must support the relevant modes (e.g. AMD with PLZA).
>>>
>>> 1) kernel_mode — show and set the current kernel mode
>>>
>>>     Read supported modes and which one is active (current in brackets):
>>>
>>>       $ cat info/kernel_mode
>>>       [inherit_ctrl_and_mon]
>>>       global_assign_ctrl_inherit_mon
>>>       global_assign_ctrl_assign_mon
>>>
>>>     Set the active mode (e.g. use one CLOSID+RMID for all kernel work):
>>>
>>>       $ echo "global_assign_ctrl_assign_mon" > info/kernel_mode
>>>       $ cat info/kernel_mode
>>>       inherit_ctrl_and_mon
>>>       global_assign_ctrl_inherit_mon
>>>       [global_assign_ctrl_assign_mon]
>>>
>>>     Mode meanings:
>>>     - inherit_ctrl_and_mon: kernel uses same CLOSID/RMID as the current task (default).
>>>     - global_assign_ctrl_inherit_mon: one CLOSID for all kernel work; RMID inherited from user.
>>>     - global_assign_ctrl_assign_mon: one resource group (CLOSID+RMID) for all kernel work.
>>>
>>> 2) kernel_mode_assignment — show and set which group is used for kernel work
>>>
>>>     Only relevant when kernel_mode is not "inherit_ctrl_and_mon". Read the
>> To help with future usages please connect visibility of this file with the mode in
>> info/kernel_mode. This helps us to support future modes with other resctrl files, possible
>> within each resource group.
>> Specifically, kernel_mode_assignment is not visible to user space if mode is "inherit_ctrl_and_mon",
>> while it is visible when mode is global_assign_ctrl_inherit_mon or global_assign_ctrl_assign_mon.
> 
> Sure. Will do.
> 
>>
>>>     currently assigned group (path format is "CTRL_MON/MON/"):
>> The format depends on the mode, right? If the mode is "global_assign_ctrl_inherit_mon"
>> then it should only contain a control group, alternatively, if the mode is
>> "global_assign_ctrl_assign_mon" then it contains control and mon group. This gives
>> resctrl future flexibility to change format for future modes.
> 
> This can be done both ways.  Whole purpose of these groups is to get CLOSID and RMID to enable PLZA. User can echo CTRL_MON or MON group to kernel_mode_assignment in any of the modes.  We can decide what needs to be updated in MSR (PQR_PLZA_ASSOC) based on what kernel mode is selected.

The "both ways" are specific to one of the two active modes though.
PLZA only needs the RMID when the mode is "global_assign_ctrl_assign_mon".

Displaying and parsing monitor group when the mode is
"global_assign_ctrl_inherit_mon" creates an inconsistent interface since the mode
only uses a control group. The interface to user space should match the mode otherwise
it becomes confusing.

...


>>>
>>>       Tony suggested using global variables to store the kernel mode
>>>       CLOSID and RMID. However, the kernel mode CLOSID and RMID are
>>>       coming from rdtgroup structure with the new interface. Accessing
>>>       them requires holding the associated lock, which would make the
>>>       context switch path unnecessarily expensive. So, dropped the idea.
>>>       https://lore.kernel.org/lkml/aXuxVSbk1GR2ttzF@agluck-desk3/
>>>       Let me know if there are other ways to optimize this.
>> I do not see why the context switch path needs to be touched at all with this
>> implementation. Since PLZA only supports global assignment does it not mean that resctrl
>> only needs to update PQR_PLZA_ASSOC when user writes to info/kernel_mode and
>> info/kernel_mode_assignment?
> 
> Each thread has an MSR to configure whether to associate privilege level zero execution with a separate COS and/or RMID, and the value of the COS and/or RMID.  PLZA may be enabled or disabled on a per-thread basis. However, the COS and RMID association and configuration must be the same for all threads in the QOS Domain.

Based on previous comment in https://lore.kernel.org/lkml/abb049fa-3a3d-4601-9ae3-61eeb7fd8fcf@amd.com/ 
and this implementation all fields of PQR_PLZA_ASSOC except PQR_PLZA_ASSOC.plza_en must be the
same for all CPUs on the system, not just per QoS domain. Could you please confirm?

> 
> So, PQR_PLZA_ASSOC is a per thread MSR just like PQR_ASSOC.
> 
> Privilege-Level Zero Association (PLZA) allows the user to specify a COS and/or RMID associated with execution in Privilege-Level Zero. When enabled on a HW thread, when that thread enters Privilige-Level Zero, transactions associated with that thread will be associated with the PLZA COS and/or RMID. Otherwise, the HW thread will be associated with the COS and RMID identified by  PQR_ASSOC.
> 
> More below.
> 
>>
>> Consider some of the scenarios:
>>
>> resctrl mount with default state:
>>
>>     # cat info/kernel_mode
>>     [inherit_ctrl_and_mon]
>>     global_assign_ctrl_inherit_mon
>>     global_assign_ctrl_assign_mon
>>     # ls info/kernel_mode_assignment
>>     ls: cannot access 'info/kernel_mode_assignment': No such file or directory
>>
>> enable global_assign_ctrl_assign_mon mode:
>>     # echo "global_assign_ctrl_assign_mon" > info/kernel_mode
>>
>> Expectation here is that when user space sets this mode as above then resctrl would
>> in turn program MSR_IA32_PQR_PLZA_ASSOC on all CPUs to be:
>>     MSR_IA32_PQR_PLZA_ASSOC.rmid=0
>>     MSR_IA32_PQR_PLZA_ASSOC.rmid_en=1
>>     MSR_IA32_PQR_PLZA_ASSOC.closid=0
>>     MSR_IA32_PQR_PLZA_ASSOC.closid_en=1
>>     MSR_IA32_PQR_PLZA_ASSOC.plza_en=1
>>
>> I do not see why it is necessary to maintain any per-CPU or per-task state or needing
>> to touch the context switch code. Since PLZA only supports global could it not
>> just set MSR_IA32_PQR_PLZA_ASSOC on all online CPUs and be done with it?
>> Only caveat is that if a CPU is offline then this setting needs to be stashed
>> so that MSR_IA32_PQR_PLZA_ASSOC can be set when new CPU comes online.
>>
>> The way that rdtgroup_config_kmode() introduced in patch #11 assumes it is dealing
>> with RDT_RESOURCE_L3 and traverses the resource domain list and resource group
>> CPU mask seems unnecessary to me as well as error prone since the system may only
>> have, for example, RDT_RESOURCE_MBA enabled or even just monitoring. Why not just set
>> MSR_IA32_PQR_PLZA_ASSOC on all CPUs and be done?
>>
>> To continue the scenarios ...
>>
>> After user's setting above related files read:
>>     # cat info/kernel_mode
>>     inherit_ctrl_and_mon
>>     global_assign_ctrl_inherit_mon
>>     [global_assign_ctrl_assign_mon]
>>     # cat info/kernel_mode_assignment
>>     //
>>
>> Modify group used by global_assign_ctrl_assign_mon mode:
>>     # echo 'ctrl1/mon1/' > info/kernel_mode_assignment
>>
>> Expectation here is that when user space sets this then resctrl would
>> program MSR_IA32_PQR_PLZA_ASSOC on all CPUs to be:
>>     MSR_IA32_PQR_PLZA_ASSOC.rmid=<rmid of mon1>
>>     MSR_IA32_PQR_PLZA_ASSOC.rmid_en=1
>>     MSR_IA32_PQR_PLZA_ASSOC.closid=<closid of ctrl1>
>>     MSR_IA32_PQR_PLZA_ASSOC.closid_en=1
>>     MSR_IA32_PQR_PLZA_ASSOC.plza_en=1
> 
> 
> This works correctly when PLZA associations are defined by per CPU. For example, lets assume that *ctrl1* is assigned *CLOSID 1*.
> 
> In this scenario, every task in the system running on a any CPU will use the limits associated with *CLOSID 1* whenever it enters Privilege-Level Zero, because the CPU's *PQR_PLZA_ASSOC* register has PLZA enabled and CLOSID is 1.
> 
> Now consider task-based association:
> 
> We have two resctrl groups:
> 
>  * *ctrl1 -> CLOSID 1 -> task1.plza = 1   : *User wants PLZA be enabled
>    for this task.
>  * *ctrl2 -> CLOSID 2 -> task2.plza = 0   : *User wants PLZA
>    disabled for this task.
> 
> Suppose *task1* is first scheduled on *CPU 0*. This behaves as expected: since CPU 0 's *PQR_PLZA_ASSOC* contains *CLOSID 1, plza_en =1*, task1 will use the limits from CLOSID 1 when it enters Privilege-Level Zero.
> 
> However, if *task2* later runs on *CPU 0*, we expect it to use *CLOSID 2* in both user mode and kernel mode, because user has PLZA disabled for this task. But CPU 0 still has *CLOSID 1, **plza_en =1* in its PQR_PLZA_ASSOC register.
> 
> As a result, task2 will incorrectly run with *CLOSID 1* when entering Privilege-Level Zero something we explicitly want to avoid.
> 
> At that point, PLZA must be disabled on CPU 0 to prevent the unintended association. Hope this explanation makes the issue clear.
> 

A couple of points:
- Looks like we still need to come to agreement what is meant by "global" when it
  comes to kernel mode.

  In your description there is a "global" configuration, but the assignment is "per-task".
  To me this sounds like a new and distinct kernel_mode from the "global" modes
  considered so far. This seems to move to the "per_task" mode mentioned in but
  the implementation does not take into account any of the earlier discussions
  surrounding it:
  https://lore.kernel.org/lkml/2ab556af-095b-422b-9396-f845c6fd0342@intel.com/

  We only learned about one use case in https://lore.kernel.org/lkml/CABPqkBSq=cgn-am4qorA_VN0vsbpbfDePSi7gubicpROB1=djw@mail.gmail.com/
  As I understand this use case requires PLZA globally enabled for all tasks. Thus
  I consider task assignment to be "global" when in the "global_*" kernel modes.
  If this is indeed a common use case then supporting only global configuration
  but then requiring user space to manually assign all tasks afterwards sounds
  cumbersome for user space and also detrimental to system performance with all
  the churn to modify all the task_structs involved. The accompanying documentation
  does not mention all this additional user space interactions required by user
  space to use this implementation. 

  I find this implementation difficult and inefficient to use in the one use case
  we know of. I would suggest that resctrl optimizes for the one known use case.

- This implementation ignores discussion on how existing resctrl files should
  not be repurposed.

  This implementation allows user space to set a resource group in
  kernel_mode_assignment with the consequence that this resource group's
  "tasks" file changes behavior. I consider this a break of resctrl interface.
  We did briefly consider per-task configuration/assignment in previous discussion
  and the proposal was for it to use a new file (only when and if needed!).

- Now a user is required to write the task id of every task that participates
  in PLZA. Apart from the churn already mentioned this also breaks existing
  usage since it is no longer possible for new tasks to be added to this
  resource group. This creates an awkward interface where all tasks belonging
  to a resource group inherits the allocations/monitoring for their user space
  work and will get PLZA enabled whether user requested it or not while
  tasks from other resource groups need to be explicitly enabled. This creates
  an inconsistency when it comes to task assignment. The only way to "remove"
  PLZA from such a task would be to assign it to another resource group which
  may not have the user space allocations ... and once this is done the task
  cannot be moved back.
  There is no requirement that CLOSID/RMID should be dedicated to kernel work
  but this implementation does so in an inconsistent way.

- Apart from the same issues as with repurposing of tasks file, why should same
  CPU allocation be used for kernel and user space? 

Reinette
