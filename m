Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7976D36C0A2;
	Mon, 16 Mar 2026 21:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773695720; cv=fail; b=sfkZ3arx4IEKHI2WeVWzivyTNwmecpqsbHRQc2V5kZSWhRAI2UrHxOHPvWL0d4aLbtO5QxIV/AKcMSUKnL34LmEDZ04KWrc/MIPrPKs3YDbI/+6uhGnwxLN1ykgYhzcjQ9o9IQxW0AH7RsdjEvCh2S0CW0VZ/y+sOw8HYtr1/m4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773695720; c=relaxed/simple;
	bh=GOSxiJuxL5YeVLnSQtn247XYb+6ThlTjq4hbbSUp/zQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZlKD2UFaVq2nLTarvWpiqeFRgDYJykp9Mbx74qY5UHMbcopk+jb+utyrDTFqMmXPyp0suYUv34NfnLDtjN3RG9iwg9gsIx0b7InQP+CXnJEb8Lu/L9x7G4wek1okHhvWs+atRXeTCMY9P2/Rm1noE4VshzuKWT1F1/IBvziWtVk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MHia6c2m; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MHia6c2m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773695719; x=1805231719;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=GOSxiJuxL5YeVLnSQtn247XYb+6ThlTjq4hbbSUp/zQ=;
  b=MHia6c2ms4RFeqTGnmkZXlm/DEIeWskqKDtCmFR46yP401pDpxBf+EaH
   oNUNTz8N1WtMRScUN/B7ID/7ZzMcCzIWL5RDl2xJMngk0n+CQCo7XT4aZ
   4MasyEefwxEL1jhfjauMWgwBwSVKcd1+vx2A1kXt27YaquFX5yqVfKG+x
   9LPVSvBMHHRYfXSUO4PYLDtLWDHt0hMLuO+4McQS/0iYtGh2Ps0scl6aL
   qOqAaqkWF3JCpcHWyn7o0ZBbHZGPD769c18RXF+oJtTjm1M22Uci/XziN
   h8h9wAYEej5ZXJrsVBxC32aNy2nLwZdI4L8oUTmaPnOq2UncNM5SeahQT
   w==;
X-CSE-ConnectionGUID: 3XmKaxBpRrqUJ3iY65UtCA==
X-CSE-MsgGUID: /MZNeo/QTFqDn/QlSIZmrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="74694990"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="74694990"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 14:15:18 -0700
X-CSE-ConnectionGUID: 8AwNmBw8TKWArIyG5BAJGA==
X-CSE-MsgGUID: PFavwALFSkSjrWzPvgD/fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="259937565"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 14:15:17 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 14:15:17 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 16 Mar 2026 14:15:17 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.15) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 14:15:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=STtArnlij4xo6PGMJLA5/Z9nFUj1qKnjMv8hAMQBmNJZRunrMq3m0I7dtpQL7U1fAlAFosrtFyD4LXlLnmPtweCfeoNH3+2qu23W5+c1U9Itz1nPL6eI26kU5pTVKU2hy+J2B9SPpp2V3ChuFC8WMHcBwI9qEHyKe3yimZhKh4QwCmUa70HT9PH4MSbhBPmPLMb61sOKcJvEG2V6OW+C7P1XJunDAdNboUDmq6SbusH581OAuhyr71LgMIivAaYJzCVQg5bkllH5oKkwwnC7vAQhuKe1kRc+uQhNDkb8gKAU0WgxDI46mx+e49mrOUaotuihAEukVofurbbxO+/4oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GOSxiJuxL5YeVLnSQtn247XYb+6ThlTjq4hbbSUp/zQ=;
 b=kVTOIczI8zYqB6IilgEb6Ip+YO5cNorOCJ1U0xFULMnUywACH1z1rM4ZSxtvW6AbZA4jWiMqp0cHnEpX0lLuS2jrgpNehHJuJPw6q5UcQOapRKkUSpBL08u/Kinsb3oHCWGCcBqL0yn9b/8lWBxqiRPh6iXUxhZ/WdNrVK8fgie7dNgNEdaCMHnB7ilqTSoQVwK1izT5QEvbUC0iC8Sl43yQDzN9m4WbPfskNatuytr5DRyeK2k5XW0WWl2tn+jJHN8J11vMcd+wIfHZGYjUezwL/21X2/db/Eggf+It8KY2HnUwrvV5NmMtgQ5ZSu1KfU32Mlv+PmFH73NsKko9Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by SA1PR11MB6710.namprd11.prod.outlook.com (2603:10b6:806:25a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Mon, 16 Mar
 2026 21:15:13 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65%6]) with mapi id 15.20.9723.008; Mon, 16 Mar 2026
 21:15:13 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "kas@kernel.org" <kas@kernel.org>
CC: "tglx@kernel.org" <tglx@kernel.org>, "Hansen, Dave"
	<dave.hansen@intel.com>, "seanjc@google.com" <seanjc@google.com>,
	"bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
	"ackerleytng@google.com" <ackerleytng@google.com>, "hpa@zytor.com"
	<hpa@zytor.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"Huang, Kai" <kai.huang@intel.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"Verma, Vishal L" <vishal.l.verma@intel.com>, "Gao, Chao"
	<chao.gao@intel.com>
Subject: Re: [PATCH 3/4] x86/virt/tdx: Add SEAMCALL wrapper for
 TDH.SYS.DISABLE
Thread-Topic: [PATCH 3/4] x86/virt/tdx: Add SEAMCALL wrapper for
 TDH.SYS.DISABLE
Thread-Index: AQHcrc5S5plCcsB6A0WZ+ibcqtEcs7WxGrsAgACdmwA=
Date: Mon, 16 Mar 2026 21:15:13 +0000
Message-ID: <ac341cedf0e387f2ba5cf3fc9d2ad5fcaa2ec3c8.camel@intel.com>
References: <20260307010358.819645-1-rick.p.edgecombe@intel.com>
	 <20260307010358.819645-4-rick.p.edgecombe@intel.com>
	 <abftAJkiU3Q24wYQ@thinkstation>
In-Reply-To: <abftAJkiU3Q24wYQ@thinkstation>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|SA1PR11MB6710:EE_
x-ms-office365-filtering-correlation-id: b9602171-4339-4b44-17c1-08de83a11d3d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: rOVKjz7NWHa+Km3xYAgWVZvL+FKTNXLxAP4nSH/WrlzgO+PYWH8FcxsQQSACh+W20V6GTVzCDNClR64h3OGCzmmeTYNqgfFlU5p+EXOYwJr4rOlWB2+SOgCx6aIYUFpBnQZ/W9N1YvzB7PW8TQy+rJxjX+hDgExVMqX1+SItJduv/Nk1DRcTwmlAGHj2L/TC7nVOEaRsoKA6h20Mu1fTJB1Nwr6K/jAZ5mWJpjZKaijcLDnTcA0SvpK51CsRUAFB3FygT+/MgDH1e8zJzdS/d0DKrCizJumIzcaF54wltIBHyxCS9xp/dALZBs4cxXonmBcPAnXbtWpwCgkKEV0M33lU+RbnzQqTnv4wRWQ9AVR0gf2z2RIHDvWHNADCkzVpF25aAGgK0+u6HHn/4NLPb+pHtoJ2X0lYjakshIE2UO1AMrQvRfd5j4OJ6KGp04yQ4+aKe3DlFu1kd04SISw/BUr0ARqDrgimZuRPWDE5ZM3CSJUJGgpvqjB2BlyyEElFsOKLuwmiNO2J6MXZoaJ5vHViW6fLfs4i1cBRwcbayQMdgODMommfXwXbjAAUQwHWpKGqE78OE+H/7Ql3vIBs209Noue6c+n2a3lRk8wQsxfjTt5cJvkZkZ8hjYY6dgMP78kBUe2Wi5ll88keMUXfEfVBqXHPSjmqS+mrCbONkSvuN509gUf3bMhee1o0hBn+iUnxjk2MwXglZS3IbLieFd4crPe0wRmzNRbpLRgiS5xqSdpkrJ5vFF0HDuOS2fNmbWPdkvUK3GBTYbG/g+xGVE4LFvGOOa2gGCNvAsL77bc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eS9DSk1zc1JrRm9RaWNpYS9kUlAzUFhrNkx1WHJ5TkdVRjQrcFZnYjV6M0Ra?=
 =?utf-8?B?alFobEZxQnFRSnVKb09YZjcxc210MDlXOVVtWVQ2ZFBpb3gwaUptVCt2ZlRL?=
 =?utf-8?B?ZmxEMml6ekxRcFRRT3lVeDJmc1Z3NFQ4N1k1WTNxYnphOWcyNW8zY0k2Y2tT?=
 =?utf-8?B?SGxYY3FhZ2g3RWpEN0tCWlp2Q242YUR3NXlPbkxKTVk5aDB4ckdYeXVISk9y?=
 =?utf-8?B?YkxyUnVCSUlMY0piNXdJWk0xRzF3WFdGR3haYU44S3pPQ2hsU1VPQm5JOCs1?=
 =?utf-8?B?ZU1CUmFyQ0tJbjkybktIM0wrR0t2a05LdVdwNG04bHBCMWNMN1psNkJqUTJa?=
 =?utf-8?B?Y2F5QnVUUEFkUVRmQmNWdWNac0RMRlZ3dk00NG1Qekd0bEhzdFdjbVNYQkVM?=
 =?utf-8?B?ckZjQUhJeVlDbFhESFBQUHdHbXZDRnR2NDROc1JmczJOeUUzTHhwVU1HeGx6?=
 =?utf-8?B?czVqZkg3WjlMRG5ndTJMUlhBQm9jUldGemhyZmoxbjdrUzlQYzZHbWdpdU1H?=
 =?utf-8?B?MGw1cjJuOU9mQmJJUnVkWmxnamVrTnZyeGJteWN4YzlnWFJMNVdhQXFqQVZH?=
 =?utf-8?B?Q0pvTVpXdUZGMy9aSXlNOGpLa2twTE1pdUtUVnpSVXk3eS9MSnNEY2ZzZ1h0?=
 =?utf-8?B?R0tUbDBUVWg4OXZVcUllSjFCR1MxbUVNZm9GZG9RUEtyeXVNNDJiMnRwZHpk?=
 =?utf-8?B?M1hvcU5DdGVrSW5SQU1KWTRwM2oxdGFCMG9yRTMyR3ZJMHpKZ0cwU3lkVkw2?=
 =?utf-8?B?am9zeU9uOHFndHVHVG94L0xDbzd4eWQvS01xQTJjaUtmTWtIcmEzc1Y4amc2?=
 =?utf-8?B?N1dmOHJMdVk0bVVBQnJqZ3IxeFJjWmxPMFVIcFA5QWlYNms3UC8vRDczSFdY?=
 =?utf-8?B?Q3JNankwdGlkbEt0MHZaNGdvMXpWOVhyRzRvRDR0VityT25WVEdCbW5ISU85?=
 =?utf-8?B?K2xHRzRTZ1VKR2tYOUlEdnB0RnpiZUxFUVpwOXdsT3dxcmZEWjhSQlFnRnRo?=
 =?utf-8?B?TTZCZzJqQmcybkJqZGIrQzdkcWRIY1U4L1N0aGxzK1FwMjJlVm9QU0FPUldj?=
 =?utf-8?B?ZVg2aktpRks4VkNWdEY2Z0pSZDhoMDVCdTI0VW0rRi80d2RWcnE1d3UwY1dU?=
 =?utf-8?B?Z0drNFlERXJQK3B2TG51M0hTVEFmb0xnRFdxbHFtSk0xd3pVY2MxVzN2LytD?=
 =?utf-8?B?enF4MG1BaG9yLzJmWEtZMjhuV2tTZy9zV09XM015OENPZ2dFY1JjU3dMeU5H?=
 =?utf-8?B?cjUvcVByeklka0xURjF3YktrWkpCV3B6bnFDb0htMk9lNjczT3Z4NmxxemEy?=
 =?utf-8?B?VEpCYTQ5c21DbnVzZ1dlbExEVzEvWTNqVXZ1SDhDOEpoT2ZINlpwamJ6QlpG?=
 =?utf-8?B?KzVoVkNWNzBxSUZDbkZ0S2FOUEZCcTdJZWdTVGpHeWFSdUh3NDZTbnBjWnJh?=
 =?utf-8?B?dmVSdjkzd1pBUWJ5SkY2OW5pV0luUXhMeVFka3Y3dU5WY01IOTJUdUZPOGJD?=
 =?utf-8?B?L3NkVE5ON2ZMTUVmb3hsS2xVa1FmZitLYUFlTHdLc0V5cExxelhXNE1UajZr?=
 =?utf-8?B?OVd3clhuUU15d1NpeVBIMkNxN2E4VXVXL2krVmtublo3OHBNODZKOXZqQm1Y?=
 =?utf-8?B?OGRneDNiVzUrdXlUQmE2K1lPVnpqanNpNVN2QnV0RVUySnF6elpoT3dsY1l3?=
 =?utf-8?B?N21RdjBkb1RacERyN0pzQ3piOG1IbTArcTc0OVhqYkhlYytGSGwyajVob0dz?=
 =?utf-8?B?Zi9BR0ZqcGd3ZWNvakpsUGNCWXNBRkZBeTRjdzk0MmlMZ2FEazZHSWV6VkRZ?=
 =?utf-8?B?T040b3ROS0tFaUpOTUlRTUZCRktHYWo0bldsZHpUaEJEYUpTVE1GSkZnWEU2?=
 =?utf-8?B?VFBhV0cxSUNtL0VwOEVxdXcwZkdScmdTWlIzQy9qTisxSVg5dzR5M0JTTXFY?=
 =?utf-8?B?RkJDOGNqclZjVExmVjFLTkg0aUFocnFLNVVWTkpSbE9UZzgwMnp3anJxMWt6?=
 =?utf-8?B?ZUR2VVVtbHFnbzgvV0NkY0lOSDhTVi9yNmxnY1FYU0o3bENrWTJqK1hyTWpC?=
 =?utf-8?B?cXVBTExhdlJ1S2F3ZzBBMHBRZzltVDgwUkxRUU1mZW1tOXNGbkt4VjlZaFdF?=
 =?utf-8?B?c3pTZmFzM3IyL2hhQkd2VFpqemxqM1VndHRjc0Y1MWV6dm9ZelZuYkJRcTV5?=
 =?utf-8?B?cEErZnJlWDBLUnJvR2dIMUFGWVRKSFpFS1E2UzRVa09SbHV5MW1Xc0RQLzlS?=
 =?utf-8?B?THBHdzhhL2dGeThMaTdydEpHbjlnRFpkb3NpU2JYS1ZDNEFRdzRWS1lSVFZj?=
 =?utf-8?B?S1VsTjVvelVyalRxNTZkYUpEZWx4OEl6N1Z5WHAyQVpHanZzcG1RRjB6NkY4?=
 =?utf-8?Q?Rd1UDHGGV9+pHCME=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A6C1F2819ADFF641940CB822DEE77B85@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: CMiSfQ05Ouw7RqHgD72NHUgUo0oat0prsiGA+M+htAiq7MjRJ85SSFYhyMPW2iJAkw7w8rphYtTs458Ej30FoyJk3qwwiuIQ7vJC33htB5OZVJV2BOrACCb/XyHs8AJIEUkHsXoGkQhE3qozyIqdVDYRjCWA2924Mz8imqdDXKT2qjRqJ68w1m1+MFMhKbZljq6GlpcGhPysvYxwOZFe53GCgYt7Hi74J29cDHzvZB4BN3Ru3xGrUof9eWPuED6E5g4+OFmZzBOfpmUMF817ayNDPXOqgVLA7PHbDbXcTR8Gx98Co8D2Hc3tGypx0G4j8aklwBhUDwYBTqcoKTdIKg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9602171-4339-4b44-17c1-08de83a11d3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2026 21:15:13.6635
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GFinyGxQ0CPuNTgz55OlESopFbkaSIFY+jJq3veH0QK4IEH1F5oC1d4CnAKu/geAHBKFfpjxGUpdBpxmSzWR9NMirBs2Oqufm+OrcegM1Jg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6710
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI2LTAzLTE2IGF0IDExOjUxICswMDAwLCBLaXJ5bCBTaHV0c2VtYXUgd3JvdGU6
DQo+IE9uIEZyaSwgTWFyIDA2LCAyMDI2IGF0IDA1OjAzOjU3UE0gLTA4MDAsIFJpY2sgRWRnZWNv
bWJlIHdyb3RlOg0KPiA+IEZyb206IFZpc2hhbCBWZXJtYSA8dmlzaGFsLmwudmVybWFAaW50ZWwu
Y29tPg0KPiA+IA0KPiA+IFNvbWUgZWFybHkgVERYLWNhcGFibGUgcGxhdGZvcm1zIGhhdmUgYW4g
ZXJyYXR1bSB3aGVyZSBhIHBhcnRpYWwgd3JpdGUNCj4gPiB0byBURFggcHJpdmF0ZSBtZW1vcnkg
Y2FuIGNhdXNlIGEgbWFjaGluZSBjaGVjayBvbiBhIHN1YnNlcXVlbnQgcmVhZC4NCj4gPiBPbiB0
aGVzZSBwbGF0Zm9ybXMsIGtleGVjIGFuZCBrZHVtcCBoYXZlIGJlZW4gZGlzYWJsZWQgaW4gdGhl
c2UgY2FzZXMsDQo+ID4gYmVjYXVzZSB0aGUgb2xkIGtlcm5lbCBjYW5ub3Qgc2FmZWx5IGhhbmQg
b2ZmIFREWCBzdGF0ZSB0byB0aGUgbmV3DQo+ID4ga2VybmVsLiBMYXRlciBURFggbW9kdWxlcyBz
dXBwb3J0IHRoZSBUREguU1lTLkRJU0FCTEUgU0VBTUNBTEwsIHdoaWNoDQo+ID4gcHJvdmlkZXMg
YSB3YXkgdG8gY2xlYW5seSBkaXNhYmxlIFREWCBhbmQgYWxsb3cga2V4ZWMgdG8gcHJvY2VlZC4N
Cj4gDQo+IERvZXMgaXQgbmVlZCB0byBiZSBlbnVtZXJhdGVkPw0KPiANCj4gSSBkb24ndCBzZWUg
dGhpcyBTRUFNQ0FMTCBiZSBjb3ZlcmVkIGluIHRoZSBwdWJsaWMgZG9jdW1lbnRhdGlvbi4NCj4g
PC9tZSBsb29raW5nIGFyb3VuZD4NCj4gQWghIEZvdW5kIGl0IHRoZSB0aGUgZHJhZnQuIFNvIHRo
ZSBmZWF0dXJlIGlzIG5vdCB5ZXQgZmluYWxpemVkLg0KPiANCj4gIlN1cHBvcnQgb2YgVERILlNZ
Uy5ESVNBQkxFIGlzIGVudW1lcmF0ZWQgYnkgVERYX0ZFQVRVUkVTMC4gU1lTX0RJU0FCTEUNCj4g
KGJpdCA1MykiDQo+IA0KPiBJIGFtIHNlZWluZyB0aGUgbmV4dCBwYXRjaCBjYWxsaW5nIGl0IHVu
Y29uZGl0aW9uYWxseS4gSXMgaXQgb2theT8NCg0KV2UgZGViYXRlZCBjaGVja2luZyB0aGUgZmVh
dHVyZSBiaXQgYmVmb3JlIGFsbG93aW5nIGtleGVjLCBidXQgZGVjaWRlZCBpdCB3YXMNCnNpbXBs
ZXIgdG8ganVzdCBibGluZGx5IGNhbGwgYW5kIGlnbm9yZSB0aGUgZXJyb3JzLiBUaGUgcmVhc29u
aW5nIHdhcyB0aGF0IHRoaXMNCmlzIGFscmVhZHkgYSBzb21ld2hhdCBleG90aWMgc2NlbmFyaW8g
YmVpbmcgYWRkcmVzc2VkLCBhbmQgZnV0dXJlIG1vZHVsZXMgd2lsbA0KaGF2ZSB0aGUgZmVhdHVy
ZS4gU28gbWFpbnRhaW5pbmcgYSBjaGVjayBmb3IgdGhlIGZlYXR1cmUgYml0IG9ubHkgaGVscHMg
YSBsaXR0bGUNCmJpdCwgZm9yIGEgc2hvcnQgdGltZS4gQW5kIHRoZW4gb25seSBpZiB0aGUgdXNl
ciB3b3VsZCByYXRoZXIgaGF2ZSBrZXhlYyBibG9ja2VkDQp0aGFuIGF0dGVtcHQgaXQuIERvIHlv
dSB0aGluayBpdCBpcyB3b3J0aCBpdD8NCg0KPiANCj4gPiBUaGlzIGNhbiBiZSBhIGxvbmcgcnVu
bmluZyBvcGVyYXRpb24sIGFuZCB0aGUgdGltZSBuZWVkZWQgbGFyZ2VseQ0KPiA+IGRlcGVuZHMg
b24gdGhlIGFtb3VudCBvZiBtZW1vcnkgdGhhdCBoYXMgYmVlbiBhbGxvY2F0ZWQgdG8gVERzLiBJ
ZiBhbGwNCj4gPiBURHMgaGF2ZSBiZWVuIGRlc3Ryb3llZCBwcmlvciB0byB0aGUgc3lzX2Rpc2Fi
bGUgY2FsbCwgdGhlbiBpdCBpcyBmYXN0LA0KPiA+IHdpdGggb25seSBuZWVkaW5nIHRvIG92ZXJy
aWRlIHRoZSBURFggbW9kdWxlIG1lbW9yeS4NCj4gPiANCj4gPiBBZnRlciB0aGUgU0VBTUNBTEwg
Y29tcGxldGVzLCB0aGUgVERYIG1vZHVsZSBpcyBkaXNhYmxlZCBhbmQgYWxsIG1lbW9yeQ0KPiA+
IHJlc291cmNlcyBhbGxvY2F0ZWQgdG8gVERYIGFyZSBmcmVlZCBhbmQgcmVzZXQuIFRoZSBuZXh0
IGtlcm5lbCBjYW4gdGhlbg0KPiA+IHJlLWluaXRpYWxpemUgdGhlIFREWCBtb2R1bGUgZnJvbSBz
Y3JhdGNoIHZpYSB0aGUgbm9ybWFsIFREWCBicmluZy11cA0KPiA+IHNlcXVlbmNlLg0KPiA+IA0K
PiA+IFRoZSBTRUFNQ0FMTCBtYXkgYmUgaW50ZXJydXB0ZWQgYnkgYW4gaW50ZXJydXB0LiBJbiB0
aGlzIGNhc2UsIGl0DQo+ID4gcmV0dXJucyBURFhfSU5URVJSVVBURURfUkVTVU1BQkxFLCBhbmQg
aXQgbXVzdCBiZSByZXRyaWVkIGluIGEgbG9vcA0KPiA+IHVudGlsIHRoZSBvcGVyYXRpb24gY29t
cGxldGVzIHN1Y2Nlc3NmdWxseS4NCj4gPiANCj4gPiBBZGQgYSB0ZHhfc3lzX2Rpc2FibGUoKSBo
ZWxwZXIsIHdoaWNoIGltcGxlbWVudHMgdGhlIHJldHJ5IGxvb3AgYXJvdW5kDQo+ID4gdGhlIFNF
QU1DQUxMIHRvIHByb3ZpZGUgdGhpcyBmdW5jdGlvbmFsaXR5Lg0KPiA+IA0KPiA+IFNpZ25lZC1v
ZmYtYnk6IFZpc2hhbCBWZXJtYSA8dmlzaGFsLmwudmVybWFAaW50ZWwuY29tPg0KPiA+IFNpZ25l
ZC1vZmYtYnk6IFJpY2sgRWRnZWNvbWJlIDxyaWNrLnAuZWRnZWNvbWJlQGludGVsLmNvbT4NCj4g
PiAtLS0NCj4gPiDCoCBhcmNoL3g4Ni9pbmNsdWRlL2FzbS90ZHguaMKgIHzCoCAzICsrKw0KPiA+
IMKgIGFyY2gveDg2L3ZpcnQvdm14L3RkeC90ZHguYyB8IDE4ICsrKysrKysrKysrKysrKysrKw0K
PiA+IMKgIGFyY2gveDg2L3ZpcnQvdm14L3RkeC90ZHguaCB8wqAgMSArDQo+ID4gwqAgMyBmaWxl
cyBjaGFuZ2VkLCAyMiBpbnNlcnRpb25zKCspDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gv
eDg2L2luY2x1ZGUvYXNtL3RkeC5oIGIvYXJjaC94ODYvaW5jbHVkZS9hc20vdGR4LmgNCj4gPiBp
bmRleCBmMDgyNmIwYTUxMmEuLmJhYWY0M2EwOWU5OSAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL3g4
Ni9pbmNsdWRlL2FzbS90ZHguaA0KPiA+ICsrKyBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL3RkeC5o
DQo+ID4gQEAgLTE3Myw2ICsxNzMsOCBAQCBzdGF0aWMgaW5saW5lIGludCBwZ19sZXZlbF90b190
ZHhfc2VwdF9sZXZlbChlbnVtIHBnX2xldmVsIGxldmVsKQ0KPiA+IMKgwqDCoMKgwqDCoMKgwqDC
oCByZXR1cm4gbGV2ZWwgLSAxOw0KPiA+IMKgIH0NCj4gPiDCoCANCj4gPiArdm9pZCB0ZHhfc3lz
X2Rpc2FibGUodm9pZCk7DQo+ID4gKw0KPiA+IMKgIHU2NCB0ZGhfdnBfZW50ZXIoc3RydWN0IHRk
eF92cCAqdnAsIHN0cnVjdCB0ZHhfbW9kdWxlX2FyZ3MgKmFyZ3MpOw0KPiA+IMKgIHU2NCB0ZGhf
bW5nX2FkZGN4KHN0cnVjdCB0ZHhfdGQgKnRkLCBzdHJ1Y3QgcGFnZSAqdGRjc19wYWdlKTsNCj4g
PiDCoCB1NjQgdGRoX21lbV9wYWdlX2FkZChzdHJ1Y3QgdGR4X3RkICp0ZCwgdTY0IGdwYSwgc3Ry
dWN0IHBhZ2UgKnBhZ2UsIHN0cnVjdCBwYWdlICpzb3VyY2UsIHU2NCAqZXh0X2VycjEsIHU2NCAq
ZXh0X2VycjIpOw0KPiA+IEBAIC0yMDQsNiArMjA2LDcgQEAgc3RhdGljIGlubGluZSB2b2lkIHRk
eF9pbml0KHZvaWQpIHsgfQ0KPiA+IMKgIHN0YXRpYyBpbmxpbmUgdTMyIHRkeF9nZXRfbnJfZ3Vl
c3Rfa2V5aWRzKHZvaWQpIHsgcmV0dXJuIDA7IH0NCj4gPiDCoCBzdGF0aWMgaW5saW5lIGNvbnN0
IGNoYXIgKnRkeF9kdW1wX21jZV9pbmZvKHN0cnVjdCBtY2UgKm0pIHsgcmV0dXJuIE5VTEw7IH0N
Cj4gPiDCoCBzdGF0aWMgaW5saW5lIGNvbnN0IHN0cnVjdCB0ZHhfc3lzX2luZm8gKnRkeF9nZXRf
c3lzaW5mbyh2b2lkKSB7IHJldHVybiBOVUxMOyB9DQo+ID4gK3N0YXRpYyBpbmxpbmUgdm9pZCB0
ZHhfc3lzX2Rpc2FibGUodm9pZCkgeyB9DQo+ID4gwqAgI2VuZGlmCS8qIENPTkZJR19JTlRFTF9U
RFhfSE9TVCAqLw0KPiA+IMKgIA0KPiA+IMKgICNlbmRpZiAvKiAhX19BU1NFTUJMRVJfXyAqLw0K
PiA+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni92aXJ0L3ZteC90ZHgvdGR4LmMgYi9hcmNoL3g4Ni92
aXJ0L3ZteC90ZHgvdGR4LmMNCj4gPiBpbmRleCAwODAyZDBmZDE4YTQuLjY4YmQyNjE4ZGRlNCAx
MDA2NDQNCj4gPiAtLS0gYS9hcmNoL3g4Ni92aXJ0L3ZteC90ZHgvdGR4LmMNCj4gPiArKysgYi9h
cmNoL3g4Ni92aXJ0L3ZteC90ZHgvdGR4LmMNCj4gPiBAQCAtMzcsNiArMzcsNyBAQA0KPiA+IMKg
ICNpbmNsdWRlIDxhc20vbXNyLmg+DQo+ID4gwqAgI2luY2x1ZGUgPGFzbS9jcHVmZWF0dXJlLmg+
DQo+ID4gwqAgI2luY2x1ZGUgPGFzbS90ZHguaD4NCj4gPiArI2luY2x1ZGUgPGFzbS9zaGFyZWQv
dGR4X2Vycm5vLmg+DQo+ID4gwqAgI2luY2x1ZGUgPGFzbS9jcHVfZGV2aWNlX2lkLmg+DQo+ID4g
wqAgI2luY2x1ZGUgPGFzbS9wcm9jZXNzb3IuaD4NCj4gPiDCoCAjaW5jbHVkZSA8YXNtL21jZS5o
Pg0KPiA+IEBAIC0xOTQwLDMgKzE5NDEsMjAgQEAgdTY0IHRkaF9waHltZW1fcGFnZV93YmludmRf
aGtpZCh1NjQgaGtpZCwgc3RydWN0IHBhZ2UgKnBhZ2UpDQo+ID4gwqDCoAlyZXR1cm4gc2VhbWNh
bGwoVERIX1BIWU1FTV9QQUdFX1dCSU5WRCwgJmFyZ3MpOw0KPiA+IMKgIH0NCj4gPiDCoCBFWFBP
UlRfU1lNQk9MX0ZPUl9LVk0odGRoX3BoeW1lbV9wYWdlX3diaW52ZF9oa2lkKTsNCj4gPiArDQo+
ID4gK3ZvaWQgdGR4X3N5c19kaXNhYmxlKHZvaWQpDQo+ID4gK3sNCj4gPiArCXN0cnVjdCB0ZHhf
bW9kdWxlX2FyZ3MgYXJncyA9IHt9Ow0KPiA+ICsNCj4gPiArCS8qDQo+ID4gKwkgKiBTRUFNQ0FM
THMgdGhhdCBjYW4gcmV0dXJuIFREWF9JTlRFUlJVUFRFRF9SRVNVTUFCTEUgYXJlIGd1YXJhbnRl
ZWQNCj4gPiArCSAqIHRvIG1ha2UgZm9yd2FyZCBwcm9ncmVzcyBiZXR3ZWVuIGludGVycnVwdHMs
IHNvIGl0IGlzIHNhZmUgdG8gbG9vcA0KPiA+ICsJICogdW5jb25kaXRpb25hbGx5IGhlcmUuDQo+
ID4gKwkgKg0KPiA+ICsJICogVGhpcyBpcyBhICdkZXN0cnVjdGl2ZScgU0VBTUNBTEwsIGluIHRo
YXQgbm8gb3RoZXIgU0VBTUNBTEwgY2FuIGJlDQo+ID4gKwkgKiBydW4gYWZ0ZXIgdGhpcyB1bnRp
bCBhIGZ1bGwgcmVpbml0aWFsaXphdGlvbiBpcyBkb25lLg0KPiA+ICsJICovDQo+ID4gKwl3aGls
ZSAoc2VhbWNhbGwoVERIX1NZU19ESVNBQkxFLCAmYXJncykgPT0gVERYX0lOVEVSUlVQVEVEX1JF
U1VNQUJMRSkNCj4gPiArCQk7DQo+IA0KPiBTaWxlbnRseSBpZ25vcmUgYW55IG90aGVyIGVycm9y
cz8NCg0KRG8geW91IHRoaW5rIGl0J3Mgd29ydGggYSB3YXJuPyBUaGVyZSBhcmUgYSBjb3VwbGUg
b3RoZXIgY29uc2lkZXJhdGlvbnMuDQogIC0gS2FpIGJyb3VnaHQgdXAgb2ZmbGluZSB0aGF0IHdl
IHNob3VsZCBoYW5kbGUgVERYX1NZU19CVVNZIGhlcmUgdG9vLg0KICAtIFByZXZpb3VzIGtleGVj
IHBhdGNoZXMgaGFkIHRyb3VibGUgc29sdmluZyByYWNlcyBhcm91bmQgdGR4IGVuYWJsaW5nLiBT
byB3ZQ0KaGF2ZSB0byBoYW5kbGUgdGhlIHNlYW1jYWxsIGZhaWx1cmVzLg0KDQpTbyB3ZSBoYXZl
IHRvIGV4Y2x1ZGUgYSBmZXcgZGlmZmVyZW50IGVycm9ycyBpbiBkaWZmZXJlbnQgd2F5cy4gQW5k
IHRoZW4gdGhlDQp3YXJuIHdvcnRoeSBlcnJvciBjb2RlcyBlaXRoZXIgZG9uJ3QgaW1wYWN0IGFu
eXRoaW5nLCBvciB0aGUgbmV3IGtlcm5lbCB3aWxsDQpmYWlsIHRvIGluaXRpYWxpemUgdGhlIFRE
WCBtb2R1bGUgYW5kIGdpdmUgbm90aWNlIHRoZXJlLg0KDQpJIGRvbid0IGhhdmUgYSBzdHJvbmcg
b2JqZWN0aW9uLiBJdCBzZWVtcyB0byBiZSBhIGp1ZGdtZW50IGNhbGwgb2Ygd2hldGhlciB0aGUN
CmNvbXBsZXhpdHkgaXMgd29ydGggdGhlIGJlbmVmaXQuDQoNCg==
