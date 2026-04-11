Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F29C155C87;
	Sat, 11 Apr 2026 00:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775866417; cv=fail; b=Tsp98PDFS11C6YJmawMGC0cU9vjVdUdPzO0ZBQyhs7LQFXJ+EXrWRY68EEyjRCbvs3JvReqhIoac6qyYsc1+hLB1qZ2YF9+9PIMbrI98LdJAxUTs3LSfQ1PPj1cmWhyYNygjZ4OvgqFIYoc8HPIDBPCgG3ih86fN682XqgKieDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775866417; c=relaxed/simple;
	bh=qzDTS1OBxqmUL4qc5CVeeWsg6XlooTzaMT4wK9ef8Bw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Fc5cQIpOxw4aWrVyc/QxsINJycZuWjQ+NzEvhnpMtAwjtaFW8lM/nQ0Av+4Q8OZEOyDFmeNvX+FkcPUYLhtFT25vaFQWl+1gZ3M9DuDFoPSE3cADl7+uAxxYdSoTMkMrmTJlCUs75fI1wOcN19V6P+kOXaGuOmuxkbK1VDS8Pfw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a+3ov7QE; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a+3ov7QE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775866416; x=1807402416;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=qzDTS1OBxqmUL4qc5CVeeWsg6XlooTzaMT4wK9ef8Bw=;
  b=a+3ov7QEUzqNzyEwuIEK9EX12boFM/TdBC0oAOhdCJ/J+R5F+iXxfNPs
   LttAqrgRp1Dvkh6pGalhC4TODyycpvAj76uie7vj9iVQapIcys2XLgOoF
   DN+RoOPjo+63Q8OZiQEHvSeXjxHX6jE0VyzoQdzfw7/d5pfPee88bf4R5
   5QO72C/YMbdjwL1v7XPkT60ZUDhPrjo9yjlC6rYDPDOyPfeOyKQfDlzVX
   v96fWWLgiQXsj+gd/AwF7deWV3oavNMPvxMTXivguDlmeJYlqOc7sOOKZ
   pWg7/Eac8OAF7kJOHHKaPp4ATM8PCdEVuKpudsXxvl1M9QZzx/sgNxDdh
   A==;
X-CSE-ConnectionGUID: Y+nlW3eNTMOo0gohPK0ZUw==
X-CSE-MsgGUID: 2XJvAiv0SFOZipOUJlCxpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11755"; a="88335292"
X-IronPort-AV: E=Sophos;i="6.23,172,1770624000"; 
   d="scan'208";a="88335292"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 17:13:35 -0700
X-CSE-ConnectionGUID: D0zjRoGXRDK8wuvZrt3vrQ==
X-CSE-MsgGUID: lwZHHe1oRRyNZBVdhnt1kA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,172,1770624000"; 
   d="scan'208";a="252619054"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 17:13:34 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 10 Apr 2026 17:13:33 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 10 Apr 2026 17:13:33 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.25) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 10 Apr 2026 17:13:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bo7BkQXBPd2isoJP9WkilTDOkj2lBp83L3YK9329cSd2ctTFCiXu8if/ZZaRFco6Te5UdrNSrjx3BOpLfNiJd63SdmxLSqESqvKM+McYhcF6v2yw3aC7kZSuMDFq7UwObEqpMLKs3Ql0mAcOKs0L0qTH6KzYVzGy94STkzfyxaTc5oJY7hnYmDPvyoxlVfWSLRTbSAkFih+40CxlZGqGGe+UH2L2E6URv4i7AeVPBp06DgYlmfZAZYYxMfM9FSgfZL59x3TlIAkFUU1ERdSq/KW30eZa4KS3LchzzP3TNLGk7k4br6twpvPWWWfrC7srPXzhKY3f6oYCuxYwPmOP9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qzDTS1OBxqmUL4qc5CVeeWsg6XlooTzaMT4wK9ef8Bw=;
 b=RlXMZdWDQT4sbxW7VhTHq4VpUETNmhZ57tNp0LU+GdZQKPGwSqPW8jjqEye2zqq6JavC5HeuJsg2SUz9xmqmZsHu8euc2kswxTXNo143U1jjNjJ/vasHTfBtdMALX2XK8Bb+7yyCMOy6WXYAZ7L6JElzop+doDeYerUb2kJcYn7nc6MWEYs0fT06uYfFC8m3N7LXRTIOQkxqnZ9PRYYrPC5AkyTepDc/+xriLBhtS2CnDgixu3EwXPa8rPU81W/Y6fxNbhQHKMxpeqxKZ5CNelT9Kqe9Lx89xG0RSJKONgLoRHZoJ7Nyad9td2vUTBwviUPR+G5HrksWAEmkKepKNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by PH7PR11MB6953.namprd11.prod.outlook.com (2603:10b6:510:204::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Sat, 11 Apr
 2026 00:13:22 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65%6]) with mapi id 15.20.9818.014; Sat, 11 Apr 2026
 00:13:22 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Gao, Chao" <chao.gao@intel.com>
CC: "Li, Xiaoyao" <xiaoyao.li@intel.com>, "Huang, Kai" <kai.huang@intel.com>,
	"Zhao, Yan Y" <yan.y.zhao@intel.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "kas@kernel.org" <kas@kernel.org>,
	"seanjc@google.com" <seanjc@google.com>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"Chatre, Reinette" <reinette.chatre@intel.com>, "Verma, Vishal L"
	<vishal.l.verma@intel.com>, "nik.borisov@suse.com" <nik.borisov@suse.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "Weiny, Ira" <ira.weiny@intel.com>,
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>, "Annapurve,
 Vishal" <vannapurve@google.com>, "sagis@google.com" <sagis@google.com>,
	"hpa@zytor.com" <hpa@zytor.com>, "tglx@kernel.org" <tglx@kernel.org>,
	"paulmck@kernel.org" <paulmck@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
	"yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>, "x86@kernel.org"
	<x86@kernel.org>
Subject: Re: [PATCH v7 05/22] x86/virt/seamldr: Add a helper to retrieve
 P-SEAMLDR information
Thread-Topic: [PATCH v7 05/22] x86/virt/seamldr: Add a helper to retrieve
 P-SEAMLDR information
Thread-Index: AQHcwQv+uYYg8sfBHEuMsgAzr14bObXZDekA
Date: Sat, 11 Apr 2026 00:13:21 +0000
Message-ID: <8b1c22eac39e1486fcf72002d53558f918959af4.camel@intel.com>
References: <20260331124214.117808-1-chao.gao@intel.com>
	 <20260331124214.117808-6-chao.gao@intel.com>
In-Reply-To: <20260331124214.117808-6-chao.gao@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|PH7PR11MB6953:EE_
x-ms-office365-filtering-correlation-id: 388c6c56-0262-4083-5bb7-08de975f244e
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|22082099003|56012099003|18002099003|38070700021;
x-microsoft-antispam-message-info: Qtt8jHXgAyD1BD3P/rF30Z3gDeuRMVy6Xpjlva3w1+Ec/ztDigQfowppKPJxNO8tMdBfeoqCtFkUtjGftNUyQ4X79YciIro9LFpiDdqIGcghcnWMlxBSAypN5wtrZcUvvnDSdWyK5vOOccHnYiiz7r22I+lIUxh3Zzku1BB/SgiXF8elNUCqgIiw/NRTT/N34W2CBRlE6bX2x7bGiI2tf/DxSX9+kKBuDiTpV4RB7dgIz/HaN1mo3PnKop6+8Bsx1/pov7x+Y0ZI0SqW81zntkqJOzuzniG7QDADdoPbi/8wsulJgQHK+OVyiFEOd3r20yS3xkhvVl0mo7O6DC2IW/pgzSQH8D+Ae8SnmNgo7DuINiY6InuEMJQ1VARlSGpp0oe13LfZZaOzBV9C8em7USGBXDclXmOgKnkXI9mZ9wItjvdl3YH870N1Jyyx4DwlxrQb6e6PLG8vOLaDHLpbXyhocNcezj+So2OKWTc2LMVSt2zrBdWGn0V9YCtBEF1o4hF1dyrcA+twDFezwmJ36EPNztZ5yL017NYvdAXCeGSh8L2y60RLfYPzpsdVmAVrfMQZkJNmLQkK3+nmfWEJFCZyS2Y8hnO/xFSae0SCZQYg0Ciutvry7wieeNDwV+fr0G/u38ezsLxDHoAilIXnCZZyE7t9Wv1gKHcUH6bYrwmDZE0jeghdVaBheXcH5+cxQUlXQ6ajFsmnC433bSTk/A5dNjBx/aygp8Oj9FiHT08RwJGRpgSo9rwoBB67BZxRdu7jzYFI5IPfb84QTEoAdpu2iaMYX+lp2q2LxWsSCUo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(22082099003)(56012099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a3BiZ0NESjRwMDdORFd2cEVoY1lITFJzK2k0M0d6NWVPS1Z5WUdXaXYvUDdH?=
 =?utf-8?B?NXNyTU5YRm5QTEx5UlBhT3JnWkl6ejZrd25odjlENHYvWURpcWtuQWFNeFBT?=
 =?utf-8?B?U0h6bjRwN0o5TFlqQ0xmYzIzUm5yNHhhT3FaQUFhd3JhNVdlMllvRHZIdDFz?=
 =?utf-8?B?Z0JNTmhGRWI4RUcvQUhYTXVDeXR1S2JJWWd4TGpqRXhCbm8yU1VsN3VSTnkz?=
 =?utf-8?B?bHRVd0t5WDdhSGNRR0FkMWdkNG9va1ZpMnM3WHArMVVNSHRuNyt5THlDUzBI?=
 =?utf-8?B?YUxLeWU3YXpGd3VNZzhxQjJBdjZiNEUweUhrUlBPTUQzamw0S3QrbitCM2o3?=
 =?utf-8?B?amRSQmdjWCt3alU4cUVqTUVwMDJLZWsxOG9zWnNaZWY4azB3Z0lTTmk1SlpN?=
 =?utf-8?B?cTVzYjBCd0F1RHhOYmFWUzJsM2tNckxpc24zVjVRQ2tOR0VPTE94cXUvKy9N?=
 =?utf-8?B?RUlaM3Y2bi9zRWxmMFYxNmtCeFpIcUkvbEFLYTgwL3h5NXZSZGo5WTM1TlZW?=
 =?utf-8?B?UFJNNW1LWWx4UWZWL0Y3bzU2elR6Tk5wSWR3Z01PV0tPV3VRQmo2SU9NZ0hR?=
 =?utf-8?B?MVNyNjE5b3ZsWjVoSlA3ZWwvcjhGd1Z0YWJUb3NINjNXaVg5dnM4VUZwOVJy?=
 =?utf-8?B?WjE2QzJVU0c5cTdUS0Y3Q3VSejBHdmhzNjEzSnVYQTVUY08xaDNLN3dETWJF?=
 =?utf-8?B?NHhpSGY1YVNOcllqUnJWMnByVFR3ZHZ2eWJMc0xMQ1ZsK0VXajZhOVNrd2lN?=
 =?utf-8?B?T3NkRUpWdmxhMTArNnRQaVhMQ3pPYlVCMGowcVRCMGxCclRXdGZWdUtKcXZE?=
 =?utf-8?B?VXh2SmlrZmxYSkF0UVdYWFhCQllmVUlnTGppZnh2V2NQQkhPVTRPU2tMQ2xw?=
 =?utf-8?B?T3lHb3NVZ1pBWnNBMjd6S2ZpR1NyOVk0U1ZicXBYUXIrWCtKK1hocDRRR0ZJ?=
 =?utf-8?B?bXBVY0ZLRjd4VGZJZkNLbzg1UlhPVldpNXpsKy96UlZmSjBING5xZk9PSGJq?=
 =?utf-8?B?U1UzMjZVT2FrbUlRaGgxUVM5K2w3aGV1OTlyak9xamx3R1NWSHNwbHNXWDJL?=
 =?utf-8?B?VSsrYXY0UVpuMDRwbmgxNjFvMXVmRk0rM1lyVG45Nk1ra1ZtRFhEYmxmOFNu?=
 =?utf-8?B?UUdPcWVhUnlxVjI1Y1FtZ3IxTjBXZWtYQ05YQzJGbm9oWmFJZ2c0d1pKUlRD?=
 =?utf-8?B?bXB6RHMrMytYaVBBV2MwMFR5TWY4Y2lqWGZ5UERMK0lPZktBb3J0QzNmZmIx?=
 =?utf-8?B?ekYrT3lJejgwM3JjaUpoaFNGMDJHak5Kb2xnZWZ5UkdRaVcwOWpNcjkwVGVO?=
 =?utf-8?B?R3VoanFEVUhZK3F3QzhycHAyY1VHQWFNaTRnaEw1NFlZWm8wcXZrWEh5aWJl?=
 =?utf-8?B?dGc5Z2ZReGZnWi9EUHVLUXJMc2FPTmFkZEp0SUJ0VEhUNEN5Z3ZzanVmNHZZ?=
 =?utf-8?B?WUtIenVZOE9lTEd0cXBJeXpVQmFXWTNRZmJkVXRRbWpNamZWa3gxLzNGb25u?=
 =?utf-8?B?c3RRVDF5bDR1NXpxd0RDWDZHOWFrMGl0bThqaC9Da0RzYTVTVWt3cFNzSGk0?=
 =?utf-8?B?SVd3RkZzUElEcE9RRnZ3QUZaYTI3QlZwckVJSkI3THBsRG5UL3NDTjR0QmQv?=
 =?utf-8?B?SHlBNWo0QTFic2pQL2JiMG1oYlJYS3dHbGRBQUw3REMxVUpOVTNpVjVsWk5q?=
 =?utf-8?B?QStjb2d4S2Y0VGhZV3E5M254TFlheVBTZ09zZ2VFU1JtSTF3d2JZc3ZoUEx4?=
 =?utf-8?B?ZnllbjdqVURyOE9LbXlEL2lzenMvMWVRcVVyZTFMRWgyczcvcjkwVk9ZZXg0?=
 =?utf-8?B?b0FhLzgydWUvRU41MTY4QmpXZVJQekVDNUZSWEtZSEpJMFdORDd5dGpUK21l?=
 =?utf-8?B?NmhGcEpzVlNCQW5weEtpUldGa0NyS3VHS1NjRFk1bUZYcTBoUFVkRkZ3amRq?=
 =?utf-8?B?T1pxUTU0bnI2cnBvVW4zd1pVNXJ5bmNtR2gzdm8yc0d5THhMTFV5QjJJcXpQ?=
 =?utf-8?B?M3JoUitGU1pTcUhZdVBGT2JUd08vYzg0YUhvN0RISkFOVUIyVUU5dy8zckwr?=
 =?utf-8?B?QWhFbFpMaFVjWDV6bldNRUVhcU9iUE5va3UyYXFIUlpCeWxSMHZUSlV4aFhU?=
 =?utf-8?B?S2F2N2FQQmpKQzBtM0lIYVpaTnNpa2RSVUtDZ0VKdE92bmo5SjVqUEEyRit3?=
 =?utf-8?B?NzEvd1BGU1g3Y0xGY1MxdFNTYnI2V0J0QjhBZTlpRmxya0MwRWRjK3ZzdUJQ?=
 =?utf-8?B?WStHWGIvWXlUR0FUR2VaY1VRWkptWmVPTGlLaSs0dWJaNDJjd2J4QkVCZFp0?=
 =?utf-8?B?ZlRrTTJjaVp3a1BJNjFHWDF0TklzTTZFU3Izb2JLUkVOUER5Sm1UYWIwNjcy?=
 =?utf-8?Q?RWe18qcW1r6S24NE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0E6765637686BD43AC1EAB2663F4DFAE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: aOufkvRx5WjjGICUfb6GcVb8Eblkxu4KdnOohasuimszaFwIuY5AuaDo/b6EcbigvTtr/OUUrHxohvFMlgXelazPhhCYylhqnGRrMYl6gjtjFbJE4WpckFYuciDQ7on0MG/yq1/YG08NfB8dxmHiPdoi29i7C5knkyp//G0tBci0IohjAn3XNmHxsqRFXv75OXEOyz/hpENsq8agAJBa1fu4Oj3REK7ujtIZUgZ675PSZRzhajdQk7Ta201FqgwoF8UvsMuDv9XSy+2N6RQNcxNXLKbseGFWUPAGkvMxuIj6ZLATbvuBlEEUz8XgvqfANkDGSFwwN+XqVcyEHk2SAg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 388c6c56-0262-4083-5bb7-08de975f244e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2026 00:13:21.9426
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nEdtF7xmZWUbWtKLGqhQenSSYS4wL7TiVj40UTsV/D7y2Q7ymp4iXBficMy/ase3carlPGVPVQfBoUHvtvbwI9i5habGvXS2AbEm9/zpyJE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6953
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTAzLTMxIGF0IDA1OjQxIC0wNzAwLCBDaGFvIEdhbyB3cm90ZToNCj4gUC1T
RUFNTERSIHJldHVybnMgaXRzIGluZm9ybWF0aW9uIHN1Y2ggYXMgdmVyc2lvbiBudW1iZXIsIGlu
IHJlc3BvbnNlIHRvDQo+IHRoZSBTRUFNTERSLklORk8gU0VBTUNBTEwuDQo+IA0KPiBUaGlzIGlu
Zm9ybWF0aW9uIGlzIHVzZWZ1bCBmb3IgdXNlcnNwYWNlLiBGb3IgZXhhbXBsZSwgdGhlIGFkbWlu
IGNhbiBkZWNpZGUNCj4gd2hpY2ggVERYIG1vZHVsZSB2ZXJzaW9ucyBhcmUgY29tcGF0aWJsZSB3
aXRoIHRoZSBQLVNFQU1MRFIgYWNjb3JkaW5nIHRvDQo+IHRoZSBQLVNFQU1MRFIgdmVyc2lvbi4N
Cg0KV2Uga25vdyB3aGF0IHRoaXMgd2lsbCBiZSB1c2VkIGZvciwgc28gaXQgd291bGQgaGF2ZSBi
ZWVuIG5pY2UgdG8gc2F5IGl0LiBMaWtlOg0KDQpUaGlzIGluZm9ybWF0aW9uIGlzIHVzZWZ1bCBm
b3IgdXNlcnNwYWNlIGFkbWlucyB0byBkZWNpZGUuLi4uIEZ1dHVyZSBjaGFuZ2VzDQp3aWxsIGV4
cG9zZSBpdCB0byB1c2Vyc3BhY2UuLi4NCg0KUGx1cyB0aGUgcmVtYWluaW5nIHVwZGF0ZXMgcGFy
dCBpcyBub3QgaGludGVkIGF0Lg0KDQo+IA0KPiBBZGQgYSBoZWxwZXIgdG8gcmV0cmlldmUgUC1T
RUFNTERSIGluZm9ybWF0aW9uIGluIHByZXBhcmF0aW9uIGZvcg0KPiBleHBvc2luZyBQLVNFQU1M
RFIgdmVyc2lvbiBhbmQgb3RoZXIgbmVjZXNzYXJ5IGluZm9ybWF0aW9uIHRvIHVzZXJzcGFjZS4N
Cj4gRXhwb3J0IHRoZSBuZXcga0FQSSBmb3IgdXNlIGJ5IHRkeC1ob3N0LmtvLg0KPiANCj4gTm90
ZSB0aGF0IHRoZXJlIGFyZSB0d28gZGlzdGluY3QgUC1TRUFNTERSIEFQSXMgd2l0aCBzaW1pbGFy
IG5hbWVzOg0KPiANCj4gwqAgU0VBTUxEUi5JTkZPOiBSZXR1cm5zIGEgU0VBTUxEUl9JTkZPIHN0
cnVjdHVyZSBjb250YWluaW5nIFNFQU1MRFINCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIGluZm9ybWF0aW9uIHN1Y2ggYXMgdmVyc2lvbiBhbmQgcmVtYWluaW5nIHVwZGF0ZXMuDQo+
IA0KPiDCoCBTRUFNTERSLlNFQU1JTkZPOiBSZXR1cm5zIGEgU0VBTUxEUl9TRUFNSU5GTyBzdHJ1
Y3R1cmUgY29udGFpbmluZyBTRUFNDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGFuZCBzeXN0ZW0gaW5mb3JtYXRpb24gc3VjaCBhcyBDb252ZXJ0aWJsZSBNZW1vcnkN
Cj4gCQnCoMKgwqAgUmVnaW9ucyAoQ01ScykgYW5kIG51bWJlciBvZiBDUFVzIGFuZCBzb2NrZXRz
Lg0KPiANCj4gVGhlIGZvcm1lciBpcyB1c2VkIGhlcmUuDQo+IA0KPiBGb3IgZGV0YWlscywgc2Vl
ICJJbnRlbMKuIFRydXN0IERvbWFpbiBFeHRlbnNpb25zIC0gU0VBTSBMb2FkZXIgKFNFQU1MRFIp
DQo+IEludGVyZmFjZSBTcGVjaWZpY2F0aW9uIi4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IENoYW8g
R2FvIDxjaGFvLmdhb0BpbnRlbC5jb20+DQo+IFJldmlld2VkLWJ5OiBLYWkgSHVhbmcgPGthaS5o
dWFuZ0BpbnRlbC5jb20+DQo+IFJldmlld2VkLWJ5OiBLaXJ5bCBTaHV0c2VtYXUgKE1ldGEpIDxr
YXNAa2VybmVsLm9yZz4NCj4gUmV2aWV3ZWQtYnk6IFhpYW95YW8gTGkgPHhpYW95YW8ubGlAaW50
ZWwuY29tPg0KDQpFaXRoZXIgd2F5LA0KDQpSZXZpZXdlZC1ieTogUmljayBFZGdlY29tYmUgPHJp
Y2sucC5lZGdlY29tYmVAaW50ZWwuY29tPg0K
