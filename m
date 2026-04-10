Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B090284B3B;
	Fri, 10 Apr 2026 03:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775792475; cv=fail; b=hyhTHc0NB+E4nv0ubga+mNOBrbNDT9KuWJPbQd/EYj3Y+7foyK7MxjdePgzQyAUrr2CnPmpfmhkEgr7KrE/eUnEuRXGWAat0uD2Vcgq9GLpFbPQWN1POc8m9SAdA5h5RrDT2rX5ulxvJIpfndZOKzP8KfcxCpADaEZcMrOYkMWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775792475; c=relaxed/simple;
	bh=iXNzv3kIWcZJXWgNBOGR1/wQ/PNiP9kNm45F6HCFzzI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fz7O0I8kDvHU2n32kOaIvh5SVXiB+uz7Ais2G0/xoXpNic9br5dK4fRkcEMTzWX5Tl76c+kdnzwL7yPZUtq10/b/yc+cnhmvr8Fg06Zc45WiBsL8s1t7h7Zy7gyl6+PG/Hy4mRIjEwN1ckYHz59vZ7qbaNioywNIPXMSYbyknEM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rs+FFBT/; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rs+FFBT/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775792473; x=1807328473;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iXNzv3kIWcZJXWgNBOGR1/wQ/PNiP9kNm45F6HCFzzI=;
  b=Rs+FFBT/ZJoTXnRj8NCxti1RY7+8WfHTcSiEfXn6QHHx9XlZ8HO5HZ/9
   hJmDwFVRA/UQ9rD4jI42aC1K/nsrb4CNu6r5vJAtkuykgpffBp0oKjOtb
   E1NNN91/VuMdoRmMK+1k/+tD09Wvk1OrushOOnFDHYIYxcc//BRwzRb+d
   1x8Co6Ok6dpVdygMhUlpa75dPGmOdEPfhlSjN4wWcK0n7LdZOgu5wkzEu
   bYTRtyoln/qCEsjpUx9qlf5POJmp/Ul72lNiFu2uw6Je0gTPXOrpyou7p
   X/dO3+m80BnS2o9UfV+eSkL4LSt8NIpWggkkGVirFqfZX1gtKrRolrC2H
   Q==;
X-CSE-ConnectionGUID: gsWkv5wrQ4S8Souny7L0aQ==
X-CSE-MsgGUID: bPXrPHUOT7mGjC8Ich6EUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11754"; a="87509220"
X-IronPort-AV: E=Sophos;i="6.23,170,1770624000"; 
   d="scan'208";a="87509220"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 20:41:12 -0700
X-CSE-ConnectionGUID: uKwt4dcCQkiARMQ7B4qLSg==
X-CSE-MsgGUID: UGXR8iPzTBm9BPIJWv8svg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,170,1770624000"; 
   d="scan'208";a="228134541"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 20:41:11 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 9 Apr 2026 20:41:10 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 9 Apr 2026 20:41:10 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.1) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 9 Apr 2026 20:41:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iGxED7vLz+RFO2Y6f9Co7FidPtrDNPJXsA5NMMa9uOu84MNoeCvGNNAxPqbbeZT2qTVCoSX6RWnpCBi1oVGx9m2ga+YZcH9CTC0OIJMLq5brS1dfjWElj/lKI48q6b8NAxsEZNCYnoHE/ulUKiRT0/RfwbJ2V1ITqUHwU3pfbcQKsPNeZUFyycmNyZm/x/YY0+XCwRmYPM5BMkUEVtF0HEckDLYbKVbW8jjIOqvLy+VstJvVTfZ0JtXhStep2th3lJmsgJ+bhvajPktvltGMRmZHZk0z71cHzDH1DlMC2XeRrt5bQY3hPva8sGhW2oF1ObTUPlIs9b8qI4dTKHswdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GwFG9OLITFUAnsYs8IwBNHlO33eR8/gFKeDWkAcg8gU=;
 b=MDRG5vZT+SEU6HDXOq//ovKCuZDrFDyGcI+cPvvHX2j1ypAhzgnM544RHkG4lSD6BqwaZ/TbRKn4nMF77f6F4bgTPPO8lABOHKFwhxuI+WtVPG852VI4EqoyQKta7l508YkOVfMESUtmGYEHVJbb/yN+J65SA5kh58HZXBCBYJbDjktX7tuFghwqj9LffIkJpeQOhd7QliZhsyQlhjP7ePiJcBu4Ir5qxmK+CTeMUbUD0HhlAgJJPxR1Uvpsrp9LuyspHkFg5zK2zKRt8XS8mBPyokCl3s+GFyH/ODKZ1UiIuI7c6IccqaPB5rJTuAjQ/wdqGS3mG1+ssDujN4BVEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ5PPFEC87B8781.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::85c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Fri, 10 Apr
 2026 03:41:07 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bfe:4ce1:556:4a9d]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bfe:4ce1:556:4a9d%5]) with mapi id 15.20.9769.017; Fri, 10 Apr 2026
 03:41:07 +0000
Message-ID: <68a551ea-d9f0-436a-9bef-e35fd027bb95@intel.com>
Date: Thu, 9 Apr 2026 20:41:03 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/16] fs,x86/resctrl: Add kernel-mode (e.g., PLZA)
 support to the resctrl subsystem
To: "Moger, Babu" <bmoger@amd.com>, Babu Moger <babu.moger@amd.com>,
	"corbet@lwn.net" <corbet@lwn.net>, "tony.luck@intel.com"
	<tony.luck@intel.com>, "Dave.Martin@arm.com" <Dave.Martin@arm.com>,
	"james.morse@arm.com" <james.morse@arm.com>, "tglx@kernel.org"
	<tglx@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de"
	<bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC: "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>, "x86@kernel.org"
	<x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "peterz@infradead.org"
	<peterz@infradead.org>, "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
	"vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
	"dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>, "rostedt@goodmis.org"
	<rostedt@goodmis.org>, "bsegall@google.com" <bsegall@google.com>,
	"mgorman@suse.de" <mgorman@suse.de>, "vschneid@redhat.com"
	<vschneid@redhat.com>, "kas@kernel.org" <kas@kernel.org>,
	"rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "pmladek@suse.com"
	<pmladek@suse.com>, "rdunlap@infradead.org" <rdunlap@infradead.org>,
	"dapeng1.mi@linux.intel.com" <dapeng1.mi@linux.intel.com>, "kees@kernel.org"
	<kees@kernel.org>, "elver@google.com" <elver@google.com>,
	"paulmck@kernel.org" <paulmck@kernel.org>, "lirongqing@baidu.com"
	<lirongqing@baidu.com>, "safinaskar@gmail.com" <safinaskar@gmail.com>,
	"fvdl@google.com" <fvdl@google.com>, "seanjc@google.com" <seanjc@google.com>,
	"pawan.kumar.gupta@linux.intel.com" <pawan.kumar.gupta@linux.intel.com>,
	"xin@zytor.com" <xin@zytor.com>, "tiala@microsoft.com" <tiala@microsoft.com>,
	"chang.seok.bae@intel.com" <chang.seok.bae@intel.com>, "Lendacky, Thomas"
	<Thomas.Lendacky@amd.com>, "elena.reshetova@intel.com"
	<elena.reshetova@intel.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"eranian@google.com" <eranian@google.com>, "peternewman@google.com"
	<peternewman@google.com>
References: <cover.1773347820.git.babu.moger@amd.com>
 <14a8ad0a-e842-4268-871a-0762f1169e03@intel.com>
 <47c0db32-d0e0-4c53-90bd-b74863d233dc@amd.com>
 <88eebfac-5286-4788-b244-911c659c0439@intel.com>
 <30deeb5b-d2ec-4f85-aa4f-c21400df3486@amd.com>
 <83ae0c18-5c5e-4b52-901d-4126fe7c141b@intel.com>
 <5a740f47-d3f3-45af-9d8c-ebcf3dd89c0d@amd.com>
 <3305c18e-9e50-4df0-b9f1-c61028628967@intel.com>
 <c6f574b7-fe5f-49ae-9865-0e4dbb2f9803@amd.com>
 <efc269f8-bf98-4f12-8d76-1fee564be84c@intel.com>
 <0ae2b267-4527-4251-9136-6afdc3fc97a5@amd.com>
 <72297351-2954-4318-81b6-7de409e5552c@intel.com>
 <20aaacfb-9601-4343-a5d5-f3df6152155b@amd.com>
 <43880b7b-b390-4e7f-8c2a-46cde9e3b051@intel.com>
 <bb9f62f1-0c79-4d29-9866-c39d08c3a774@amd.com>
 <5a273b0f-8225-4e9e-924e-884183734659@intel.com>
 <73c46024-4cf2-4f03-9268-d4378825fa87@amd.com>
 <973067bf-6e6c-446a-a81a-713840d701a9@intel.com>
 <90f4a692-1c27-4967-bf12-ec3cb597681d@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <90f4a692-1c27-4967-bf12-ec3cb597681d@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0098.namprd04.prod.outlook.com
 (2603:10b6:303:83::13) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ5PPFEC87B8781:EE_
X-MS-Office365-Filtering-Correlation-Id: fb3ac5be-d23d-4b2a-864f-08de96b2ffaa
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|18002099003|22082099003|921020|56012099003;
X-Microsoft-Antispam-Message-Info: ystmgdHHw7WaGY0O2KI0ycraK2skkPe0/5sATJVvdSeYyKdiUMxv5+j8qiyF3i5ofeNplruqekHqmOe1Z3Ows6Ry75IbFsDwS8WEdRUOEyEiRjNjFmtm2x3+eIo/lrlB9CNO9ebpZO0CMJZjXfJJHMj0WPGwxfoYxFRrJ+sqzQ/0ahBUNFSDHTTXrNV595LppaJ16Ve5MN4/1KMH2OXDgU6cISqBOxRdePIheDko507VydNY4tSuG/o4YNURkX3LRXUKp20iyr+3XEgJXwsUXeKuzovtNPneI48Gcn/Z8GK1oY2hAyUoRGpJ5p+s7zIbzcXXLvMTw31VSz56VCgvm2v18DM7LP7+r3Ps7eC/uDs3+Ubvcw1F8bpqrT+LoeQP/q87VBFUJijePIY4uxZs9XA2WiB1AywAqYybD0lhdvVSXSCOikBNCdQM4dmeNyW4yld+wr1NDz/3GkB8Fm9S0hDlm4D22qVNN2JwlzHxl9VuvR6KNhWat8jd7j2yWuTzFFEROaNBDGiIHNWjsy81XNE6kKnJvNyYHuapGzkP9PNuNzJF13U4cMK0+F0DtwleWwyUv8IFN/YrUppCEFzS1nYrdKhA4Dh2VutI/J3pqzZAgGgBO3yhcD6CrC7EFYkFRli+j6QMX4mjD0sVoE6Jtx2296/C/3142zQzAuxCg2qvWLvAOy7SWW3lOhvj7a/r5xd40g1gEBOALfqPXGZUOLYWK3zsyEUtMahoeBXJyHvDF9IM3icyN0UX4gXtN7TCs+QUqkUkHkpciQNxxMaMsA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(18002099003)(22082099003)(921020)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXVFNlg2dGYvV2trVVhzUkRlV2M5ZnVvSUs2VVRPR3dnNE9CQkEzUUF0cjVS?=
 =?utf-8?B?NkVVWHRnOFYzbm4wa0Rwc1ovQ3RoSGdkYUQ2RDgrY1dpU3NHZ2taQU5HczhU?=
 =?utf-8?B?WDV5VzdVVG1DM3BoMXZTMmpsUXBpZ25IbTJXekhSNHM0aEU0RlR4QUhjVWRq?=
 =?utf-8?B?WFE1eFAxM0tSY2xvNi95aXZtQkJVL2p4SVNTMXBBY3dsYU94R2gvRkMrSldC?=
 =?utf-8?B?ZnNQZ2lWa09neWFBL0ZjcnF2ZWU3WXVWb1MrR0Y0dlpVVUQ4VU9JeWM3NVhI?=
 =?utf-8?B?eHQxQWNVenRHNkxiVjN6UmE2K2FIMVdpRjNLMkJGd1h2Zk5rQUZxSktWVnNU?=
 =?utf-8?B?S0htSGtUekhoWmtkc25MNnNLajJlQkxtL2lSeEw1d2RUVVZqOEc0NGNxT2tB?=
 =?utf-8?B?WXUvL29TWmY0ZGFpMnNTVVlwamJyNGZvUEF0MUhQNzFXYzZlWVI0MTRsY2Jl?=
 =?utf-8?B?QTk3S0xsbGtUTFh3WEh6SDk0Z1RMajJoNzFMZDVZUDAvNXhBMTg1eE1OVkE0?=
 =?utf-8?B?S3l5Z3J5QkVmUGk0WWlLNUJubXJjZnA5NkFyV1JvSnVBZi9Pam9xbndHZGxv?=
 =?utf-8?B?cU9zRWdhNGM0bDhYMEp4MFlPaGNBOXUxdDhnWTlxUkFrRXRBZDNiMTY1N2JB?=
 =?utf-8?B?TGd2dUtheit0V204aERjaDdDdGM2QytQbmUvdUdSWFp0eUkxaEJFa1d0dkE4?=
 =?utf-8?B?aFZSS3crVnNiNXY0ZDJoSVFjU3RrUTNEWTdHYlRzOHgzNzFiZlcyODIwdzkx?=
 =?utf-8?B?ck9XTGdWSVdKYWNOUHB4V0dQQmJXM0liRzVyODF6ZFR0dDMyQWdISVBiVC9m?=
 =?utf-8?B?K0pDWmszZmFSOGEvNmpmcjFJYlpZZUUwUUVHSkRIcmVQaU9PWTFURUFaSFhL?=
 =?utf-8?B?QzNFbVc4TU9mMVc4Ni9GVjMxZ2R1aDlUbW1BeC9FeGpQU0NGSExLcm9JMG1W?=
 =?utf-8?B?QWpUaU9YekZ6R2NMSk52anN4amx6TU1ZNE12YmdFbXRRaU5QMm5hMkhwcEhs?=
 =?utf-8?B?azhud2sxYlYzam5qSjdLZ3lmZ2d6S1pwSmdsOHB2MllFSUVWOC9EVStyTnFj?=
 =?utf-8?B?dGZhN3BTa1dPWTcxazQ1K25Db0djWktRdU56Y0N4R1ZYeGxWSW1wOEJWemtH?=
 =?utf-8?B?LytDQklBYTFwRWgwQTU0cExoUHdZZmJnbGl3bFlDQ2JEYWJFU0xhb2ZKL25N?=
 =?utf-8?B?eGlIMC82NWFMRmh2eVhNYXdWaU9CTW5qMEZMTXI5WDI4elRLSnZ2SGlGU1VM?=
 =?utf-8?B?TTlqOWo1clNhenMzaEprYStjcUNubmZDMGxIc1ZjR2tVRU0xMGpaa25uT1dY?=
 =?utf-8?B?L2pxZ1NZNFJQdUhHNHdYN2hGdjRBaHYweTJpMSsvM0laRklZN2FaNjlkZFc3?=
 =?utf-8?B?b0hpeUpiZmNLajF5RkhBSUVyY3lRZlZHUllzc1pNNStEVmVIdGt1YTJuZDR4?=
 =?utf-8?B?OHRpVVoyM245NjBSbXpEVW4vY2NTUWNyVytMRDkzOVpnYVRrTmJxQXQ5SUhr?=
 =?utf-8?B?Sko2VCtsZTMwQXVpRlg3Z2hnak9ZV25raUZrWUc1SVZIRDdnTTdLN3JEL1Yw?=
 =?utf-8?B?M2JJYUUrai8xUm1FbmVBc2xrakJ1ZWgva3h5aHRtRzFGZVpUYjBoaTZLRlgr?=
 =?utf-8?B?dWwvR1RqVHRiR2tYeW8xU3Fydy9sekV4OHFkR1BNVjV1ME1NQ1AxY0VBQWNL?=
 =?utf-8?B?SG9DM2tZVmVRbjB2MWJNOVBqOGdWdFp4S1VNc0w0ZFRwSC9hNEd3dnN2WU9G?=
 =?utf-8?B?Ym9lcDFWWTJUK3BUUlVTNkcvWEZLbmh4TERhWmFheHJmNmFFNTc3SWtHVEhq?=
 =?utf-8?B?Wm1VWGN3emxBS2NWUWN2MFI2cWdmUU1QaGgwWCt2QzFXOU96dXAxZm45R3lz?=
 =?utf-8?B?NGVoUEt2YlI1OHBwMnRRUEY0RHZnZEZEbytpQU1EQ2pxU2hKOHpSei94WDh4?=
 =?utf-8?B?c0UydDBBa1dTcktrRzMvMkowUlF2N25JODVQS1I0b2pDMWIzVlpjK09lT1dZ?=
 =?utf-8?B?VVlJSXRIVS9hOWpyMG9QTWtMbDQvd1NCRmRjMXVuclkwcFhnUDNzdjZPMS8x?=
 =?utf-8?B?S0NDRzZ4M2N2d0RyTy9ob1dNUGQ1Z3lIaHVrc0xoTlBsaGFXNG5HWForTi9t?=
 =?utf-8?B?WE5Jc2VmTCtPSXkrUlFpRTJLdmlNbHJVSk1LY3ZzK09LekM0N0t1UXpBWFhj?=
 =?utf-8?B?bm1JODFrUi85aHEya1VTMVV6VGowb2lVWnFDMjhvdTNkczNlckNWY3M3S2NX?=
 =?utf-8?B?MWxQWUtxc2VFc25oSHNvbUtjeW1mVW02SnRFS3E1eS9wYzVIaCt2MmpoTDdM?=
 =?utf-8?B?elIrZlNqQmdIUlVBQkV2NTUwZEtodkRSelE3Y2NYRElGaHowQmZPZ3Yza0RD?=
 =?utf-8?Q?cN6WdYr4aLPKLnJw=3D?=
X-Exchange-RoutingPolicyChecked: nh6faDR4SL7Nbums8LFJIgguKXjVEOJpG4Ba1r9/DEBYiDURsy3tj1tPXopHNcKFfKoF4wLqWk1QxJmdfIPSXDH4mYP1KZ0Pyk8u+0lEr4fDsDZ8hb/RtVMQkcrkqQLB373rNK2VfCryCdUWnwYZ2U1Y60YpEv/T4laeVRXpfAe2rlnTd1d5HleGgR1wy0WX7L49bf5ob2ZpyyLygjzcmgaW+eD4WDh5mxb4m9W4hLwf+c2AC5im8o/lGfW/0Ep9YaJcViImKZ9L9u29YuQIjVYxcXeikzOiKZD4POgXEKkrT734fn3QtnHX2b1fMCNpJLJBygRynB/ZmiSWXsRi2g==
X-MS-Exchange-CrossTenant-Network-Message-Id: fb3ac5be-d23d-4b2a-864f-08de96b2ffaa
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 03:41:07.2947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pCIQ5/5aTVIHLvAnimi9PsGuACDeP3QgVaYLoN1wEkDqUftEbKboHt2Ag9WVG5a97DWsrRjQfQggoRoRJXmshvp0BZkuZDfMylJ1PTFF5Mo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFEC87B8781
X-OriginatorOrg: intel.com

Hi Babu,

On 4/9/26 4:42 PM, Moger, Babu wrote:
> Hi Reinette,
> 
> On 4/9/2026 3:50 PM, Reinette Chatre wrote:
>> Hi Babu,
>>
>> On 4/9/26 11:05 AM, Moger, Babu wrote:
>>> On 4/9/2026 12:26 PM, Reinette Chatre wrote:
>>>> On 4/9/26 10:19 AM, Moger, Babu wrote:
>>>>> On 4/8/2026 6:41 PM, Reinette Chatre wrote:
>>>>
>>>>>> When the user switches to either "global_assign_ctrl_inherit_mon_per_cpu" or
>>>>>> 'global_assign_ctrl_assign_mon_per_cpu" then "info/kernel_mode_assignment" is created
>>>>>> (or made visible to user space) and is expected to point to default group.
>>>>>> User can change the group using "info/kernel_mode_assignment" at this point.
>>>>>>
>>>>>> If the current scenario is below ...
>>>>>>       # cat info/kernel_mode
>>>>>>       [global_assign_ctrl_inherit_mon_per_cpu]
>>>>>>       inherit_ctrl_and_mon
>>>>>>       global_assign_ctrl_assign_mon_per_cpu
>>>>>>
>>>>>> ... then "info/kernel_mode_assignment" will exist but what it should contain if
>>>>>> user switches mode at this point may be up for discussion.
>>>>>>
>>>>>> option 1)
>>>>>> When user switches mode to "global_assign_ctrl_assign_mon_per_cpu" then
>>>>>> the resource group in "info/kernel_mode_assignment" is reset to the
>>>>>> default group and all CPUs PLZA state reset to match. The kernel_mode_cpus
>>>>>> and kernel_mode_cpuslist files become visible in default resource group
>>>>>> and they contain "all online CPUs".
>>>>>>
>>>>>> option 2)
>>>>>> When user switches mode to "global_assign_ctrl_assign_mon_per_cpu" then
>>>>>> the resource group in "info/kernel_mode_assignment" is kept and all
>>>>>> CPUs PLZA state set to match it while also keeping the current
>>>>>> values of that resource group's kernel_mode_cpus and kernel_mode_cpuslist
>>>>>> files.
>>>>>>
>>>>>> I am leaning towards "option 1" to keep it consistent with a switch from
>>>>>> "inherit_ctrl_and_mon" and being deterministic about how a mode is started with
>>>>>
>>>>> Yes. The "option 1" seems appropriate.
>>>>>
>>>>>> a clean slate. What are your thoughts? What would be use case where a user would
>>>>>> want to switch between "global_assign_ctrl_inherit_mon_per_cpu" and
>>>>>> "global_assign_ctrl_assign_mon_per_cpu" to just switch rmid_en on and off?
>>>>>
>>>>>
>>>>> This is a bit tricky.
>>>>>
>>>>> Currently, our requirement is to have a CTRL_MON group for
>>>>> global_assign_ctrl_inherit_mon_per_cpu. In this scenario, we use the
>>>>> group’s CLOSID for PLZA configuration, and RMID is not used (rmid_en
>>>>> = 0) when setting up PLZA.
>>>>>
>>>>> Our requirement is also to have a CTRL_MON/MON group for
>>>>> global_assign_ctrl_assign_mon_per_cpu. In this case as well, the
>>>>> group’s CLOSID and RMID (rmid_en = 1)  both are used configure PLZA.
>>>>
>>>> ah, right. Good catch.
>>>>
>>>>>
>>>>> Actually, we should not allow these changes from
>>>>> global_assign_ctrl_inherit_mon_per_cpu  to
>>>>> global_assign_ctrl_assign_mon_per_cpu or visa versa.
>>>>
>>>> resctrl could allow it but as part of the switch it resets the "kernel mode group" to
>>>> be the default group every time? This would be the "option 1" above.
>>>
>>> Other options.
>>>
>>> Allow global_assign_ctrl_inherit_mon_per_cpu -> global_assign_ctrl_assign_mon_per_cpu. As part of the switch, reset the "kernel mode group" to the default group.
>>>
>>> Allow global_assign_ctrl_assign_mon_per_cpu -> global_assign_ctrl_inherit_mon_per_cpu. In this case switch
>>> to CTRL_MON/MON -> CTRL_MON.
>>>
>>
>> ok. Could you please return the courtesy of providing feedback on the
>> suggestion you are responding to and also include the motivation why your
>> suggestion is the better option?
> 
> Yea. Sure.
> 
> We need to allow the switch between the modes. Otherwise only way to reset is to remount the resctrl filesystem. That is not a good option.
> 
> Allow global_assign_ctrl_inherit_mon_per_cpu -> global_assign_ctrl_assign_mon_per_cpu. As part of the switch, reset the "kernel mode group" to the default group.
> 
> This option is same as you suggested.
> 
> Allow global_assign_ctrl_assign_mon_per_cpu -> global_assign_ctrl_inherit_mon_per_cpu. In this case switch
> to CTRL_MON/MON -> CTRL_MON. This option basically disables monitor (rmid_en=0). It is less disruptive. Move is between child group to parent group.

ok. I am concerned that this creates an inconsistent interface. Specifically, sometimes
when switching the mode the kernel group will reset and sometimes it won't. This inconsistency
may be more apparent when writing the user documentation as part of this work. If you are
able to clearly explain how this resctrl fs interface behaves (this cannot be about PLZA
internals as above) then this could work.

Reinette

