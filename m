Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC452AD35
	for <kvm@vger.kernel.org>; Wed,  7 Oct 2026 04:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791347374; cv=fail; b=cmiqPn0bVeKkHFue5RHLCWq7rRj0NM3snHixiJ2pPVuKQo1ZdQUNW/jytpdxhZJ40x8cLRmT1lnl5+H/Z6J+SsWhIiDjde1TvK2ZrdbIAfNn49vrO048ZXYjXjLMb7fROvrfQ9Db7TgCI0nNi2C8KnXPv4V9eIgu4Sl7q57+h2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791347374; c=relaxed/simple;
	bh=P7dfHyPSHixoDKQ479y/RXS2O6ERyPiSTOzYXKlESX4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=frWCByqVwoj/YPSxQOB9iM5RM5Dl2gzUkIJPpAY6VentqX13zZfMJLX87+/e9AG4sdJX2b2q6JQ70zOqXbI+2lJUWZAzkNFmd2I0TDOWysuC76ivfbt1oVCtYQV3i7wgkySh1fw5fBk8rzvfK3PRDmwadQzMHHvdWOBQbees/1k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oFYpF9FK; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oFYpF9FK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791347373; x=1822883373;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=P7dfHyPSHixoDKQ479y/RXS2O6ERyPiSTOzYXKlESX4=;
  b=oFYpF9FKYj+fKnEFDm4fwYLJ18VJGj+OKkXvFnWYBNWRSYG923MI3UgO
   mR+cSql1ZqhHZuyIVCLf/+BshpUw0evf1q9uMy3qjGNIhmyc7fFF49XsC
   m8limMWemAb+EvV9oFmJe+tZuTmdRYReMxDLAy8cLPXk5PfjAZPO3vc6K
   rd2hYjpVYUPECJ9QIwz0yxh5GNoFWT5ILr6Gnic622PQuW9sOd6T12UFt
   c6JgRgpkmWcw5TV8AYk0r6WY9BzDgE+EKaBdCN6OFYkHEbwc+ZsOI0tW0
   xh84fu2hhO5cs/EPrJFF9xWKqMVb+yvQT3PuqyY0v4GE4KnU0xTZhYwWW
   Q==;
X-CSE-ConnectionGUID: 6ZodJDMPSWaZnLL+ewKJoA==
X-CSE-MsgGUID: 9iPqDouJTOKXWA+cCS9jAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11927"; a="199488"
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="199488"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2026 21:29:32 -0700
X-CSE-ConnectionGUID: LMBM2O8vTKuv0Ygs5szSwg==
X-CSE-MsgGUID: 8mjv2ngHSgqa88JbOhwYDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="79528"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2026 21:29:31 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 21:29:31 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 6 Oct 2026 21:29:31 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.41) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 21:29:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IVa/2KbIOqRiBwShfi5qX89PXBZiTSlH3UXL5qEIXXIsBFzJmL/5OzDFHx6lTVjQCk/b6jT2a3NL6i47WUEJ+Ov83gjYn3uZSK2IPktKao1DJTWBvO7GZQiIxTDg2QwR0rB4++FFHRf2mBOWK2PgXpMvfS102D17lkgzeEVFRVDYWFSvbAPOpCKjItrgkIQH65Alu09vdQ081a82I6S5JG8kyBeN0T9Dq+gaiF42H5y/EzBecla1HmhqNPE3f5Wu8XS2H+8gDTfuPublvKkEF6BgcA0RUbVSUA6qTdt/YhFC7lBIMOGtH0O4HR1RO3fflegbBP/U5I+DiNgecPr7Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NnKerWQrAPYiD/Y5bk82dSqmQgdojsEMhClYeDPBisc=;
 b=DlEF3r5ghAbHTmQRFwP43NuP4hym40O4yr/70LxWDjjLUejbJCdeMyvE8ClGmcsrv/6xPfBtlNwTCeXLL2/3MO1bmBn5VjlpHSivENRJWk+vOEFUuUVgL8PUlrwUblJt8egN1ANu12b3DnhU6RX+QDhGCq0vwahWHJb4zD/VznfhvqOlAVmDNmKbywMsdXUK17NE+Q/jij1/yoWra1in4jtkA9OGjekWzE++b9iCWBDuOskZcfna6AEpy4epgKp6vVNA5ftxYzQU/GakSUPqinl0g+IuidYXJ55zk2fzsg1M9hdLhWCduq2smojK1xWXyPKMTYdsLLYr6EvXRDCJcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8050.namprd11.prod.outlook.com (2603:10b6:8:117::5) by
 SA0PR11MB4606.namprd11.prod.outlook.com (2603:10b6:806:71::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.18; Wed, 7 Oct 2026 04:27:57 +0000
Received: from DS0PR11MB8050.namprd11.prod.outlook.com
 ([fe80::f099:a504:2ad6:1d12]) by DS0PR11MB8050.namprd11.prod.outlook.com
 ([fe80::f099:a504:2ad6:1d12%5]) with mapi id 15.21.0496.010; Wed, 7 Oct 2026
 04:27:50 +0000
Message-ID: <30006d88-6679-4274-87fe-f1ce8732577c@intel.com>
Date: Tue, 6 Oct 2026 21:27:47 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/4] Add KVM API for confidential guest live
 migration
To: Peter Xu <peterx@redhat.com>
CC: Artem Bityutskiy <dedekind1@gmail.com>, Tony Lindgren
	<tony.lindgren@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>, "Sean
 Christopherson" <seanjc@google.com>, Fabiano Rosas <farosas@suse.de>, "Jon
 Grimm" <Jon.Grimm@amd.com>, Pankaj Gupta <pankaj.gupta@amd.com>, Tom Lendacky
	<thomas.lendacky@amd.com>, Marc Zyngier <maz@kernel.org>, Oliver Upton
	<oliver.upton@linux.dev>, Steven Price <steven.price@arm.com>, Anup Patel
	<anup@brainfault.org>, Samuel Ortiz <sameo@rivosinc.com>,
	=?UTF-8?B?SmFrdWIgUsWvxb5pxI1rYQ==?= <jakub.ruzicka@matfyz.cz>,
	=?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>, Vishal Annapurve
	<vannapurve@google.com>, Elena Reshetova <elena.reshetova@intel.com>, "Kai
 Huang" <kai.huang@intel.com>, Mika Westerberg
	<mika.westerberg@linux.intel.com>, Peter Fang <peter.fang@intel.com>, "Rick
 Edgecombe" <rick.p.edgecombe@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
	"Xu Yilun" <yilun.xu@linux.intel.com>, <kvm@vger.kernel.org>
References: <20260831071304.762939-1-tony.lindgren@linux.intel.com>
 <d78207fcc5936b5822b708238d862b0e10f9f5c3.camel@gmail.com>
 <aqxbMGLwvtT8zkEb@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <a4ec3af5-5494-4fb4-bf66-e3a8b67325e3@intel.com>
 <arRGYbvXgq8LLYQH@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <9fa229ea-818c-4ba9-81c6-be7ead5cb60a@intel.com>
 <araC0YkwLVPhGfy0@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <784c4ecc-da9d-44b8-9adc-1d1e92d20ae3@intel.com>
 <ar10Ncg2-GhzgBR9@zhexu-thinkpadt14gen5.rmtcaon.csb>
Content-Language: en-US
From: Kishen Maloor <kishen.maloor@intel.com>
In-Reply-To: <ar10Ncg2-GhzgBR9@zhexu-thinkpadt14gen5.rmtcaon.csb>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P222CA0030.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::35) To DS0PR11MB8050.namprd11.prod.outlook.com
 (2603:10b6:8:117::5)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8050:EE_|SA0PR11MB4606:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f123c72-04ef-4e0d-6950-08df242b5884
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|23010399003|10067099003|6133799003|56012099006|4143699003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: DWdyAs2LUoseDWiU6cyMr2wHkMRHuAuwA/82vB9B7Zaje6/wz9kG+Iewu4E3W+a2uUrQDPIJYaFbyIjpLT4S8g7/9/D8OEjEEmifENju5V3gkd5XtsTPRdp6qKqkKDWpP46XcJgkpZaATO1eM3b29Vi8+95cnfIn4kVZ1Uv4ai+/gKtOf0fuN1Nut8MCTCVSgMtpy+TJmMJ1KzNrn7I2VEyR1/X0JPSJXyPOFtNtl9hOeZzDN45UkVA6T+SR9bg9vZENfT0S8q5XDVDPBr1FQT2C+Q/6g19EhobishidWDXflk43EHQwcTusd3lWsd6O0nlD3bOh4VLCNCHweJc7xPBwUGqoABpMK9MHSnLzKkaaMNP0MJQc7JglyMtiGKFQs78sSMa/ocfuo1UA6p1w1AS2bDLc9geegiOZTRBEc6hqT2w7KA15b+6vgD2p1i3VIWS9r3/nIEGRj2v4/nLfZeJxQF4LaqnShwRfluz1X8K/87Um2RpD08iSGIcbNkk+mCuK0lJlIs8y6tLI/sm7G5zMlXY9EwBQxCgSSrmkVqnPkhyIlY/hyNJrbnbF8W0gxPmKiQDmZNp/WyNWbKODyLuZ5t66ll743Lulpw4q/V4uhgwkUzjgheFs3NXobbjdVanK9XjweUsqXjLUtKc1p0zXvpNFJGYnjm+85Z41CDI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8050.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(10067099003)(6133799003)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OG8zWWY3ZTBWak1CVi9nQUIyQkttTXk4Mjk2VGcyYVhtVm5ReVpKS1FFZlBa?=
 =?utf-8?B?bThZYlcwcTE4SzdKSnBqS0FMMFJaaHdUTWYxTTVGVjB2S3YyY25qOGRNMWxC?=
 =?utf-8?B?eSthZThvYmlzWkI5RC9qT3pJZDd6SlFRbWZrcWszc2lBQkc5cmxvTWc0Z2sv?=
 =?utf-8?B?bFM1Y3JaU2hCc0JHZytWS3hsZTVPdTVtUVBCSlFRMjhvOUYrSmthd1VBNlho?=
 =?utf-8?B?c3pmSnJQNzZ0cEhWUVV4K0pwRzVBOTdRUmxDMkZMZVk4S3VPdWFxcEZCN0RV?=
 =?utf-8?B?VGI3SVd1VjNDOUlDRlJ5S0ExdVFrak5Sc1NpRHBtVUFsVnBpSDFEekhDYmsy?=
 =?utf-8?B?dHdSUEc0WmNTa0pFVytXMWlFK2Z6QW54b0k3dmR6d2tqbk5nOGNHNnVJb0JN?=
 =?utf-8?B?eVdLeWl1d3VWQXdBSzcrbmRGN1FDcXFQcGM1SVNldWh0WWlSR0tqakpDOERr?=
 =?utf-8?B?UDlLazJPdXMrV2hLbk1QQ2RHSnJyQ05Za0lWQTd5T3JmV25Eajk3cmJiUE0r?=
 =?utf-8?B?K2JMc0xRN1NxaHRIVml3UytCZ0x2Tm9yRmJCZjFJNGNXY0NSS3hTZFlxU2xL?=
 =?utf-8?B?Z2RCME5KWlpYMHQreGNIK0lIVExCemJEeGVtdDdLMlRpMkFDOEhJUFZDK1dq?=
 =?utf-8?B?a1VMVGdzaXB5aCtVc2pZbTUxQUkvSm5ja2ZTZ3JCQTZGa00xUlVnYzIzdCtO?=
 =?utf-8?B?eExXUEtHYXlLQjU0bGZ5QmRETi9jY0pXREFkTEh2TGVaU1BaT09KdUZ5L2ZC?=
 =?utf-8?B?MzdIbU00ZGVVclhaclJqOVQzMmxsU2oyS1hRSkkvaCtjVEN3TmZCKzhCSFYv?=
 =?utf-8?B?amQwNDgyd29TZ2FMY09Pdm9RQ0hXQnNSamhpSnlnU1V0ZUJ2K2tVb0Z0U1Z2?=
 =?utf-8?B?dGRtVEdObldPV1psOUZSY0tjVm81MUsxRCsxenRkLzBpWDlOWFlQYlNzY1FM?=
 =?utf-8?B?RWIrT0hFMFpkMVoraFdYUi80UzdkMXc2TmsrQmRlU055VkpIUGg2UU1ndE9y?=
 =?utf-8?B?OFhId0NJVEJRSXNEd2o0SHJoV1RFZVZHT3psTnBlMEgxcEN5OHAwc1RkSjl1?=
 =?utf-8?B?R3VjdUJzVTJMSWNnVnBaWVFSMzFpNEwwR2M4ZTFHamFtYW9QT3Y3VWVpcURw?=
 =?utf-8?B?aUZScTl1MUlXMTJIcnhvVThSSUpTeVdINDBXcnljWGFCZDhmdUp3eXRveTdl?=
 =?utf-8?B?TEQyYklGQTB0MUprV3AwUVhib3dTUTIvRVZRSDRYcHRxa2FteEtha1JUeC9T?=
 =?utf-8?B?elBqYVBEdUk1aXkzbHZKTk50OTR4WXpHVkcxRzM1Y3M3ak95NjIyS0lOTkRN?=
 =?utf-8?B?RmF1UUZWN0pkZDg0QVpnQ3pYRHlRaStpYjREWjBnQXowQ3o3VnNGdkViS2lS?=
 =?utf-8?B?WjNIYjZ0WDR5Y1JQdVRLQWN5MTg1UHhVSTBjTWtUMUlRZFllVGpVMXlHLzgy?=
 =?utf-8?B?UnBhbzNxbDdPeXlQNEtRaHFOTkw5TkFsLzlqcDJra0FBTi9YQU5BQk1UcXJi?=
 =?utf-8?B?eG5wR3VFRDluVG5EU2JNcHdQajVQQzhReXVUaFoyMEs5RmI0ZDZnK3FEdTRH?=
 =?utf-8?B?dThBc1pKUUxqUUJPaXdXaEUzQVFoVVBLa0pEVE5VRXVqUDdHb0RQa1lYNE45?=
 =?utf-8?B?aG5GbDRMdE0vVVFya3NsUW1hVi9JSVd3WktYeitGRE1UWUFDYkhqaHVZTFI2?=
 =?utf-8?B?YnFLVFNmSy9ONjNMTzNXYUxlcnFTemlrcVVkOURmK2pTajlzUnhtZjh4VnFm?=
 =?utf-8?B?R2o3cHM1RWtVNWt0RkJHeWJHSkdHR3U5UERXN2drMHRQZERBK1I4SVc0dEhz?=
 =?utf-8?B?cExTdVdVdjZpWENVWkx0NC9DMXUxU2tBalAwQXVlais0bmZScWdpL2RyTmhE?=
 =?utf-8?B?cm9vZWdBRTQ1dm1kYVpZRFhwbFhZRTAxK0RvSDM1NnR3bFp5ZjMzQkxsOW5u?=
 =?utf-8?B?UEJBc3hHVmFZTGd6dlB1RklIaHFxU0VCUktUdVI2cTh3M2pmZnkxSjdvUktD?=
 =?utf-8?B?Yjd5S0tFVm83c1h2S05xeHp2MUpaUHpSRjdkNzJUeXpCVlRPNlBXY1NHSFQr?=
 =?utf-8?B?eUZTU0o3N2FEb2hyOTBYUHVTVWN2aXluQlR6dmFpVFd1eE1LVHVnM1BMRkxH?=
 =?utf-8?B?NzExaEtuN204NllSa0JGUHQxNDN2bExwREhlOXQzRXBpYnQ3QlJ5R0RPcTVv?=
 =?utf-8?B?TldvbHBsc2pPZVZza3I2TE9vZjJQYzMxVWRoWVQwZmxGcjR0TUwvRnhTbURR?=
 =?utf-8?B?YU9yWXBZQVo1YzI4cUhsQ080MkI5U1hBc0JaSmFxK1p0eE1YMUFKK3hvSnhT?=
 =?utf-8?B?QzljcVpLNzQrcXo2S1o4MEtkdjU4NmxrSk1vT0ErcjN6eEQ2VWVTdz09?=
X-Exchange-RoutingPolicyChecked: kd0xTQ3DRQZJK0YSV3ndHM8fUvlB4I5YDh/VbFWPzywdzI0Y6vtgipbfd0YSGgXUFNIgpQuijF8aoJdwJfdEOhh7SZKRzXl65dtZxOs9SIM6StxhUxRUM6hV0I8HaKl6PgWSrh4avg9mrHlkF1fRhztC8xFnbDd8h/Dh60D5oxRyT0YMMqQQmbpahmCj+v95K/lEE8/C4w/2O46fyPK5uIBHQVFMBE0OJ2HoH20x9ldryQmAWiXdKDOxjIh301nXUgEmRZnZFj4BGPxeZhwJbwBw2J1+9w2pUzM0KdAGgpRf5kHrdYa/i/DMzKcoZ6lTQ/dJbz2rSjd1+GK3hT+2UQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f123c72-04ef-4e0d-6950-08df242b5884
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8050.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 04:27:49.9417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s3MXQJ2yuuE4C65bB8OugQplyAXJGRLE4CrRHEbZUgr7i/x0V8SE3B+DZyXmZf8LprgwcQcRW+tuRp5FM9+ngw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4606
X-OriginatorOrg: intel.com

Hi Peter,

On 9/30/26 1:42 PM, Peter Xu wrote:
> On Mon, Sep 28, 2026 at 06:28:39PM -0700, Kishen Maloor wrote:
> ...
>>> So it seems TDX will "lock" the memory footprint in place when enabled,
>>> allow accept/unaccept (or say, plug / unplug) memories, but anything like
>>> "flipping this to that" will not work.
>>
>> Yes, I think so. The TDX module holds the GPA->page binding, so any change has
>> to pass through it. Adding and removing pages plumb through the module.
>> But a sort of content preserving remap of GPAs in the way QEMU does for PAM
>> is not possible AFAIU.
> 
> This still looks fine for TDX then, but I think we may want to make sure it
> works properly for all the rest consumers of this API that we're aware of,
> say, AMD, ARM CCA, etc.

Agreed. It really comes down to the shape of the other migration ABIs out
there.

> Especially, MEM.IMPORT seems trickier to me: MEM.EXPORT even if described
> in in GPA address space, can be converted to other address spaces at will,
> as long as QEMU has full knowledge of the mappings.  MEM.IMPORT, OTOH, may
> not trivially work in GPA terms, if memory mappings can overlap.

I can appreciate that. Working in GPA terms assumes that a GPA reference is
unambiguous over the duration of migration, which holds true in the TDX case.

But it would break if another backend is able to point a mapped GPA at a
different protected page while keeping both pages valid -- essentially
the PAM case on regular VMs.

One option that comes to mind is to add a 2nd optional identifier to
kvm_memory_transfer consisting of a guest_memfd fd and an offsets array.
That would be at parity with QEMU's block+offset and directly reference
specific storage units. Then QEMU and KVM backends for a platform would
decide what identifier to use.

The value might be that a bundle could be accepted by a backend for
storage that isn't currently mapped in a memslot.

OTOH, slot+offset as an identifier might face the same problem as GPA in
this case when a particular RAMBlock's storage isn't mapped at the time
on the destination.

Not sure if this idea is viable or even makes sense; this is mostly
for discussion, but would appreciate your thoughts.

>>> Then there's a very corner case question I want to double check, and I
>>> apologize if this is stupid only due to my ignorance on TDX knowledge: can
>>> someone migrate a VM too early so TDX is just hasn't been enabled at all?
>>
>> Not a stupid question at all. I've actually tried this. TDX VMs appear to
>> migrate fine beyond a certain point mid-boot of the source. Kicking off 
>> migration any earlier causes the destination not to resume, even though the 
>> migration itself reports success. I haven't yet confirmed what that point is
>> to explain it.
>>
>> For now we're trying to settle on sound fundamentals for the UAPI and flow,
>> but this is definitely an area to dig further into.
> 
> Ok.  Before any fixing lands, perhaps one can add a temprorary migration
> blocker in QEMU and remove it after that mid-boot phase.

Yeah, possibly. But I haven't seen a TD boot progress hook in QEMU to place
the blocker removal. We might just have to chase down the underlying
issue for clarity.

>> ...
>> With a single channel it shouldn't matter, but it could with multiple
>> channels. I think since the bitmap sweep is shared with multifd, QEMU ends up 
>> transferring a page only once per round either way.
> 
> Normally, yes, the scanner submits pages to multifd threads, the scanner,
> if scan one round of bitmap, can only submit one page once until the next
> round / ITERATION.
> 
> But it may also be a matter of how that ioctl(ITERATION) will be done
> inside QEMU; I'll need to reference to the QEMU PoC branch when ready to be
> sure I have the correct understanding.  E.g., IIUC that ioctl(ITERATION)
> needs to be done similarly "per-round" here to make sure one page appears

Correct, ioctl(ITERATION) is also done at a round boundary.

> once, and we should also always keep in mind QEMU can still have
> GET_DIRTY_LOG run in the background concurrently of the scanner, as I
> mentioned that too somewhere else (which means one page can be dirtied
> right after sending it, but as long as the scanner moves on with the next
> page it looks still OK).

This should be covered. TDX requires a TLB flush following a scan so
subsequent writes would be caught. If the write happens before the page
is exported, the export fails for that entry with a PAGE_DIRTY status; if
it happens after, the dirty bit is set (as usual). Either way it gets
reported in a subsequent scan and sent.

