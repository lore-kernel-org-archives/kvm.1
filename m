Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A493F5BC7;
	Fri, 10 Jul 2026 09:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783676337; cv=fail; b=EGAONC1YUvuRJwfM/lKfiBAPV9A+iKrGwoiY8b1VOM80SeKQR/oQTYPEzLkPr/Muh+ZtXMsalVq/0eRi9IURmo13tEXZsRYmYh7R3dUBJbwp+S1B3Rn8BmpnXmz0nee+ioRKNn0/gKKJ/6CGef1sqa4iSLzMSclkawmRATZqJtQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783676337; c=relaxed/simple;
	bh=HWajrNabhYUWMe7U/VRLOA+wN9mIfqAC79OKD90zEYw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Xcq3JmHPwHm1Du5BOESIocmqeTYXTm8WhCLH+D3Mazz8IFa+XpzwSXZa7lionsk64zd0nYYClSxPRKV2uR8Vwp9WkLgB3njF9Vn3EN/XyxksPI5M+mv7aNVbcmKisPA9VM9Df2KBbph1XTRowbBKwhuSF8uqoQu/bG9+4+tBzWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zhd5S4j1; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zhd5S4j1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783676335; x=1815212335;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=HWajrNabhYUWMe7U/VRLOA+wN9mIfqAC79OKD90zEYw=;
  b=Zhd5S4j1Bpzr3EI3yj170DdCjZDgL1O+wFQtJuVJga9IgqZpzzX5xGgY
   Mcw3A/h81z7Ag3usZokIOeKltplwqp5MdrnT26ZpUTPHex2lpGGyp+0yt
   7J4mqF1I78V8Ah861F3H1O3tjdMp4/OANHtu7oC0mhVdKIBXeHvZRSx6V
   UTi7G7Lq7H5dcX/DNsBdRysgvJRQW6lARantWCjHF7oNtfWdDjz98Pl4l
   ITUuq++P6KUgPJfBdKQcnc/PI0pr1u07T/nosUd6CAsL3511Jw5gdLIAT
   DtMG5TVcOXEk/lYhP0WMT60d6aE2hFF3mVczObZHYOn55GRMKgYlLFBTA
   Q==;
X-CSE-ConnectionGUID: BSZhzVupQki0oJFDiQqSzQ==
X-CSE-MsgGUID: L31SWdf2Q6GzHWGEyCaKbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="71897674"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="71897674"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 02:38:54 -0700
X-CSE-ConnectionGUID: ZUSvWEzNRamcoWGxYPlPUA==
X-CSE-MsgGUID: 1QF0+SoHRtGjuj0TV758Ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="259154460"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 02:38:54 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 10 Jul 2026 02:38:53 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Fri, 10 Jul 2026 02:38:53 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.0) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 10 Jul 2026 02:38:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q+6ZYtmpi5D21wxEIe955et4oQiOH/Ndh78flS8CdfmaGSLgynW57hqaget6rB+NY/M4pK56Mse0cA0Z/Whtra8mQ6iR+MDISP8DHvUE/gJZSPHds0rC1oqE21a3qjLAt5CY2qUK1YFBhIzQo4WWWDaZ4ZDjD1BkXDMzMqQwh2EsGp8Xp51TsepC2Bz4QQeOyl07Jj8Qd9wyvOjNgCieGQaR/o2IFXOEU4qToqg8TNi7UbvikuvA2b2A4scSmp5dItLuFmQNZNbE4CIdt3PVaBJX4vIViL3oF2JZBijb4W1ZPIV64Z+tGkvqUlHo0EBZlpeBg7zwfCYQ0N/DAh5GcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XGuM/wBd8CwOCfpBijHR/t3wUo8QU7GAxkQABfz2pFM=;
 b=X9+C2Xuc2PxtFEMsWVd0RcLxac3NughJrHBoRTaU+8cdz2L/7buwXE1o2X8uIlexLgXPrb8NeCqHnOBNitbnomRluvlXiTdRLaTRvSz+CpbE9meLEaLBuxv5Q+4WJFK2SXb8sgrTE0mwBMwsumNp7pWTEtWWnul40OMVjq57l24MSW9HYrdQSj09uHbbfRQRP/LME9wrwlWMmw3/Aw5qLgFhpCoQiu1uorbgk3WxpwuVq23LVR5X5G5J3aFm3Uv312RVoBFG9VDULZST5FGc6IeRNP7dMEGR+To/H60DJSTvQ+yRN/HL6tAmtfQ+sAiKZAohElbhdS2o0nnLKBZNOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com (2603:10b6:a03:3b9::19)
 by SA1PR11MB6967.namprd11.prod.outlook.com (2603:10b6:806:2bb::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.17; Fri, 10 Jul
 2026 09:38:49 +0000
Received: from SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e]) by SJ0PR11MB5645.namprd11.prod.outlook.com
 ([fe80::fb19:f933:8bb3:b42e%4]) with mapi id 15.21.0181.016; Fri, 10 Jul 2026
 09:38:48 +0000
Date: Fri, 10 Jul 2026 02:38:42 -0700
From: Peter Fang <peter.fang@intel.com>
To: Nikolay Borisov <nik.borisov@suse.com>
CC: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "seanjc@google.com"
	<seanjc@google.com>, "djbw@kernel.org" <djbw@kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Li, Xiaoyao" <xiaoyao.li@intel.com>, "Hansen,
 Dave" <dave.hansen@intel.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "Hunter, Adrian" <adrian.hunter@intel.com>,
	"kas@kernel.org" <kas@kernel.org>, "tony.lindgren@linux.intel.com"
	<tony.lindgren@linux.intel.com>, "Xu, Yilun" <yilun.xu@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Mehta, Sohil"
	<sohil.mehta@intel.com>, "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
	"Maloor, Kishen" <kishen.maloor@intel.com>, "yilun.xu@linux.intel.com"
	<yilun.xu@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v2 16/17] KVM: TDX: Add in-kernel Quote generation
Message-ID: <20260710093842.GA2816371@pedri>
References: <20260618081355.3253581-17-yilun.xu@linux.intel.com>
 <aj1tFuwZWdPGfUoG@google.com>
 <20260629100301.GA1743876@pedri>
 <akMQ3J6fK3DUBsPH@google.com>
 <23a9173f6e278ca7dfedce3374626c6ea3e1b47a.camel@intel.com>
 <6a445e4be6b12_3a3568100db@djbw-dev.notmuch>
 <akVNdxCzk-n4bgMv@google.com>
 <9df36c49e6be69dd9eece71f70a404a84b1563ab.camel@intel.com>
 <20260704054342.GB2169894@pedri>
 <e6c0ecd4-c128-47c3-99ce-1d45113f6766@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e6c0ecd4-c128-47c3-99ce-1d45113f6766@suse.com>
X-ClientProxiedBy: BY5PR04CA0022.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::32) To SJ0PR11MB5645.namprd11.prod.outlook.com
 (2603:10b6:a03:3b9::19)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5645:EE_|SA1PR11MB6967:EE_
X-MS-Office365-Filtering-Correlation-Id: e63f47b4-1eb0-4655-27b5-08dede670a9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|376014|7416014|1800799024|4143699003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: T66zwe2ODqNXyhOeelPjkaCtFeSUoG839BSm47zihsbV2zvCdIO80uu4d27NfsR7PyXP1y116EdpNPfIWdAT/4C4LOzu5cSQkxLnfw/5K2KLyMW6o1eG0KlvDjgniRzdNvge9Mi/dah7OrfQwpVDw93SzDTAohactACmIiC6ye4tXwQgQLbNaCGaqqTn5CduFRlrWqDXKcxP88Hrg7pp+Pmd8OLTvNgugdHg/z55gwdPlBunRQBEqSmEzIoZa5HnAYfRQSD0nLwmfx73Aez1bniyopogQ0pj6QOxF2l/hNttUKYaR3DaO91XtNMScS/ASZ3kr8vu9mEe59hvTm+8Is86GQz/guOvQMRbgpjwrTGHAHO2+2g7kfixFkAX0Pg4gg5uX4Wr4mYBa5CDROQcaZZsKHvDMUymPf9QKBGFuTFt8+/C0YSeZs9SZFNSJAGPH5kM5q0595CEPdb8o3KuUje3o3cxEdgANHbRs2tDPjfqBUNLGOdlMvF0U5PhTf+ocxlpwI4dUJzdlQc+pGqhOt6wNp7gBMpWwsBD+lP1OCPiyWbbyEtSkC4dX1yezAxvssXYXdQf1fuIgb/Y/3/wea9V1O4To+acSCY9FNCocdVsxysPdGhtgIbCuEi6LZsI59jsMImspGIqFxR1Kk0gjJmcxbbiHev2hTofo8XRFRA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5645.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(7416014)(1800799024)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVRlYUFoOGd6Z2ZNYU5VRzBkRUZwZ21RTW9aRFRyQ2htV01ndjZhQ3hNbytS?=
 =?utf-8?B?bjQ5a3BBUnQzUGI5QjdCaVhrM1BvSU5UUU1RcUYwMWNVdGJHNHpQS01PY3J0?=
 =?utf-8?B?K3RzaktnMG5UQ3J4L0J2M3hRMU81M0dUUVpYYVoxY2FCQmFLUThNajBpT1Vv?=
 =?utf-8?B?aVpSRkRxNUVDYU4zYTRocCtydGdiZE9xWDM3Q2l5YkR0aXhPWGxGQUY1OVlW?=
 =?utf-8?B?Mmt6RHhscld2SWlvbXRNNUdXSlo1empyUUkrazRyT1kwcDJoaXBMWm1peWNu?=
 =?utf-8?B?Qkp0TXpYS3pSU1JodjBma2pZdHcxOWo0U1dVQUJjSUMrcEx1WXdzamFwclpi?=
 =?utf-8?B?K0VMUTVEVkIyRnVGeUJ0TmY3ZXUyTXRrSjZXYm05U2xqakNZMmtmazhYOXM2?=
 =?utf-8?B?emtBRkpMeDBXazdDQkhMN1V5MUQwbkZWajdaSFcxd2JCWFRJNHlFRndUbFhT?=
 =?utf-8?B?NWxGa0NPYU0zVHNoWG9UbWwrdG85Ym9jSlRFendUcnBXUzY5ZW4vNTZaNTI2?=
 =?utf-8?B?RVJ0ZXlIekYyeWlPdHdGeHlJWTNjdnJYNU9Wc2J6MWsvdmR3dzR4YUxscEFt?=
 =?utf-8?B?eUIySTFPOGt2UElaM3NvZ2JPQk4xWnhETndoSTg5NVE0MHJ6QWRLNGlya0hz?=
 =?utf-8?B?T3VUOUlDMHg0VkhXVEY3MDhmQVl5NTQ0aGhHYWpMOFpjRldKK3FRcE92Rkxq?=
 =?utf-8?B?dGM1UEhUUzVtM1kxbVNQTzdZVHhwZVk3cENoWncwdzRjSjhrOTZWcE9nZytp?=
 =?utf-8?B?Vnl3aEZDS0hVVCtCeXF4VVBrbGNpc21HbldONE9kTkFLbFR3QThkek9iYldZ?=
 =?utf-8?B?RTlIMWo5Tm9jZWhxdzJzeDBmUGJDU2duNnYvMTEwek1EaDFVOWNNZnRTTldI?=
 =?utf-8?B?MWZmbWxjYnhNbUdzak45U3B3N3RFbEhIc3hEUTdYYVpKSklTQkd2QWNDWmFC?=
 =?utf-8?B?cWFVTFJSOXJHK0JESitlRXNHaHp2b1JIZkE0cy9WVWl6UjB2Mi9vMXNIUHVo?=
 =?utf-8?B?bDdRRW1FTEpQREtiSExWTHZCQ0loNFEzWFk3WFNQTE5Ba3BrR0xoRVJFM01x?=
 =?utf-8?B?OGFGNGlRRzNnZDFHdWxuVjBBRkFQcUNhU3pQbFE0Z1FscjZ6eUdtMkxyVHJy?=
 =?utf-8?B?cVJ5L3dYelcyVWs2ZVVrMzFrYllEa2VybzdxOG9Hb0lTV1dPc0IwOFRZelVm?=
 =?utf-8?B?MGVXd0J2alpOQzFNZ1J6NUs4ekU4RnpES0M4bjVYTVpFeWFGamxvT0tHSjFB?=
 =?utf-8?B?K0NpU3BZVW9lSS80bW5Fd0RVU09pb1c0dUNPdkRTd3JhWTU2b1RMNUpQak1T?=
 =?utf-8?B?VUR4NFNDSi9BNEEyWlE4RnV4YmdDNG8vWXcrWUVnM3hnM2prRDQzUzRFOWJQ?=
 =?utf-8?B?SndrWkxxSTZUQm91QjZCbVlqd2o0dVErdS9PcDNxSmZuME5UWUdNb1VwdmxZ?=
 =?utf-8?B?SG4vMGczU0JnaDRjcjhvZnA2SHFkNVRoNGQ3dW02SDZONnFod21hL2xEOXJo?=
 =?utf-8?B?RmxBMEc2b2tMSzlqVE9UeTdtWUR1eG9GQ0x5YzJma0E0emhCY29XWGpHck9N?=
 =?utf-8?B?QnJHZkkwTTlUQlhrT3FHMkZ6R1FESXo1Q3l4eVF2aTdXMmZjbGNXaXAzOVhK?=
 =?utf-8?B?RVk2OUwzQ2tGM0s2L0d0dUYvQnlmV0E4TnFPeFN3M1hDaVJnOVpoaEU2YU43?=
 =?utf-8?B?Yis1ZFArMlRSeExGWHRCQm0wWFpBRG0yRmtQSUo4aTJnZnlPZnExby9HeU0z?=
 =?utf-8?B?c0pBNlVaS1g2VU9McjBEcUpYVHV3RG8xUFVIZHh1MHB1aFNPT2FWNzdaR2RN?=
 =?utf-8?B?OW0raXJINkxUVCs1cU9SQ3pkMk01RGkrZk0razRmalduTlZWVUFuRUcwMkll?=
 =?utf-8?B?ZWxGUUtKNTBuMGsvQzlXR0xHSHNNTFI2emVYR1FrT1ZoU0NVZHpTRHNMbDRX?=
 =?utf-8?B?RFNBUTE5d0lISkZPd2VhSnM5Z01TbDN6T2s1ejdTS3pIU1FDbHBWbDYwSjl4?=
 =?utf-8?B?OVFDV2sxUHROT2IyR2VXRHZSTzJKL3dSTUh3VmRtTTZpaXdHaW94aytDVTZw?=
 =?utf-8?B?ZXhzQlZlU3YxTmZYcGNCalRtbmJjbnJQQjdxZHk0bnNieWNBQjZWUHROMVBK?=
 =?utf-8?B?dHFmMXFnNWtTTFZvckpiY0VUdE1ocTAwQmpWbnNKeTl5STFYRyt0b0Fvc2ZN?=
 =?utf-8?B?dEExZkhaZmNlajJ3aU5QWVNOWnhibFdwMUZBcXlCU25rWlRiaGFTeUxKTmxq?=
 =?utf-8?B?bEluVUMwN1B2VzBWYWg2ZjY4Q2ZVNXhvK2FSV2xDYjhtZmVhVm9KeUZrc2tH?=
 =?utf-8?B?NXdabDNHOUVpemZ3NGIzMDZlaWJUZjRwYmRSTk5wa2h1SU9ES29idz09?=
X-Exchange-RoutingPolicyChecked: iG4E3pZLquqyB+iqUpfZScHsNNXHG0/G3enX3RM/TzaaFLYHveK88Y/XfiGJMbwVfYcXmkzzkLpduQBSRpUryOxwHVKbWi4qmBXTvnLfN2kYkWlOISl24//9pUJam7Mtr2hb4+YFkY31grtm6U0fNzEqce8UD7O4n0rJ+uZxa3TG0V9Efj4eucsPaNVbosrcmEjwlEKhvJN8uiHnlLRYQEPuXeLG+z7EJP+zEnQuo6QIgwPHdhiHyCTGJCBSgGbyiBWqCqBU244CAnhpc/V2MUcQoOw3OqdU9ze1LE+LW10jRjO388djsC70b5nbAF9eJStblRS+7jhtubFdlhZXLw==
X-MS-Exchange-CrossTenant-Network-Message-Id: e63f47b4-1eb0-4655-27b5-08dede670a9c
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 09:38:48.6620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z2k+HwEi3jbRNQsdFGTQ8gmqOwP3s/LMP3MNGXi580cuz7w443hLivEQt6S09QfVrO7jkeGxxYHS5sBhCnB4jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6967
X-OriginatorOrg: intel.com

On Fri, Jul 10, 2026 at 12:01:41PM +0300, Nikolay Borisov wrote:
> 
> 
> On 7/4/26 08:43, Peter Fang wrote:
> > On Wed, Jul 01, 2026 at 11:45:53AM -0700, Edgecombe, Rick P wrote:
> > > On Wed, 2026-07-01 at 10:25 -0700, Sean Christopherson wrote:
> > > > > > That is a good question. The answer is partly historical reasons, but I
> > > > > > think the pros/cons don’t really move the needle too much.
> > > > > > 
> > > > > > The main benefit of doing it with the host in the loop is that the guest
> > > > > > side TDVMCALL quoting interface can stay the same. There is also a wrinkle
> > > > > > in that there is a limited HW resource involved in the quoting,
> > > > 
> > > > What is this magical resource?
> > > 
> > > It's a HW crypto thing. I'll let Peter explain more.
> > 
> > It's called S3M (Secured Startup Services). There was once a public
> > document about it, but it was removed for some reason. It basically
> 
> Are you referring to this:
> https://www.scribd.com/document/970439243/S3M-Intel-White-Paper ?

Yep. The internet never forgets :)

> 
> <snip>
