Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64513B8BDA;
	Thu, 15 Oct 2026 14:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792075065; cv=fail; b=iTzYiRB1c9DlcK/SAkA7d5/kTUfcKvIebH8mi1Hrrfw1Y3rOr65zv5ozc0KFcY1UCWi3vHWDOsXwInb9iJFg9GfHAp/g3ZjBXrynDHEqe724onm5QMsKHHZyORfLEAB4lGR2mm2SdThjhmVErko3tFe7pxRT0c33GbvfXK9Z27s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792075065; c=relaxed/simple;
	bh=2jvvYTr7AOLSfdfULOOBu6oDJQSax8cfyWNEBMt/tXM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Bz93S5cy4ZW+pb9njTPhsN46tviKCGS0WpDJXfo/Q2HRPpm3tOBnajlQqXCxiQLVEhBItfCJ9ESNoKEZxSfBm2IlToyPXzzNVLae26fEonlS+z2+RezIQG4PTp7YBO+1r9GdmdUtJxvtYvPbpQct06bcABsMKcEAszAklWby6vA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E0lSq/HT; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E0lSq/HT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792075064; x=1823611064;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2jvvYTr7AOLSfdfULOOBu6oDJQSax8cfyWNEBMt/tXM=;
  b=E0lSq/HTnq1yIXUgo/EY+/dvdqPet+oPfL/T/phx7KXqHtcEdjTvBmIN
   BDJQwYwq980NYqxnNg+erPqn3IaOW/ty+c6zBmJVpkQKZh9amxQr6PrHW
   Ip+HNanZRJPha84jR0wPYCShu0QFFHgze2q2dsGZs3hkIgMcaAFjWjKrn
   /tSSSgF9cDBdT9OEh/cWv1nFu6Ve25EWjx959XhR13QAVO+ZdVrVvsedl
   vNqtMofQfedkNDHjKoqpeLjTYmKBdHq2kdhGvWlXimuFJmx899UtlTdxa
   2J4Vy6tsnVb5LNdikLsqSXdYUpxjVTCgUde2nAt4ftQkkjT1HlusBkgF8
   g==;
X-CSE-ConnectionGUID: 20XkKwiLRH2Bb34ii9KVAQ==
X-CSE-MsgGUID: ErISatbOQpGULfiz13PNIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="950927"
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="950927"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 07:37:43 -0700
X-CSE-ConnectionGUID: SeVteQp5QNe1p9FSlJl46w==
X-CSE-MsgGUID: FlLShFbsQ3W/rO/UjsfNTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="1725338"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 07:37:43 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 07:37:42 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 15 Oct 2026 07:37:42 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.8) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 07:37:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f9ns4Z1OqX/6AJOLcbTASAm2jP+T1k8u0oWF+YOW9kf177L0hiISTf9Dce/BMYh0F+q1n7Il2TdZ68pEFrpotUqtrprX9Vcbc2ykj9Vj/u4BxXt7hZsOg7qrBGhLF0/wrarBCP2VSnwkoyHO+llRPnVQjhN/2pVDgjy35m5d1j22b1FbF/fEkwqMoKdK4mcns+Y1ZYc3U918X95qxAMH1hF2LkrOmbatsZmtwzk5ojQJFevQLSPoHTbtn9i9GMwZAelMwkF+TtWzW9ZvSd3wYzQRte0iTr8Gy7RgdfQ1tmFAJEYLS+BJbvZ0EACBhlWfGOuFKyKVEB59wQx7whwN5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TuB7FDlIb3w+lZvgnLa35gjHD4tEjmtu/N4bMSXZvOs=;
 b=RFo4i3BslGvk1Lp7OMSDfPdc6dNPjlhBpFi576ip9962C/uzqsFrhv/QmR9+qzgKi/4UYO6x7HzzD9cRnh1kXrxoT0SI54Eoc/r7tYp8rOBPOBgfdguY2Yv8R5c23xDi8z2Z6wbNbjF5pqNZMs7W3+9sR9S5NW+NKPac/6fEaAN2lW6e7gpknJX4uMj7+Y0mNeV1t9EmBjqCQI5xtqJ6blNT6/WtWEeTtmiQ8b9R6HROCoLaaMBHH1KSidXGt4gyybytWgSut2MRvkWA8Q7nEogLRN2yp+SXr/2F8hRvIGh3JHTp6SvaFf7Bc8FU8vLPD9fkml5h2f4LyeP+jP8PjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB8370.namprd11.prod.outlook.com (2603:10b6:a03:540::20)
 by PH8PR11MB9952.namprd11.prod.outlook.com (2603:10b6:510:3d5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Thu, 15 Oct
 2026 14:37:39 +0000
Received: from SJ2PR11MB8370.namprd11.prod.outlook.com
 ([fe80::b6cf:ce77:3cdf:7cc]) by SJ2PR11MB8370.namprd11.prod.outlook.com
 ([fe80::b6cf:ce77:3cdf:7cc%6]) with mapi id 15.21.0496.021; Thu, 15 Oct 2026
 14:37:39 +0000
Message-ID: <b2c67318-b52d-440d-bf40-fde40b47ae07@intel.com>
Date: Thu, 15 Oct 2026 07:37:35 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 06/18] fs/resctrl: Introduce kernel mode states for
 resctrl
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
 <d98872b26051bfad280f72da3bcddea1e978b37c.1790867441.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <d98872b26051bfad280f72da3bcddea1e978b37c.1790867441.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0292.namprd04.prod.outlook.com
 (2603:10b6:303:89::27) To SJ2PR11MB8370.namprd11.prod.outlook.com
 (2603:10b6:a03:540::20)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB8370:EE_|PH8PR11MB9952:EE_
X-MS-Office365-Filtering-Correlation-Id: 62d752f3-03a3-4727-a19c-08df2ac9dca8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|23010399003|376014|56012099006|10067099003|4143699003|11063799006|5023799004|22082099003|18002099003|261009223027099003|6133799003;
X-Microsoft-Antispam-Message-Info: SDlqjYUO4sVc0TuUUbJrVMY/8//YwTy5T6MOurKE94pB3xSd1yr/KM0L2gfoxLvIxn6oAf8msnMWq9Vyo/nVy6io8Y4IwwYDgftkKTOzlz8DYcMTeTK1DD3Tk0cNzviqG8XMxvs1a1yMF8ZQlMONua9AK89w3h7POIkHrfEMQbEcOB0ngMh3pAS6O68qdnqCimE9+GNAq57Q9Q3WRNOmI0b3OnNpTaKvN6zJABXwm/H4w4BIHJy/1Ycaqvjcu3VBFp/wxSXrDQtLl9lBM1WE+XAE8KUu6TFF7a5nYcgBx01mT6p1YvW/HVLwREcFiBLv6qRqQIUDmdn0ETWzbs6Wp5vtKQOz3SEj0gTJrFPgNBALv6leUzPFZxNtW7siuc7CtXzci7QT2nfdxw8NNeCqN0w6n8dJSn5kAj6catx3B3Yqh1aGq8CxTMlKcss2KPirik5F/ILYvIPt+6bFl+uTbuFYqLr8q29J1Bi2G38AO+Ooav7Xaoxmmv63MAszWMFfPrjFtd59j5hFxjn5BQ6mUfnwuqKfQUSrNqJ6kgWngz/8JV+sh0uVmXtwWQFM9q9L0C7UQY9EcwGvPoIWpMMSEee+ic2fnpWmy8tHipx84bqKQTFSwVWj2h03rkeMSR0V
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8370.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(23010399003)(376014)(56012099006)(10067099003)(4143699003)(11063799006)(5023799004)(22082099003)(18002099003)(261009223027099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VmF5QnNra0hyVXlHdkxhZW5PNUlSQW0ySnBRWlJwTkd1M2xBYWx1V0xVWEND?=
 =?utf-8?B?czNzWFNjeE1MV2NnSEJVVitVcXNxS1FKR2Zobk9DYTRZZ1RGQnZwbFpaSzlP?=
 =?utf-8?B?VG9ROWc4dmVJUTF1QVhjSWZvNldqcjZOL3dCVDNqc2FYTk1YT3Z4SFFzQ01w?=
 =?utf-8?B?TzdCczNpeEtXU3VjcDhPVTFNSDBreHBxSDE1SDZGMHpvTzFRVXd4RkRjUnNX?=
 =?utf-8?B?WTJIWnRtb2hWUDdaL1l6T0owam1yaldyZXNqb1I0WlhsTGh3Sk43bmxYSHA4?=
 =?utf-8?B?YWFXYTAxVEU4RkIzMnJxWW1GaWxMbm54alpoWURLNFM3cEM4RHBGSWdFNkZN?=
 =?utf-8?B?TzRpVDc3dDFmVnlxOFA3bVRPejVLNXc2MnUyZCtUOWZGRFlIUngwSDdYNm9J?=
 =?utf-8?B?eGhXcXdoMWYyWWJ4UnhzaGNkbEtkbDgzSGYrVGFZYWFaRlVGZ29CWjYraERm?=
 =?utf-8?B?Ky85Q2ovWUFyU3luVUJGdTJhUjU5WVk4d0w3TEVzRHMrMHhrWmZTY3AwOEhy?=
 =?utf-8?B?S1YwdzBVM3BibWNSbkp1RTF4VFpCNHFMTzh1VzlFSEY4eU5FeS9vVlpNdXlI?=
 =?utf-8?B?akZpMnZteEJXNkcxSFVORDh0SmZZL0RRMEtCek5tYWJIMWxRV3dCSitpT212?=
 =?utf-8?B?d1pjcUljMUFUVng1eWw5ZlVCcTJudmZlUHo4c2JLSjBPMGJPTEtQVno0YXY1?=
 =?utf-8?B?RmpJa3ByU1IrTkViY042aHJ1Tk44R044TldreC9YVlQrYVMzc1lKUkRVMjdz?=
 =?utf-8?B?YjFWT3ZsNU5ERlgwTHU5c3lMRGx1UTRlTkdFL0ppQWlBclI1M1JtckhBdktp?=
 =?utf-8?B?dmx6MTNHRDZtVmdRY0RTT1ZyUEJqaGUyMDQ0clVXMWczZDh4UEpRb1JaWjBo?=
 =?utf-8?B?OWNUam9mQUFRRWNOdkNZVktUZlp0allsanR0aUZKcWI0TEVEdEtCNlRGSTh5?=
 =?utf-8?B?Q1NibTZpOXZva3hmcUFEeEZuUm5lUmoxT1dvVzJDcDg1eUx3RXJwV0haTy9z?=
 =?utf-8?B?eEZ2dFc4dlhXT21nVTdPc1Z2NE5XN2lrcTl6a0t3WndVMDZ0M0d1TjhHMSsv?=
 =?utf-8?B?TXh3OURMbHRPZUdiM2pQMzUybTNLdFFDZ1h0M3NOTmo0RHgvckJEVVJhTW5i?=
 =?utf-8?B?Q0Z3V3NJSGxLY2cyeTRqVmt4dnZ4YVphMVQ0YjV2YjE5NFZUNUl0S1hTamNj?=
 =?utf-8?B?TDlCcnhwWnNvb0tDREZlY0NkYzcrbUJDS0dXb0p6STJBc2hGV01wa3U4dWht?=
 =?utf-8?B?Vzh4WmlVTWpabUJIcmF3eDM2emJnNitCVGlZbkJneHowUFpkajFkaXlUazNL?=
 =?utf-8?B?Mmw2OTlXdEo4V1drWmpoVHkrV2E5UTZiMEs1cWlRRFFFN29adlNHZGVYdTNZ?=
 =?utf-8?B?RUNFQ2U0aENYWFI2K3d2dEZuekdWeG1VZlZ3YzJ0U1Btb0VXSWlCNkxMN3ZZ?=
 =?utf-8?B?SzV3b0wwWFc4QkJCV25SZ2JuQUlXSFdJRmxBN2JJTWN1NDdacEY0dUNPTXRt?=
 =?utf-8?B?d0laVGtWaTFUZ1BUNDExQjJpM1R2L1FBVjRUSmdqUmZvVUpodFJ6MzNjV0tw?=
 =?utf-8?B?czN5MlBzcWtoV0EvMGkrNE8yMDBTRzI1M3RSYVA4VWFMc1BZdTFramRodlNC?=
 =?utf-8?B?SmZFaUxQNVVjUDVQL2h6eVJoNm9zMDQ1K0xlZUJOZ01ublllSWZZQmJzd1pn?=
 =?utf-8?B?Q05xcjBQNkZhSFlmTlJWQ2RSSzhYUXhham1taTVRcnlsMW8wZFN2ZSt2UXJJ?=
 =?utf-8?B?aDZlWEhEdnZJcE9EWTlGTXIyR1hOa251R3BldWQ1Y0pOVkpBc0U2OXI5anJQ?=
 =?utf-8?B?QTBVV1FFOGdkZWhFWnlQYU0xTnd4NEdBdmszcU81N1NNSndpYWxGWDRjZjBP?=
 =?utf-8?B?aDc5TXp1R2tJWGxJMzAzdERRcmJkRTNqM002YXZXTVVtQW5tR3hjRTRsREhO?=
 =?utf-8?B?ZGtYci9XZFV3dHFxMEtKS01DWUdoSXlFRVlwNUFnRVd0UURGMUxzSDBaekRU?=
 =?utf-8?B?T1pDRWd3dXI3UmNMR2piRy9CblBEMzRicS9LcHlOM0lLRmpkSThpUFhxd0lK?=
 =?utf-8?B?ZE9qY0JpSGkwWUJLV2F2Nk5PZ1V6bHNCVERPM1FQZWVZYWZmUk55cmtSVE5P?=
 =?utf-8?B?bi9CS2ZLaVBFZkNMSWhnYzFESWlXaktsRzR3bjh3WmRXbUJtRnVMQ01PdzlS?=
 =?utf-8?B?S2g0NkNvbUNJQWtLd0R5UTgzZHRMSVdydGY0SVBQOVRJcjBpUlNuclNkeTR2?=
 =?utf-8?B?K25wOXNDaUI2b1NSejNFR2hZbXpKNHhYNGdYVjYrRGZIa0x3dCtSOGxZbXNY?=
 =?utf-8?B?b0dyVHphUjVOQlAzem9pYnBvM2NjeElERHBsTnF2V2VTUEtpeHR2QzNtdEFi?=
 =?utf-8?Q?qk4ivT8MWHxJpgk0=3D?=
X-Exchange-RoutingPolicyChecked: LjNVfKTeNHk230ib0zD2WgGltEaNavPRyPmh3vVOH+QsR12rnq6XAwkTieQf9XybOuRh7kbyvd3b2roAcTkxI8TvxNMmqypC7fn5c3DScBkyqG8Tkziw+9IO+jbc7Y3tGPhNn0Dy8IZbe1BVwf+ldTVC1Ebi6AUhBxXI9jYqG8Vqskg1PNw5YPmDpHmnEuHJsw6ykR7FzLL179S7hOXKjTtdCpYfLr+Vf1AKnkpG0o8SJ7YboPOfgBLViAXoIjUHWXojPcJRysTR9YW5+TQzz4nQHcGazGlrDbZ1+0NbU3cydaIqz9atFcRedtIk9rU4CcI4SWXCeHZ0V05aIEXkHA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 62d752f3-03a3-4727-a19c-08df2ac9dca8
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8370.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 14:37:39.0783
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qiV9uZTyRQPhXrf7wA/HSPDIlIynKWYPEBHa7IO2H9pMQ5oPFSnNRRCqzRv6epih0vpBf+EavPHF/b6APYCfM8cgJaSKo2u30IN0gJndXNE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB9952
X-OriginatorOrg: intel.com

Hi Babu,

nit: "for resctrl" in subject is redundant.

On 10/1/26 8:10 AM, Babu Moger wrote:
> The filesystem tracks supported kernel modes, the active mode, and the
> control and monitoring association for the assigned group.

Please let the context describe the context at the time of the patch, not how
things will work after entire series is applied.

Please use consistent terminology, this series switches between "assigned group"
and "backing group" to refer to the same group.

Please use the changelog to guide the reader to understand the architecture
and how things fit together. Many changelogs are very cryptic without explanation
of what the patch does and why.

> 
> Introduce struct resctrl_kmode_cfg and initialize the default configuration
> from the platform's capabilities.

Please check all changelogs to ensure they all are able to provide an
answer to "why". More specifically, please consider:
	https://lore.kernel.org/lkml/20250911165433.GBaML-yTUZHkywuJIe@fat_crate.local/

> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
...

> ---
>  fs/resctrl/internal.h | 29 +++++++++++++++++++++++++++++
>  fs/resctrl/rdtgroup.c | 25 +++++++++++++++++++++++++
>  2 files changed, 54 insertions(+)
> 
> diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
> index e62a277dee85..98f04a2a762b 100644
> --- a/fs/resctrl/internal.h
> +++ b/fs/resctrl/internal.h
> @@ -314,6 +314,35 @@ struct mbm_state {
>  	u32	prev_bw;
>  };
>  
> +/**
> + * enum kmode_state - Control or monitoring association

What does "control or monitoring association" mean? This is becoming
an overloaded term used to mean different things and becoming confusing.
For comparison, earlier patch introduced *another*
"control and monitoring association" enum:

	enum resctrl_kernel_mode - Kernel mode control and monitoring association

> + * @KMODE_INHERIT: Inherit from the user-space task.
> + * @KMODE_ASSIGN: Use the backing group's CLOSID or RMID.
> + */
> +enum kmode_state {
> +	KMODE_INHERIT,
> +	KMODE_ASSIGN
> +};
> +
> +/**
> + * struct resctrl_kmode_cfg - Kernel mode configuration
> + * @kmode_sup:	Bitmap of supported kernel modes.
> + * @kmode_cur:	Currently selected kernel mode.

Adding this comment during a second pass ... please consider later motivations
about naming of these fields. This field is introduced as "kmode_cur" but when
considering the language used in rest of series "active" seems more appropriate.

@kmode_sup could also just be @supported (the "kmode" is redundant).

> + * @ctrl:	Control association for %RESCTRL_GLOBAL_ENABLE_PER_CPU.
> + *		Kept while %RESCTRL_INHERIT_USER is selected.

The "Kept while ..." does not seem to match implementation. Looks like
resctrl_kmode_switch() always resets it to KMODE_ASSIGN?

At this point the reader is left to decipher the architecture via cryptic
changelogs and inaccurate comments. It is very difficult to parse.

> + * @mon:	Monitoring association for %RESCTRL_GLOBAL_ENABLE_PER_CPU.
> + *		Kept while %RESCTRL_INHERIT_USER is selected.

Similar comment about "Kept ..."

> + * @rdtgrp:	Resource group backing %RESCTRL_GLOBAL_ENABLE_PER_CPU.
> + *		%NULL while that mode is not selected.
> + */
> +struct resctrl_kmode_cfg {
> +	DECLARE_BITMAP(kmode_sup, RESCTRL_NUM_KERNEL_MODES);
> +	enum resctrl_kernel_mode	kmode_cur;
> +	enum kmode_state		ctrl;
> +	enum kmode_state		mon;
> +	struct rdtgroup			*rdtgrp;
> +};
> +
>  extern struct mutex rdtgroup_mutex;
>  
>  static inline const char *rdt_kn_name(const struct kernfs_node *kn)
> diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
> index 68be9b903ac6..7c39792be1fa 100644
> --- a/fs/resctrl/rdtgroup.c
> +++ b/fs/resctrl/rdtgroup.c
> @@ -76,6 +76,9 @@ static void rdtgroup_destroy_root(void);
>  
>  struct dentry *debugfs_resctrl;
>  
> +/* Kernel mode for this system. */
> +static struct resctrl_kmode_cfg resctrl_kmode;
> +
>  /*
>   * Memory bandwidth monitoring event to use for the default CTRL_MON group
>   * and each new CTRL_MON group created by the user.  Only relevant when
> @@ -2297,6 +2300,26 @@ static void io_alloc_init(void)
>  	}
>  }
>  
> +/*
> + * Set RESCTRL_INHERIT_USER as the default when the platform supports
> + * allocation or monitoring. Otherwise leave kernel mode unsupported.

This (and why) would be useful to describe in changelog.

> + */
> +static void resctrl_kmode_init(void)
> +{
> +	if (!resctrl_arch_alloc_capable() && !resctrl_arch_mon_capable())
> +		return;
> +

This check seems unnecessary? resctrl_kmode_init() will only be called
on a system that is capable of allocation or monitoring. 
The planned AET changes will change this behavior see
https://lore.kernel.org/lkml/20260928221509.68002-16-tony.luck@intel.com/
but in that case it still seems as though initializing the kernel mode as
below always needs to be done. 

That begs the question why is resctrl_kmode_init() needed at all? Why not use
a static initializer? 

I find resctrl_kmode_init() to be potentially confusing since it does *not*
actually initialize resctrl_kmode. This is only possible to see two patches
later where get_rdt_resources() is changed so that x86 sets its supported
modes and this runs *before* resctrl_kmode_init().

If anyone decides one day "this initialization code is missing a bitmap_zero()"
then it will break PLZA.

> +	resctrl_kmode.kmode_cur = RESCTRL_INHERIT_USER;
> +	__set_bit(RESCTRL_INHERIT_USER, resctrl_kmode.kmode_sup);
> +
> +	/*
> +	 * Defaults used when RESCTRL_GLOBAL_ENABLE_PER_CPU mode is
> +	 * activated without new values.
> +	 */
> +	resctrl_kmode.ctrl = KMODE_ASSIGN;
> +	resctrl_kmode.mon = KMODE_ASSIGN;
> +}
> +
>  void resctrl_file_fflags_init(const char *config, unsigned long fflags)
>  {
>  	struct rftype *rft;
> @@ -4814,6 +4837,8 @@ int resctrl_init(void)
>  	if (ret)
>  		return ret;
>  
> +	resctrl_kmode_init();
> +
>  	ret = sysfs_create_mount_point(fs_kobj, "resctrl");
>  	if (ret) {
>  		resctrl_l3_mon_resource_exit();

Reinette
