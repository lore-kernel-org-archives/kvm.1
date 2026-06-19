Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3256240D59D;
	Fri, 19 Jun 2026 04:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781843224; cv=fail; b=BaXeSr7LX5tuQTEh79wpWOAkxnaBfNgNAjIofNbE/TjBFwhtGrzZo/QdgqMRTbE5MYXg+waLsOuJ8SIGVJWYKz/0ybacLQjFKHO3+VkCdbj8C2bU/Uq8y+25NaKz/VSXwk9TzaxBvsB/3iaMP4csGA9vvXrTuBzFkxLyDiyKO4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781843224; c=relaxed/simple;
	bh=GE3cHYUfLjvc2orrR6p+jBf80eqF8UYGgh/ypa+qgxo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lkvNy1divPWifRR9bcOb/FsKsWJTX+VFntVz4Zs2muNkMs/IvZ0mgUvES+1GpXtm+oXXUL/Iv9ebXa+cOyPh6ndm2aik+Kcw3Dp5Q07R2DN11e7jKOl1tqotmtDtCc7q4244xgc/kfBvXsai28Q872WL65l9DgXlOXFdAvVbVl8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dFBU00Z+; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dFBU00Z+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781843222; x=1813379222;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=GE3cHYUfLjvc2orrR6p+jBf80eqF8UYGgh/ypa+qgxo=;
  b=dFBU00Z+KcBLsHLSgODbaj0LMwQRLwqUxlh5vnb3TeZ423mUDfec3VMN
   8JW3hTb9JwIkZhS3rLRXgPwzLGo9S8CLPcvm99h3319XSaYvBqwm0nOwA
   mkr/e4i8DjtfDXWReeZ3UvjXG/WHzj+NfbBB4KxrYZn2A3lYW15n2/3j/
   Gvf5URfeqLSiaAwBOSyjcrPRSGs0mOoLEvpuKLJrWN4m+Slk6T6ASKWaH
   InGnt7uK6QMgwznZa9Tu7ebIq1XAWUWSy5/OuXyv7wzdvcsjl0zcWHbt1
   AW1yVK68H0rwzHKh8jlD2UEUFcbxx5LwyLu3YQc6JUZJf4+HAVf8uFQJH
   Q==;
X-CSE-ConnectionGUID: PN0ChMGdQGWXNIwwn+8PGQ==
X-CSE-MsgGUID: 2RvLrqn7R0GqtYRM/JNdzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11821"; a="82570205"
X-IronPort-AV: E=Sophos;i="6.24,212,1774335600"; 
   d="scan'208";a="82570205"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2026 21:27:01 -0700
X-CSE-ConnectionGUID: snjU6smkQkqe3ClCiGCrnA==
X-CSE-MsgGUID: Ud2nsNkCSY2mvDNWpN5/wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,212,1774335600"; 
   d="scan'208";a="250454913"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2026 21:27:01 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 18 Jun 2026 21:27:01 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 18 Jun 2026 21:27:01 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.13) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 18 Jun 2026 21:27:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xbpMgWDFCD1mIOSqGFy4TRpm2SacsGtrGET28kA0d5o88Ns/WzaLYSwxencMzSYVm1JWDhcLd6WMUkioUNkan5MjMDarROyVmbB0myMz7iTaDSKEvM8AAwxg/Bb/1IhSl05ZzdlrU51kRXkJ12EwBHFaMXRpSoUhbwM2FRjjfRnmgfRsCQyTUTEqdOVmllSYidOLfq18SxowkygtEG+6B7eTuyvveqBOPFmWdytBbJCuh0Ur7LLfSCqIH6Tv4qPVEXeSgygCpPxAI2ca47O+8aUu3QODPc20Jf8MoP2fbT4Q+NlVsG6hQc5a0z3cru78GH2nqH5umf7NnaMySzSC0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GE3cHYUfLjvc2orrR6p+jBf80eqF8UYGgh/ypa+qgxo=;
 b=P4ZF/DYOD34DGc6k+tcf6GJOcFPpzaeQ6uhVTL+kijdp7EWixv1CXnguEs9Xb/ImhL+PZr2MIZxbuivHYWL4QTrHc89gqmpYd5HXFmEGzUM40HhgmuYgmm9No5hj1QAtcHvSkOedFQkDsqGHjxGToHvZz88XqcN+9eebi3JQM2rfC0e5JIjxLwu7bonyJMnkpSN1Q/aK/43+3EcuhznaACk5WtZ/EhbPfP7oQY8PtXm3DQNjQPauTYK5WooC9+1sOmC5ULOwHo4aKhT27mLXMh8dkFIPO0FHXhog6SztyMVhVD5O1SDjrnZKpU5ou1OyVWC6yIzifdb1hszWuaf8Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 IA0PR11MB7791.namprd11.prod.outlook.com (2603:10b6:208:401::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Fri, 19 Jun
 2026 04:26:53 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%3]) with mapi id 15.21.0139.009; Fri, 19 Jun 2026
 04:26:52 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "seanjc@google.com"
	<seanjc@google.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] KVM: x86: Replace BUG_ON() with WARN_ON_ONCE() on "bad"
 nested GPA translation
Thread-Topic: [PATCH] KVM: x86: Replace BUG_ON() with WARN_ON_ONCE() on "bad"
 nested GPA translation
Thread-Index: AQHc/1Uz3/G5FjpikkGMW5uMw1gQz7ZFSQcA
Date: Fri, 19 Jun 2026 04:26:52 +0000
Message-ID: <77ee44d8e74e366b04904338f16d3a088935ab05.camel@intel.com>
References: <20260618185746.2023283-1-seanjc@google.com>
In-Reply-To: <20260618185746.2023283-1-seanjc@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|IA0PR11MB7791:EE_
x-ms-office365-filtering-correlation-id: 6e3633f8-53ca-45df-86d7-08decdbafd3a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|38070700021|22082099003|18002099003|56012099006|11063799006;
x-microsoft-antispam-message-info: xrCBZChOf9csQWS+DXoCCVctbalxdWI/YQnQMM3M43LWD1VK4+w2GsGxPlXICpL1USadB8sxoCPaT3GCe11RjCIuDIQAoe8fcLnz+rijn0ayOzvw5+6svk/dB3EiFGG0drLVDBYikkmXr8L5+UWx+2TkAPoeMfB6SQf0FFUq0dYXi1dV/UdR6nmAuShyAXcpX/vi5DRI9IaY6O7KH1nwWBurjYtr5ZpGR32Oys8JlP1XWCr7h2PewjfwLLgI1xTzVTZ/Ei725SGaEeszt0/RgdUflqQA3oc4WniNW2oiPsTn5UF33gPBPCYKYBBw6Quy+NxAUpWMAGM2RUJmkwT7etvehtQz3eZ+XWPDMzRJk92ja4veqzQt9CWUpyWCF5hScyK3JfTGML+Goo6n0UDoAn3ngldqbxzpfy1iu5mXZuIzF2c38UecRtlnRz8BXkvmUEPxIORgPlRs4ony+3ZpzmDphbFcXccBn5fol+NKUIaS5+qinGbfBA83AtHxZDvvwzhbNYXUJ6O3vGFnqxKsovXPMlB6FGM0OPsYiaoH7lRjRZdNrVIkDoULZmpKmBlj0kzpb3Y1O31NH2xQuXfQcsI5DdojsCYINotQK+q0+EdA6cCWVdtlNWGDrlQOMD1oc2I5RfxvnJo9c4T2ri/4dqGxQ6J0cSZvL86EjXu1nSQiMC/Aiew8PUqq43fbfPzhO/4UrmzYe1+OjRyJpZjcBaP+QowUMA5vzlfGhhhE654=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(38070700021)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TlZzRWx1b01vbmNoRStLMHdvZWRNZW45Sk5SZmZQZzRIWi8vTmFUbm02VXJj?=
 =?utf-8?B?RjZCakdzSW1qOHZ3VUd1Mk1yN3FqdWFBMjY3NXk1QzFLbDF2NFMzSnBDY0ln?=
 =?utf-8?B?dHpMRzBUTk4wVUN1THRCZElFQklSK2lSaDJVSHA3SThOazE1QjBQWTJSUlFj?=
 =?utf-8?B?ZUxXOEtNTmJuNHJwYXVWem0zQlJmR3JscXhLUXZYbEhTZFpoNFVCQWxEb2x6?=
 =?utf-8?B?Q0RDWUJNMDJVRUZMSFFRd29TN0hpUVZRVEsxb1duZFdYQThoa3dsM29DWTRq?=
 =?utf-8?B?YnlTSkxKbGZROUh1WURDRUpyUmdFOUlrWDViRS9TRHFqZHYwOUJOV29ET0py?=
 =?utf-8?B?UkcveC83OWRUTFhPa042TE5CS3ZJeFpoQ0U2SU1TTHIvVVIzb2VaeTR6M25O?=
 =?utf-8?B?N1VZMS9HOUcxMWVKYlZZS0RvNTZ1aWJsT29JRHZEYVFFcGN4SlFrQUlmVDI1?=
 =?utf-8?B?QSsxbUNBTVBvRGdkUmJMTXZURjU3dnJkNUwrQjFVWktCeC9Nc0ROY1phaFU3?=
 =?utf-8?B?MEtLdUJ5Rm00VzlJQjJUNGJvL1RqR1lGbzlMOTBWcG5NcHB5dmNueUVKclRl?=
 =?utf-8?B?eUhJemFoR25xMlRtWDFpSlhlUFkwaUdaVGhOOUQxZUlHVUNSMHBxTjFOeDlI?=
 =?utf-8?B?SWxYQlV0cXErM1Nxd2M3MW1WU2ZMeThLSFZ6d3YwbTFGOURiMUtCU2tvQVBR?=
 =?utf-8?B?dWtLeVFPS2ZNeGNzWkllNkhPc3pxa1MyMng4SVVPcWZPUFEzYzV0WU0wbWoy?=
 =?utf-8?B?TUt4RnlrZklkMnVKSVRIV0JiR3VUcWNab3RyVTlRd1FXbHZsRmZTYmFzRVNV?=
 =?utf-8?B?eDRMaWxDc0dQWEhUZkdFclpCdEpzcXV1WjFhM2Y1YUZEbFYyTndxcFhJZUVx?=
 =?utf-8?B?WVI0K2oyelNHa1ZpOW5OSng0TkpLN09takxOY0Nia0RRRk0yN2VLaENjWWVI?=
 =?utf-8?B?WWlCQlFWcGt3UUVFVWh2aGlyeFF2TXVBRERSb1MyTllET2JmUFpEWWJ0ejRh?=
 =?utf-8?B?OHRyV2JWTHc5UkJnM3NBWG5UUndjc2lnaVhHR3NCZXBPTlVPdEdLc3JBWkZy?=
 =?utf-8?B?aWJsUW55OFh6aEc5QlZQRzJyQjl4ZnZIV0ZneElmaTB2ZXdPTGcwRm1VTlVL?=
 =?utf-8?B?bm5hWnlsaTkydVk5SndBOTlmNzVxUnVmRkpvd0ZYc0N0Rjd6Wkk1UE1JbW9y?=
 =?utf-8?B?cTJYQkxGRlVuNmNEamdzQWZ1RFdyWlFSakpoem9iazZ4T21Ecjd0NlFIUjhm?=
 =?utf-8?B?WUNsWjR0UDR4dk5kK0V5STI4dGhDS1M3Q25iZGNBMWlsNUhaREdkZzVKcUxa?=
 =?utf-8?B?Q2c1WERUYVlIRXFZZ1BZc205MEs3aytaS3FJOHR2bkV6WE9rdjRFVTVEY2h2?=
 =?utf-8?B?SWFrejIyTmpqRkNYbFo3blNQclBKdi9YV2tSK1ZHZGdlTmVRMVNXcHpwSDN2?=
 =?utf-8?B?eGVtcFI2SXJYWDhuMzBKVVNjUHQwdE9VVmF3OUdkRnJCcXp4TGNwSzNWOXBE?=
 =?utf-8?B?dzJZU1A1c1lGVTBNUTRxS2s2d0pjZ0dEQ3RvaVkvZERMcG94ME0vdkhWcE1q?=
 =?utf-8?B?V05PUHA1WGJVRWQ2dnVqemRRTGh2YndKVHQzazNsQTlDV0xWQWtTTUVPTG5H?=
 =?utf-8?B?SDhXTktHdk9mM3Y5U2RicnQ0L0pzenNBMzlRemlsSHJIbk1NWGVUK1U0dGJM?=
 =?utf-8?B?ZVFsRmhGNmpsUkJtS2M4TDVOZzVmcFVRZ0cxMmt5UEFzYU5BQVA4NzJZeVFr?=
 =?utf-8?B?aEFkOHZObUtGR2FOSG1XYzIyQWJOaWJNcG13TWZGL0RRTnk2eFlNWmRlMlVx?=
 =?utf-8?B?Z3lZamZ0NlMxNTRyWThWdzRTQlltb3d6ZlliSWJGVEdKTW52eVI0MEhVL0l2?=
 =?utf-8?B?ckhnZWxSMzVjNU15WkJqNlE2NVBaOFk2VE43ZzRoWUpxUCtPN3BDVzVXNTR5?=
 =?utf-8?B?dmEwbTBvNlZ1TzVwVlkyL1JUZ0xHcnkwbHJxTzFEbkNXOUZSclh1b014SCsz?=
 =?utf-8?B?dnMwdTRBVnZJalhhbGM4ekw4WGxOejN3KzM1SHBZSk5nZDR2VHcySzBuTUtu?=
 =?utf-8?B?b2lOanB4azk2UmNBenBkTTE5U2RmNmF2MU1PNTRHU2t5bENwZFZtZTBUNURE?=
 =?utf-8?B?SHFjOXM3b2VxLzZHL1ZHS0NPdEh0L3lodXdkZ1NaazR5YTZiN281ZmpnUjZi?=
 =?utf-8?B?ZDZjOWxiUVd1WUFCQnM5bnUvVGwwaHV2YlRWdTd3U25tNG01N085YUZGV01p?=
 =?utf-8?B?M2tBK2JYSlNRYTFVQXJWZmdIUWd3WEIvMzA2Mmc0TjFEdWx2YmFPRFJaOW9l?=
 =?utf-8?B?VGE3MldrZEJxcWV6K3ZHRG1RcE50S2VnN0ZTNmd5alVrNTVPa2Rzdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <26C4A031EEE23F4D9B9A5C653D222FBB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: NbIEqwpIOctTKKxzAK6zbhdchf8eDA0wIKYpd2FHpUyjtz0eKwIpHVYthsuugj3dV3AaTZtVqT7xISEoZd96ocnebUhZ2zEfXf9vZh+18ZjHMVsE1f/3TEYN8ibfiOMeo7tMlGMUThxWehhvQmdahCiLAH9JZCycEWZQSMiTW8BGstnd9q4TJZJzop7odH1I//isAAPkSEUCPujCwvJdtdqtulCLmOSIyLZALVNAGQj5BacGe03XKw0B3Z5xyyn46Mtv4BHhPjg/xiCBFqhfO3zxoOEl+yneTaiXX+73kLp0NdvDoIY6MaIoE/uToMdVD6FnLeeBTnL+I/sQb1z63g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e3633f8-53ca-45df-86d7-08decdbafd3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2026 04:26:52.8628
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jPTDo+yoYhPS6c/I6V1sO0HPlxw2X5nQfbZzAQTlBlP09TD9hh8eGQLuA6bVgUmTvXYhrG4592hPwBfPmCoTLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7791
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI2LTA2LTE4IGF0IDExOjU3IC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBJZiBLVk0gYXR0ZW1wdHMgdG8gdHJhbnNsYXRlIHdoYXQgaXQgdGhpbmtzIGlzIGFu
IEwyIEdQQSB3aXRoIGEgbm9uLW5lc3RlZA0KPiBNTVUsIHNpbXBseSBXQVJOIGFuZCByZXR1cm4g
dGhlIEdQQSwgaS5lLiB0cnVzdCB0aGUgTU1VIG1vcmUgdGhhbiB0aGUNCj4gY2FsbGVyLCBhcyB0
aGVyZSBpcyB6ZXJvIHJlYXNvbiB0byBwb3RlbnRpYWxseSBwYW5pYyB0aGUgaG9zdCBrZXJuZWwg
anVzdA0KPiBiZWNhdXNlIEtWTSBtaXN1c2VkIGFuIEFQSS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6
IFNlYW4gQ2hyaXN0b3BoZXJzb24gPHNlYW5qY0Bnb29nbGUuY29tPg0KPiANCg0KUmV2aWV3ZWQt
Ynk6IEthaSBIdWFuZyA8a2FpLmh1YW5nQGludGVsLmNvbT4NCg==
