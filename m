Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C8D3A7F46;
	Mon, 10 Aug 2026 08:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786351784; cv=fail; b=IruIKGBEr/Q8haagUDT6YZVIqlLkvxpsMgF3Qq+46mdnENzodZIAjaIxEWAS56+SXN5R3lVznwe3SM76o8jVJmFuWzsG9zlOJzIkj6u73ZYuO0d7O/m/+2Oxc8RI7TC+X/NZG591TlqFUOXdJm+vS7V4W+yO6NsdQy4w6tpP5w4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786351784; c=relaxed/simple;
	bh=Ohs4LBdyNJz7LGgjXvvNEiOqxKudzY+oflPpXvp9S7o=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hgvbIMBYcuYAbqd/kNl+G+EY9X9JEdCHyQk8Sij2UaMSHTqQbbCefh3waXc7GGs3oHybVPrJqRed1a7IaCwJmcR80VrxEuCb8A7iovdAJhwwPLrkmAuPZYt1sSjcukbDK2wkBP6w0pOup9aZrKlQDiYqnBRhwF1PWGJ3M02Hlj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WkkXluaM; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WkkXluaM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786351782; x=1817887782;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=Ohs4LBdyNJz7LGgjXvvNEiOqxKudzY+oflPpXvp9S7o=;
  b=WkkXluaM/smyPAuPzv21psynxH80fSa3X2zIAJGzbeQOczwjkaSPlOjw
   zRTPAHHn7fsnNcSoZyPl2dShWqtLXUM0BV8xe3EdeacocYv7XYkJr46ve
   S4isSDV8q1sL/xpQnjwLFibS5g3gVqSITxLHhkNfHQ+QxjFJnPklUXGu6
   two/IT+xMRcDrsjKbZSShBVSEkFA3FOai0vSWfX+axErywmhlmiz4ViZF
   UbS0kIWyC2/k/mZW0sWk2DWsmp2D8ETz4nyUCDSee4x9lxFe2CrKFm1Z/
   kSI7wEsQ7Ahigagr03FV0XCnKptdTWwV3ba0x18GCjDGxFZyHGRVeXvHT
   Q==;
X-CSE-ConnectionGUID: SiTh3RRrTda2EYhmT1ShLw==
X-CSE-MsgGUID: uj7PFhlJRQaiujAyvlkVGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11870"; a="97208443"
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; 
   d="scan'208";a="97208443"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 01:49:40 -0700
X-CSE-ConnectionGUID: CSLWBdycSMihvvEj8Q6Z0w==
X-CSE-MsgGUID: 8e4Fk/hATUKZX8VnA4EtvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; 
   d="scan'208";a="266472489"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 01:49:40 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 10 Aug 2026 01:49:39 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 10 Aug 2026 01:49:39 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.3) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 10 Aug 2026 01:49:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FNMHbjbRYeap5gsMoDEajQHENw4q4uQYFdm8/wppFOKWIFmP9lpFMq+bpKG+YPBZkeHtGx5x0LWhXwhr+PE8AcsiO3A9QpI/B8wcA8ZstmAvRRytbasrXF7bU28SfCWz9z1Z6OYhZqH+nag/epeLck3B/rnhstDYJ5gFezxPHJBGPa5ghd+y5uF15tlfznwD5287jS6bPS3HGg/eK08LD9XYeiTsZZp0cUQe7GxPYjNdMIQZIygfncW3dQSJZmwEP+1YxFzhlJPlnQXNAQgce2/C+qqrutH0St0sadleasclbvDYde+5W/6Euf9dkTP3r/jJL2K6TRwIdjXX3n0Afw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XOll8WiPg5t0BCojcnwTwKND3dFSJTRn7wp3RfveRbc=;
 b=P+utpZzw0h3GrzwsxL1CUsOkORC6Yr3W34zHt/eiEnCqP/XRxARfNFQVdKM0OenMYpK0+4J0UqgiXNCCKe0wJt8s8G+7+maV6QbxrrBo63T4/i4yUmUBepsmJzMtCbyH3G7Ib7oijrKiTSWx9SMMWAQkr0b+4rssSY0/m0hU2dEHaPyFYGSDYw4R3FE5nRiBxWrN8uh7KSdX/WSa06LybOcanN4ZK2ohvRYvlKNUYPo00j5h3lVKt/0DV1JsBfLQ3YnQSND05/yDosTQsxEOP/yfge8sgt9sGlkIcN8z0jvA2yU9CEijOc+jnkHR9PNEKlPQmSxDl3jGfuIWXtr3Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA0PR11MB8380.namprd11.prod.outlook.com (2603:10b6:208:485::21)
 by LV1PR11MB8844.namprd11.prod.outlook.com (2603:10b6:408:2b4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 08:49:37 +0000
Received: from IA0PR11MB8380.namprd11.prod.outlook.com
 ([fe80::ea8e:eec4:f8d3:f95d]) by IA0PR11MB8380.namprd11.prod.outlook.com
 ([fe80::ea8e:eec4:f8d3:f95d%2]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 08:49:37 +0000
Date: Mon, 10 Aug 2026 16:49:17 +0800
From: Chao Gao <chao.gao@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>,
	"kas@kernel.org" <kas@kernel.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>
Subject: Re: [PATCH v1 0/8] TDX: Stop auto-generating the global metadata code
Message-ID: <anmQjV98HbnjRF7u@intel.com>
References: <20260804112941.19894-1-chao.gao@intel.com>
 <bcbfffccd8f68c638511fcd12211a3501d744585.camel@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bcbfffccd8f68c638511fcd12211a3501d744585.camel@intel.com>
X-ClientProxiedBy: SI2PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:4:196::15) To IA0PR11MB8380.namprd11.prod.outlook.com
 (2603:10b6:208:485::21)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR11MB8380:EE_|LV1PR11MB8844:EE_
X-MS-Office365-Filtering-Correlation-Id: e1985b4a-189f-4889-a35b-08def6bc4eaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|10067099003|11063799006|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: mut77sav6vGV0/A5Zxkrkd6NmyXQXcKnxy0GlEUVw5P7ViZ+1z4yKuonP8no1QYVlhsVMld3LcmqwlG0rvhgmbVNnq/OVrOsJYsnit6Tm9ylqDpzK7Nd+24G51yNnoKOgvXeHHmzHHbfufYFTD2aUlzYjP5JKCfSYT9cv9KV8bWWdaS8cV5e1gJH3PR8510PLRG3Zcqrb9L4vwDtmM3aIXBiRo7TAK1RWUAem+DjXLLaK9KBakUMnXzbRUnGEGu0mVDT8zarJEZAVuF2pvGkauab5tyG6V6JUFiqVqoAoj+UNw9YRb5hFLlMqvx3C6q8wjQxc/bIYdAK/H5y1xa1eRr3TLEZs1O/58K/eCrX0MiTqXaclyWzs2uXVkNQYSIX/ibfAz/Yrg4n5ZlQxQqFm4UdSLNn511cNaVMG7Edww2jHyu9iMHD84xLuiu9760+v570SixOcXIgfngKqbSuuphY8FjwVOpOUEzFeNE19ZWtyWK9GO5WCc/BdcgstlNC1Frb5R/AOfZm9kJqUGx1U4B0KSH3mQEEa8b+I3tRcyGfC6Wuqhk6059dG2e2J4XZZBKrsW5B3bzmV9gQOrHzqxVM9QPsj6SBBye63PeHVq7DoaykV7U/Z2rzYZPMTF4FdiayZRyvEf0rBZSOiQnZleY8TEdQ7DpvlJnRzPynoMY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR11MB8380.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(10067099003)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?r/4OP72NQANXvpBV5UAbfV7/BXtd5yNBvHheCaE99yXikPaDJ0RK9gzo1b?=
 =?iso-8859-1?Q?N3lkjWwmSfSIMnGkUTdBYDlamQzWEffo7N3XfPlpSBSidKN9Z3GcexSnhv?=
 =?iso-8859-1?Q?EaEICAefNIwfYKNL1Dc2toKv048uYGCpXIAtfw6g2nfMhsuxufxmAVGf0D?=
 =?iso-8859-1?Q?/mtai5bkctaswLBlTBA5gPlCCbS9zjnLsyqr3/TtJzY7/wKLltDxKi1lKc?=
 =?iso-8859-1?Q?oQSgTrgQ4bpbGsV6n/Zj+lsebPjWIDzKaW2hSqHcqVxO3twRSORi48yLkG?=
 =?iso-8859-1?Q?JrxOpJ4/o1CnJjLz96frDx5Z+qJgyBAPq5zkdUc0H/TVNV17LkjOaLITs/?=
 =?iso-8859-1?Q?BMbHvWgZHAwLWR+Nd6q7wlYMFYzgdvBeBs1O4afMdfxzYRjRXR4ph3+FIw?=
 =?iso-8859-1?Q?h+TSv9VtCKKEO22FGVSl4Bc1fGvSOsZhra42HN6QVwyuV1jd1mwDG6Kglq?=
 =?iso-8859-1?Q?sj+6rcBRDYRysD2xR0fj+GozMxypPmEeIFw8fNHMW+wbZ96tmU5isZSquv?=
 =?iso-8859-1?Q?qE+yApeEN8MydIHJvj7QJ7Qme98UP4NcfKlfSyJbcDIYQgghCSrbq/XDsA?=
 =?iso-8859-1?Q?oy29L/yG0DGxDlz1megUhxHV0wvtMfHljl3aJamoXnV9+CofVzrfTGULEb?=
 =?iso-8859-1?Q?Hc09VmNgwPDi7fZU2sZ780x3IOUgP/wwuT8AqF2lzrD9Z7vr66Wt3urhZI?=
 =?iso-8859-1?Q?xXA4M0cSGbnV95mNhFsxQX6xlHC/amdgXHAcz7aacO1/jp3tLdr17w1ZEe?=
 =?iso-8859-1?Q?bu72rAUXU4VYFSnUpvPnHDpLEwj7CL48BMs8t1bHTFoNMxJRkJzkUaBsZZ?=
 =?iso-8859-1?Q?GcxDOHcOaFjM6Sc+xZtO/i42l5PMMO5kn7kd0rg6iWu03/3i5HE1Ek42Oe?=
 =?iso-8859-1?Q?Ibx3dEuzpYZLstHDT8khOGIEpN4NHFOkYTbjd3CAaqhmicRj3TpA5kzzbf?=
 =?iso-8859-1?Q?tRjhuVIIoaG9DIrLQRzjAayd9wx3XRZ72MQatkqeuhuc3ZU3ReFD99B/7v?=
 =?iso-8859-1?Q?7rDjvruwxhEy5a8eEc6Wh8BJAEoeh0Az9Bh2TwuFzCjHhPCiL9zYUv+RkC?=
 =?iso-8859-1?Q?CtdzrE5Uqmodq8pKN0mCforNbG9HLhbF8+pSpaw9r+XtcmGcj0SjzB4Aar?=
 =?iso-8859-1?Q?Ss1jz6n5rlxGQPr6mF+C08AHNNbkjFTlFyunh9sNRvPw8kpkd+p/m3UBDp?=
 =?iso-8859-1?Q?dV2nvLO6rBwIUIO//JqPL+O7432lKXn6Q6rd+V2D6R5OVlsOS4EyfoWrNw?=
 =?iso-8859-1?Q?b87dAAnDccXJdnHwhgNcXDJacMa6LOfviNPkS5B5c4iK3PlnUEJZ4NXjbK?=
 =?iso-8859-1?Q?yNIihatS4+mknCoinvb6Mu0OexUmST36xt5+YW26fdH4F5+uECwJYAMHht?=
 =?iso-8859-1?Q?JHUyyCTawUU6TCtuKnYVQpSb5e1vqHkmmMbAUkJNmQTQ27bejAXvE6CXud?=
 =?iso-8859-1?Q?7wUWJG8zbSGaPe+c0jaelNwCo10b9NQ4oBo8BmDI+ec7JazKGkt/crnyDP?=
 =?iso-8859-1?Q?znIizc8Q6TxfYNjBxXg40CRv6feocL4fdJDx50S9kioLhKRbwQjO7X998I?=
 =?iso-8859-1?Q?J3RBHe52Znts6fUqoXxtyNAn4HWhw5I0ciJK6QMogUVBqRMeVnBgPuEwC5?=
 =?iso-8859-1?Q?TpxbPoKzQmSujU77EGNW5ICg4AzW/uv/sTVbirJXCcmImO1atyyfKTsVlp?=
 =?iso-8859-1?Q?jqewLYKaBEVFCX8aKUtXZPvZtAzcTRzLz+9HgygcyHj3Ug96AoPj7Cprxa?=
 =?iso-8859-1?Q?VUs6X+oTHTcPuoO8ygLC5Arshg2044u2Eb/5oHDFJDeCv/tmYQeek8zF/e?=
 =?iso-8859-1?Q?Lnz7NHMznw=3D=3D?=
X-Exchange-RoutingPolicyChecked: PhYzLY/6pyePz1BTZah3nxaZLuALlDhvt3Bi+NZJGaJcQghhwnK+ZFingkTozVdSAcw7xE4sDHTLBvF7YJwfwV/AD8hyXFIXXbaKawHyQI7cS4WulPhfPjM3c3S0hMYUL65RKORQviXYQGEYnAO+jycQYMsopRF9IZeC4KkYJqjpXc7raaxLQ6zJ5UWYO0RorOmySOINdzGhNgruQf/3XnJqWTtqwRqj00uWgp15uswyZ1aTdRIifL9gMGYOAg+tA207rlxjY1Q0b7L4fHueTL7bjv9TW4OyLYh0peoZcpxhXE9vGHiwvgVv8fpEzjKWQqjtbWs6PMyvDA5eJFm8fA==
X-MS-Exchange-CrossTenant-Network-Message-Id: e1985b4a-189f-4889-a35b-08def6bc4eaf
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB8380.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 08:49:37.0418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RQV0HoSrcJBes6gGX7UfmzJ9ex8tVuHWtuRuLoDrLdxQih/EDDdfiPyPBsnmIZjO0ViCi2/dFNQfNjUcfasgPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR11MB8844
X-OriginatorOrg: intel.com

>It might help to fill out this problem statement a bit more. The script is
>already dead because of problems. But it came about due to other problems. And
>we still have problems without the script.
>
>Also, there were previous attempts at a macro based solution that failed to make
>it upstream. It would be good to highlight how it avoids those problems.

Sure.  Will improve the problem statement here.

I completely forgot the earlier macro attempts Kai made.  I've now read
those threads and will highlight how this addresses those problems.
