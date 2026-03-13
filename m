Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127F1373C01;
	Fri, 13 Mar 2026 17:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773423825; cv=fail; b=U/DYqkYtvnbl/8Xh7trvkahFpeg/OlTMOtrwGrMZeFBnO+yAQBeZdr23C3Brl1KkO2DrSbLYIGXQn4s19kau5MDD7ObGVc2AFtAotU3BXzj5zfDpACek25z7eGKvTSSqV7C8CErLvHnuRp4CL5bJd5E7mpUHr1g6JFhepA3Jdf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773423825; c=relaxed/simple;
	bh=t1Wb86BTR+Me3249DuFPCCpG//yu1qh6NWdcPJXZ4qo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VVNcH/C/XvvjIE65H74SgZQxRRbog2ZKDFkKVeQNp4mP8H2lJKc+5EgLSC6yvHsujr59Eb+IERO3w1SEt4kz84N0q30CtWq1qqnJ4mad4e0Bd4H2AVZojJOHYck9Sx5WKvH28gCZaGGhj5X3lT5zJRSs6uq9PGjvWTxt6IVk0ew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PHV3CXww; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PHV3CXww"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773423823; x=1804959823;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=t1Wb86BTR+Me3249DuFPCCpG//yu1qh6NWdcPJXZ4qo=;
  b=PHV3CXwwBag3Wx/nbNWQFUlck4ojs3Sq2cJP+HHOsv0hdoxaIOuds9W5
   7sZMYUl8pC36IwgDqgCWPVBRO2au1HPUBeJXGrlZHpsX5yhK3h/gz7ga+
   koxMm2L/cvURFQafjVeeKGoxsof6xS21YeUODohSa/ScWYTav8cjxJ4Sv
   7nLLFptAg9XwCfJL0+IlOiop74JB6QsAebmfLNqxkTHVGk8ZsnIGtJFSh
   PmJu+yj+ykiW4Up/iz0lO2NcmaAdpmRTpndIttQhrEj9mlMlAQzBobN/B
   NsM7h2KMj7SL2j7liIQWDfV3+3hCI66UiCh0Vq+jP75kWNBayrhg+gxP6
   g==;
X-CSE-ConnectionGUID: D+NssixWRJSnJXfg8bWHOQ==
X-CSE-MsgGUID: 95LerhPCS7iqfTWdR2ZOeQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11728"; a="92108240"
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="92108240"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 10:43:42 -0700
X-CSE-ConnectionGUID: 6I35thxjT7OtYZPGTZKy1w==
X-CSE-MsgGUID: oWQDHK5dSn2KI3VkM8lYng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="218555050"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 10:43:42 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 13 Mar 2026 10:43:41 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 13 Mar 2026 10:43:41 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.21) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 13 Mar 2026 10:43:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lp9LMybAmyHQaRH7HSPilrXtL7M2scl2QzLwICXkEq/b/LzTsn982v7OqHPhy7uGFdg9zYiSTi5cXOne8XLD7MpWBazFPdhPwsb2n3iYQsGptlBPlUF2nfp2ttefLYhMuUBAKqQBp7Vgn/+5ojUfJJZRtNYl5rAezrFvZ0H9FjLbKIk2FIEgN1LHuVlovQxuitE3Rh6slfuleZVvw+P4yL3pykpevB3OARkhlze2IoOBeQmHW8/hTgDXyluAgmrNKg29HycNpLk2KcN5fdw6UH47PNli8PLbM3u31V+sP7U4lgA5ROhskzq7rKxXx9ytQMc86+VO7nM99Z3Eblhirw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t1Wb86BTR+Me3249DuFPCCpG//yu1qh6NWdcPJXZ4qo=;
 b=GFmvrV+WxpG/9ekSKwh2nXZxw3gj5G0IlvjsQ3jYd9WBMEzrE8tC7GsZbpQvWQkXC0msSmndeNvycWJYeKZHeg4Sdryl/wpouyPdJs1KDLIaN7+cCoRPOI3BHsIwTRQeslJkbOuLyd3kfwWGvIpcdUXfp3Y6txOvDIIwrfwz1Y9zwlHaMVLahp23oFTOhyKYutWGk3e0YYVXWMD7P265Xmm3bPQ0fqeQNhYjT7K8vLt5HW9wR+gxgybqTwUELeiPxW6AUr+rb5ygB8Jt/AtOvLgHLlcnFk/7cLd1OdRD7bpDtJX2m1PNFJ0OOn31+0Uw57wgv5uRuZhpg6wV7Ft+GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by LV3PR11MB8531.namprd11.prod.outlook.com (2603:10b6:408:1b6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Fri, 13 Mar
 2026 17:43:36 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65%6]) with mapi id 15.20.9723.008; Fri, 13 Mar 2026
 17:43:36 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Gao, Chao" <chao.gao@intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Huang, Kai" <kai.huang@intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "kas@kernel.org" <kas@kernel.org>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, "Weiny, Ira"
	<ira.weiny@intel.com>, "tony.lindgren@linux.intel.com"
	<tony.lindgren@linux.intel.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"Verma, Vishal L" <vishal.l.verma@intel.com>, "nik.borisov@suse.com"
	<nik.borisov@suse.com>, "seanjc@google.com" <seanjc@google.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Annapurve,
 Vishal" <vannapurve@google.com>, "sagis@google.com" <sagis@google.com>,
	"Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "tglx@kernel.org"
	<tglx@kernel.org>, "paulmck@kernel.org" <paulmck@kernel.org>, "Chatre,
 Reinette" <reinette.chatre@intel.com>, "bp@alien8.de" <bp@alien8.de>,
	"yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>, "Williams, Dan J"
	<dan.j.williams@intel.com>, "hpa@zytor.com" <hpa@zytor.com>
Subject: Re: [PATCH v4 11/24] x86/virt/seamldr: Introduce skeleton for TDX
 Module updates
Thread-Topic: [PATCH v4 11/24] x86/virt/seamldr: Introduce skeleton for TDX
 Module updates
Thread-Index: AQHcnCz8dleGg3tjsk+bFkddavHcSbWqT5iAgADLvICAAEHcAIABTC6AgABAGwA=
Date: Fri, 13 Mar 2026 17:43:35 +0000
Message-ID: <3217156b6883fa63dd0c44cd9750ebc134b2306b.camel@intel.com>
References: <20260212143606.534586-1-chao.gao@intel.com>
	 <20260212143606.534586-12-chao.gao@intel.com>
	 <daa8080e1195f586af331dcf31ee5239c4ecbd15.camel@intel.com>
	 <abLJGel27U8xuU6q@intel.com>
	 <aa798a36216fb44969a6abedf96ecf1c7d4e95fe.camel@intel.com>
	 <abQW/1Cfxl9TdJ8D@intel.com>
In-Reply-To: <abQW/1Cfxl9TdJ8D@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|LV3PR11MB8531:EE_
x-ms-office365-filtering-correlation-id: 6fc91626-55c7-473f-27c3-08de81280d90
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: RHhq+8X+orvYTHM4QXI0E2tvbscl/c5KPRiRZ3kxapkV/OQ4Z9PkN8dblgNXdiuKT8R+BupbnwXTjC/to4Pvvx4kQq4CVpW3/tmS9PQqef18+1SWKUYp3skgRuK8gNEVYBCa+yLiF0KRvcI2lGTYJALd82XfUUogmYD4Drhrz8IKgGk+3HEhorpEIADztkYBt92VQR8sBxf3assPA5LSK3ioS3SilcdWkJsHKWZrrDvVJl5pNlO+HWGFfGgni1jMl1trnOZSkRorAdgXCwD4KnL5dNF8flqYwtkQmXjkdYlYo3+A9uYr5BNbxh5THJvUOn6HiN4KgxjKdLPKbnjZQVbYBucU7UWD1SAaNbQv4w8mnUVfy74AXobQlqmh4ZKknw5j4EVlI0AjvIT8UZXxakKH1yRUziXBuOD8+T7dTvNbzrt/a3wI0/XLeYnQm+k7+HgTrMJMtPF8+ERFwf7GlxezYywqK6/3uRWzD6IU4+E3MEmaDy+vOAY2OABM8+G0g8wt7d9BDY0dXrqPJYxiCgHA3NXGbsZJDFwcUOG1Jm+1IpLbAcsBruVRimrzax0Ku/I5kz0gs+JTRhA9db3hNctFVKgBI+gdwz7q/JLkr+oeSuXcj96eFaDyxeH0wusGletoIkeuRHCNzYOZgxGFogaAD4h7qYTRHqWhzNsx+T0k0E5+RG1yAuuZ71yblIcxUYdRFOqbjxlvcFYB5k79HTaXgLScCrbvQwgEEM5RLxJjV/H2Mmt1ANvlb7y6KOVz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?LzhWb0RYaUhDL0J2YzZGZ3dZS1k1azdyUVJEUTZOS0VPYm9mZHd6bWk0VHc2?=
 =?utf-8?B?cmpleUtGNy9McWNIaG5yY3dBVy9nbGFJcXJlS3M1NFhXZUg2RmZtYTJreldk?=
 =?utf-8?B?WlUrZTk4UlBhQ2ZzZm9VZTloSllWYVE1UG11NWdqUUtmZTJkWnpnam15YmRI?=
 =?utf-8?B?c2JlbGdPNlhzcHEreExrNjh6S0oramJnNnUyWVpnckVQbk12enVXM0Y3cCtC?=
 =?utf-8?B?T2VtY3lWQXd2MXRRd1prSFBVcDgvY3U5ekRYbElPTGZqQ2FFSDNabWIwNCtJ?=
 =?utf-8?B?N3lUcjFyKy9XWGNaVmh3eVlTYytkZnlPUi9FWS9UczZjTXRlSkw3b2p3T3JW?=
 =?utf-8?B?OWhoVEkxWm9rY3hHR2ovRHpwbFBpRTJXMHBoc0JEcUF3TVpEZWJkMlR6aDhD?=
 =?utf-8?B?ZVY1NnpYWTkwdURNcTBNVkIzZmNhSU5xZkU0b2FsaFcvcTZrcXFBSmM2cjM0?=
 =?utf-8?B?V1BRempvcVNQYWhPZXd0cWhSVkYvbTlQSnBUaW9HbkhYMjlpdEVTQ040bFoy?=
 =?utf-8?B?Ny9hVjBRckxQWUxLRVpLUnErVWNFRmN6dUFGcGJjV3g3QVJkMW1oSGVQRDNG?=
 =?utf-8?B?VlgvcmdkVjBHZk5SbHRxN0E2UVFIbk9XZVFwbDUwdU5HMWpUVmp1VEFpV2xi?=
 =?utf-8?B?bHNFcmZacUg5Qy9Pdk1jQllrTjBhUmRyOWlNY0hyQi9qWXB4ayt2cGptcVBm?=
 =?utf-8?B?VElJSFN1cXY0QWJBVktlNTIySUZyTDBoRXlYOXUrWlRtY21PR1JzVUpJYVBn?=
 =?utf-8?B?OFYvWGRoT2g4YnIxb3VmQU4vSGdXSWwrS3k3OFNCOEdhT2toMzVEejd1YkVi?=
 =?utf-8?B?M1E1eVBlQm8rZVVUZmJDcTJlSHVMbUYzZWxlWVVSS3Z1NUNMcFVRRWEwaVp0?=
 =?utf-8?B?K1NlWVE1b2tId2ZRdVppODVyT1RzaHFGRCtWcjhtbExuazljVytGcGFwRjBv?=
 =?utf-8?B?cERUa2JUUVY1NWVaemZRdFJqRGZtRytsTmJpQ3NhcnU2RVpWZnJSTVB4WHd2?=
 =?utf-8?B?Sys5U09zVGJjQWxMWXZncngzVHhkWG9rYUFUVlpTN2x4RCt2Tk5YR0Z0M0N0?=
 =?utf-8?B?eWtWU3IvSjVLNjFWaDZXcWw1c0pRZVZKdlV6Y3ZNTncrZktUajJwcVU4NUx4?=
 =?utf-8?B?UDgrY2h3c3FPM0hKK0poREo2WTRvcWsrcU91N3R3Y2FaTjV5UHhtZ1VDMlRK?=
 =?utf-8?B?NEZ1c2xZcENFOVJkaFhPNWpTcWE1YUFuQjhIUGZZeWVlbnpQMEwyRHBZRXhM?=
 =?utf-8?B?dmhOeHMyMXFCY0toS1cwY1VKVzFjTjFlaWEyQmV4VThPc3hHMnYvTlBmY1Fq?=
 =?utf-8?B?ZXdMeGdlcVlOaDg2RDYrenJ4RkpVY0NRN0gzdEpsb1M1SXA2RHh0YzV6cVJG?=
 =?utf-8?B?ZnJLYUNocytmbGNOOTZTQk5aRDZYQXpyUHFoRzFsaS9jV2p4STJ2OGlXdWdI?=
 =?utf-8?B?eEFyYUtIMVFuQVdDMFpVcHNNVSsyQUZDbG55cFFPRlVTUjRidmdiZ053Yjh6?=
 =?utf-8?B?WmxUVU8wZ2VXQk9uY3lqR1ZyV05iVkltd2FEU1pLaW0xK3JYay9nMjRic3hl?=
 =?utf-8?B?VmRETEFhWWpsYkxkeWp2VzM4U1k0NFJyTTdoSURvaEplS1gwc3ZqeDN2TEli?=
 =?utf-8?B?cDhCMldGMGZtZ0czS0o3UWtZVE1IR3ZKODFVZ1VmZ0VZWCtJYm5QclRGcUls?=
 =?utf-8?B?ZGRBamhoanNoREt0REtMY0l1dzY2OXYvMVlOalp5b0FoWTNoclRxaEZkek4w?=
 =?utf-8?B?QVdUZVhVVlF4YlBiSEgxWUlOemtOelRibVQzRGM1aElnVTVFNGVwQTR0bUp0?=
 =?utf-8?B?bFVwSW9za1ZINWlaNWRhVnpNallBQk9kT1Z5bmJ5M3lzNzJxWlBybnpibk9i?=
 =?utf-8?B?aTg0WVNZZU9xT3hlQWNxRlh0dXFRUk9TZmRjTEUzUFRSWVE0WW00Rk5hRjh5?=
 =?utf-8?B?Q2tVOURWME9SZnFCZDE3blNTVmhaV1pudVVXN1N5S3VQVGpvc0hPSUNjY3FD?=
 =?utf-8?B?Q0FSaDU0U3VKNDQ4RWdOY2N1MXR4ZXhIQ1g5VTZQd215aTFONDF3MmZIdVMz?=
 =?utf-8?B?OWxiQzk1anc0dGJ4QWZBWGNJVVBJUGI5RmxZc2E4ZEFxb1VRVFl0TkJ2ZzU1?=
 =?utf-8?B?Z2FrVlp1SS9OV1I4WnhhZXlLN0crMnpnMDVqcGNJdHNyenNqNjZSVHBreFhJ?=
 =?utf-8?B?bEZlK1RtWGJKcEN3SzkrangwbEdYNGdibys3MDgxeTJYNjQxWXlZNmQrT0x6?=
 =?utf-8?B?eHI2UFRrZmROTHJ3by9lREtCNVQrRXpEeXlScnVwK3lDcU00WXFFa2pWRnVP?=
 =?utf-8?B?LzNzS2ExdDhOQnptd2hlN3dhMHE0NHhubUY3V2ZrVXNVdGIxM0FybnArdkpr?=
 =?utf-8?Q?k6HZZ6xybdH2WKBY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ED5823B17762644EBF51175A86A2998D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: tvUu9payLnSCIY3uRx2iTCLtiqh0cV+TX6dkPQr2chqzC3SLWlCghrsfqIvbTdsTKxxqlXSbKF3ORgIJ92X1OqKQxTRwjZ7+Xmz9s5l4pXnVYAQ3674vFnyeWpxISWUj0iSyxeKH6gt+PeEcW+VdbejobNLLLB1TKDaWHZZFh+EQZy8kiaeNCGxt13+9Y2p6Vebq/Nl0n3xsGxQqLiuNq0hA7eSxhaF2LbyYyubirvpkZKgjhM7bP5wmNfBwZatWvulEnsdfo8g6eESD7GOpskTQGrdLPcK8XEEla7VFSBdcmS8HfqXQFJqfFxbctpF4IL7ZlOSvgVd4ydxbTeKZAg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fc91626-55c7-473f-27c3-08de81280d90
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2026 17:43:35.9215
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /O1uejCfKhRrobfNIiLzy146BvVqbTBHj1cDXZLRNSqBHm4EoVlumfNN3iza/UcRM2kmPWMQSaVjOtKudqDxomsXt5ioZlrdPKalUDSS2po=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8531
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTAzLTEzIGF0IDIxOjU0ICswODAwLCBDaGFvIEdhbyB3cm90ZToNCj4gT3Ig
dGhlIHN0ZXAgZGV0YWlscyBtaWdodCBiZSBpcnJlbGV2YW50LiBQZXJoYXBzOg0KPiANCj4gwqAg
VERYIG1vZHVsZSB1cGRhdGUgY29uc2lzdHMgb2Ygc2V2ZXJhbCBzdGVwcy4gT3JkZXJpbmcgcmVx
dWlyZW1lbnRzIGJldHdlZW4NCj4gwqAgc3RlcHMgbWFuZGF0ZSBsb2Nrc3RlcCBzeW5jaHJvbml6
YXRpb24gYWNyb3NzIGFsbCBDUFVzLg0KDQpJdCBzZWVtcyBsaWtlIGVub3VnaCB0byB1bmRlcnN0
YW5kIHRoaXMgcGF0Y2guIFRoZW4gd291bGQgeW91IHB1dCBhIGxpdHRsZSBibHVyYg0KYWJvdXQg
dGhlIG9yZGVyaW5nIG9mIGVhY2ggc3RlcCBpbiB0aGUgbGF0ZXIgcGF0Y2hlcz8NCg0KPiANCj4g
PiA+ID4gPiAxLiBUaGUgZW50aXJlIHVwZGF0ZSBwcm9jZXNzIG11c3QgdXNlIHN0b3BfbWFjaGlu
ZSgpIHRvIHN5bmNocm9uaXplIHdpdGgNCj4gPiA+ID4gPiDCoMKgwqAgb3RoZXIgVERYIHdvcmts
b2Fkcw0KPiA+ID4gPiA+IDIuIFVwZGF0ZSBzdGVwcyBtdXN0IGJlIHBlcmZvcm1lZCBpbiBhIHN0
ZXAtbG9ja2VkIG1hbm5lcg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IFRvIHByZXBhcmUgZm9yIGlt
cGxlbWVudGluZyBjb25jcmV0ZSBURFggTW9kdWxlIHVwZGF0ZSBzdGVwcywgZXN0YWJsaXNoDQo+
ID4gPiA+ID4gdGhlIGZyYW1ld29yayBieSBtaW1pY2tpbmcgbXVsdGlfY3B1X3N0b3AoKSwgd2hp
Y2ggaXMgYSBnb29kIGV4YW1wbGUgb2YNCj4gPiA+ID4gPiBwZXJmb3JtaW5nIGEgbXVsdGktc3Rl
cCB0YXNrIGluIHN0ZXAtbG9ja2VkIG1hbm5lci4NCj4gPiA+ID4gPiANCj4gPiA+ID4gDQo+ID4g
PiA+IE9mZmxpbmUgQ2hhbyBwb2ludGVkIHRoYXQgUGF1bCBzdWdnZXN0ZWQgdGhpcyBhZnRlciBj
b25zaWRlcmluZyByZWZhY3RvcmluZyBvdXQNCj4gPiA+ID4gdGhlIGNvbW1vbiBjb2RlLiBJIHRo
aW5rIGl0IG1pZ2h0IHN0aWxsIGJlIHdvcnRoIG1lbnRpb25pbmcgd2h5IHlvdSBjYW4ndCB1c2UN
Cj4gPiA+ID4gbXVsdGlfY3B1X3N0b3AoKSBkaXJlY3RseS4gSSBndWVzcyB0aGVyZSBhcmUgc29t
ZSBkaWZmZXJlbmNlcy4gd2hhdCBhcmUgdGhleS4NCj4gPiA+IA0KPiA+ID4gVG8gYmUgY2xlYXIs
IFBhdWwgZGlkbid0IGFjdHVhbGx5IHN1Z2dlc3QgdGhpcyBhcHByb2FjaC4gSGlzIGZlZWRiYWNr
IGluZGljYXRlZA0KPiA+ID4gaGUgd2Fzbid0IGNvbmNlcm5lZCBhYm91dCBkdXBsaWNhdGluZyBz
b21lIG9mIG11bHRpX2NwdV9zdG9wKCkncyBjb2RlLCBpLmUuLCBubw0KPiA+ID4gbmVlZCB0byBy
ZWZhY3RvciBvdXQgc29tZSBjb21tb24gY29kZS4NCj4gPiANCj4gPiBSaWdodCwgc29ycnkgZm9y
IG92ZXJzaW1wbGlmeWluZy4NCj4gPiANCj4gPiA+IA0KPiA+ID4gaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvYWxsL2E3YWZmYmE5LTBjZWEtNDQ5My1iODY4LTM5MjE1OGI1OWQ4M0BwYXVsbWNrLWxh
cHRvcC8jdA0KPiA+ID4gDQo+ID4gPiBXZSBjYW4ndCB1c2UgbXVsdGlfY3B1X3N0b3AoKSBkaXJl
Y3RseSBiZWNhdXNlIGl0IG9ubHkgcHJvdmlkZXMgbG9ja3N0ZXANCj4gPiA+IGV4ZWN1dGlvbiBm
b3IgaXRzIG93biBpbmZyYXN0cnVjdHVyZSwgbm90IGZvciB0aGUgZnVuY3Rpb24gaXQgcnVucy4g
SWYgd2UNCj4gPiA+IHBhc3NlZCBhIGZ1bmN0aW9uIHRoYXQgcGVyZm9ybXMgc3RlcHMgQSwgQiwg
YW5kIEMgdG8gbXVsdGlfY3B1X3N0b3AoKSwgdGhlcmUncw0KPiA+ID4gbm8gZ3VhcmFudGVlIHRo
YXQgYWxsIENQVXMgY29tcGxldGUgc3RlcCBBIGJlZm9yZSBhbnkgQ1BVIGJlZ2lucyBzdGVwIEIu
DQo+ID4gDQo+ID4gSWYgaXQgY291bGQgYmUgc2FpZCBtb3JlIGNvbmNpc2VseSwgaXQgc2VlbXMg
cmVsZXZhbnQuDQo+IA0KPiBIb3cgYWJvdXQ6DQo+IA0KPiBtdWx0aV9jcHVfc3RvcCgpIGV4ZWN1
dGVzIGluIGxvY2tzdGVwIGJ1dCBkb2Vzbid0IHN5bmNocm9uaXplIHN0ZXBzIHdpdGhpbiB0aGUN
Cj4gY2FsbGJhY2sgZnVuY3Rpb24gaXQgdGFrZXMuIFNvLCBpbXBsZW1lbnQgb25lIGJhc2VkIG9u
IGl0cyBwYXR0ZXJuLg0KDQpZZWEuDQo=
