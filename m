Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.16
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795115712;
	b=xMXkEusVCmmNfDJXg4yhqxrcdpl92S0kqcx7KUslvg8QrqLqdW2KcD2tryVKKhFvr77q
	 6aI4SUApNER61PvLgDWbwf4yun2vfXWJBvioT0fdjWMbB+J4JuSjysebUiStA+cu5Y0tq
	 Gp7rXdf+jBfdIeB5Kt02GHSGJ4qaT1Z3KnWMojBfjNx1pZWBrCK/MBLdTMAaHPHOTU0c/
	 Liu31NP25l3oeHegHfsmtH9m6sidD4J54WC7+160+DvgBEvPLxXL1zobwkgIP7nezN2Hr
	 GFeulpAdbViwsHJ0/nYptmhDJQBByuii5Z+6nlsr5jT9BY/FeaYjAwWQ31qVJMFcr3w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795115712;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:
	 Subject:Content-Language:To:CC:References:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=GpqCiJXOyV899go0URcqFx5p7I3MovYL11p/d3pshyE=;
	b=xPTAI7yokySqHvFi0EApoJ+FTcyY4KEgsOV6RbMyizJRBR/z9Z71mkiGp2yEQv+ugMNC
	 fvlT2zfrTvwkriERjjRy/w9btCnpqSw0s9dHKetgBdfbOgmxbhEKTsWVDiU6gbTJ3RPmU
	 wX6/bfA/YsmE+ArbbQjKv4nwMjsiR3L3VDMxWHsZil3hUDdiSS6H/L8oBabNBGj7gugF3
	 dyCjn2n2OE96UM+mCZcqtuGmTi2OMerzBGjHjLdn9Q8xDu2GXzaDNKGh1ArLgm7pFIJZO
	 fv4H6igJZ5aX4sH0lBkuBnp4fHrXfbqXozK20+9tEr4KAQGiPGPj3uWpghyP9xDMZzg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=m2abR+85;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=c2jVeZEu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.16
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C391606A331;
	Thu, 19 Nov 2026 19:15:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C391606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=m2abR+85;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=c2jVeZEu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795115711; x=1826651711;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XclbPYcX2vrUTUbT0Wk2PzpvY8OjhbkO/qfBSHlJc7E=;
  b=m2abR+85aRaQpE1Y9OmIdrVOMt4EgP0mYKSbXuGVU92o1vGCzYlA+feM
   vlmy/IlhC+5MEzv8csHlWYWyTrbhQKDMQfWE5QHdueN+2GQpFNWAN+jG5
   TwOWxhgBeeiXryTUnQf75qiIZTHreONQFrX3Dp1i5rdNdOf+MgzFZ1jxC
   XDfnkjq8JW9sR528k+AKoHRZMuC/R8Ri6JfAeq+z97aiBlTzPwzYi9pFD
   DuzvoI6Kwj9AX+TP7bhNfV5/3xfqzAg/odOByvYFC19PYtSn4OT9Ej3al
   loU95H2PlA7t59BE4v7PmK5x85LhT/tVXFEvYx5CnvX/4mn6rNp9/aL6y
   w==;
X-CSE-ConnectionGUID: QJo6zrIRRRmVqjr91SkKhg==
X-CSE-MsgGUID: 3s8dATCORwCsMh4YQGYJVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="4009535"
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; 
   d="scan'208";a="4009535"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 11:15:10 -0800
X-CSE-ConnectionGUID: 5VSHKVLEQLywAoLDZZ9AcA==
X-CSE-MsgGUID: xDO9/5gMSiaByXBd/pKmKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; 
   d="scan'208";a="10636902"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 11:15:10 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 19 Nov 2026 11:15:10 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 19 Nov 2026 11:15:10 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.16) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 19 Nov 2026 11:15:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CtjPu0TGsT4QGcsjfFxA4mNsoRburpJNvq8eZZ0p3/0rddWPWbwa8sZzSUdZ41780jQmUo8TTNfLr0ZZpeKJ+GlXF5/LgCp2lcFMLEq0O1WILF+qcMuRAdKlEkelaJjlsBVu/2g50MSKT7kH4Tx9/MxBSl0GGvkYteD1GTawxehiY0IA+/CtNRAAhgSsDusgCiiWFvBvnbwTm2JKbD8UcqBdsuWa4P0ErROI1sTR7FofVWzZR/FKs27P9/4O7DADT2VFrdxrBblqWrZGiJGZYxl1asSTYW6JR3x1lg1EWhicANDPuOPjbgenmASC2N3ieNR5MaQg0DCm0lHIfg8RIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GpqCiJXOyV899go0URcqFx5p7I3MovYL11p/d3pshyE=;
 b=Jw8z+E2ryWOeqVofDKMn5NPhJIGvc19ykYZXuYVyqqNhttv673mTgwqd7CzkC5nwSQHt+jY8hIHnvOTfx9QmxgED9sUBCFRipK/6hx7hRUnd74LwhWqt3MB3EDcbgEFdD01VSpWqqUirvvO4FTafNjoGsG5AzkFxHuHJUtCz2T0z/SFZ8Hkj8AaiDhQAxjSzMqlIl9T5ZAOITKKGy/ZQoL6PFz3TkS3CNR6kpdSRDCH6FNLjiX1CjsGQnqfjte/X7mtGu6jq598GjjfaV8uiyM/w1FnO9ACQCRBDEts9qrJQydWQ39SiO/bxOsBww53Re6O4EOVAFIQVDXNyYiIlbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GpqCiJXOyV899go0URcqFx5p7I3MovYL11p/d3pshyE=;
 b=c2jVeZEukwhAOhVyq+odzV9g+rs5wRZFDBabXjxmdfDB7sOjGmrFcaZOUXoLbmNzV6NIxDgLoYxyEtuD0kBRVvXcVAIIE4qUnHfOuMjEhTNNpH+tvt/ZvclRiDHhdhl4Xfs5DlE9Xt5dUyXqjbjlFSu2Km1ff3R+3qVsvFy2i8w=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7846.namprd11.prod.outlook.com (2603:10b6:930:79::14)
 by IA3PR11MB9225.namprd11.prod.outlook.com (2603:10b6:208:570::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 19:14:59 +0000
Received: from CY8PR11MB7846.namprd11.prod.outlook.com
 ([fe80::cae0:d05c:b2fc:c395]) by CY8PR11MB7846.namprd11.prod.outlook.com
 ([fe80::cae0:d05c:b2fc:c395%7]) with mapi id 15.21.0615.009; Thu, 19 Nov 2026
 19:14:57 +0000
Message-ID: <bc8f65be-cc26-4cef-a43a-038f85c8e680@intel.com>
Date: Thu, 19 Nov 2026 11:14:54 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 00/28] KVM: Enable FRED support with KVM VMX
Content-Language: en-US
To: Dave Hansen <dave.hansen@intel.com>, <kvm@vger.kernel.org>,
	<x86@kernel.org>
CC: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson
	<seanjc@google.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, Xin Li
	<xin@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra
	<peterz@infradead.org>, Andrew Cooper <andrew.cooper3@citrix.com>, "Tom
 Lendacky" <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>,
	Shivansh Dhiman <shivansh.dhiman@amd.com>, David Woodhouse
	<dwmw@amazon.co.uk>, Chao Gao <chao.gao@intel.com>, Binbin Wu
	<binbin.wu@linux.intel.com>, Zhao Liu <zhao1.liu@intel.com>, Yosry Ahmed
	<yosry@kernel.org>, David Matlack <dmatlack@google.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
References: <20260911213659.2025974-1-sohil.mehta@intel.com>
 <78382e8b-b696-408f-b12a-b89ce9db956a@intel.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <78382e8b-b696-408f-b12a-b89ce9db956a@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR04CA0003.namprd04.prod.outlook.com
 (2603:10b6:a03:217::8) To CY8PR11MB7846.namprd11.prod.outlook.com
 (2603:10b6:930:79::14)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7846:EE_|IA3PR11MB9225:EE_
X-MS-Office365-Filtering-Correlation-Id: fef2fc3d-1863-4574-e817-08df46716642
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|23010399003|261022105027099003|261026140227099003|261028144727099003|4143699003|11063799006|56012099006|261021123027099003|10067099003|261102123227099003|261009223027099003|261021121427099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: cNBozXH4VoNjYlJhRG/fFkF1s3WfFBW739zeRzN9jwh56XDLLiKc7/nGj7wgua9tsOAeRPr8TD7ZvmtJB3OT+iXC/DZ1GykysUzmiidxVmhymMDtzLcF0ueC62EhzDI7ZB+7NMZJ0oB8ZrDPAHXw0izEbiyhws92orERYNFlpbERx1B7m35ggOP2IUcGyK0c81YhR4iKP3MGQ89+oWjqpsSCI9cHzWV3WMA8/2R1BcOo800kcGKynSadDcTzvdNtj9FrwExH05/EZgsxWGU6BgsFUJpVoix/5gEf7hSVcGq6Fn4163GSXVzaG/KweRw7WDi+oPqPtEqZhr+rJnbBL+6Vmph8mkeExysOs3KZ9V800VKn/HC6C5eFcFS9CAbqH20zwc1j47kmGPlwMXUsa+RzFedHk7HJ6qy5pxCPiH/zKL6/5ZBJuGQ+VPi0z1bZ+S1qWWUuCdnnmDAwBglzMqPxAio6LijH15nzvxBZudDYpdMyzdlDftVH1yya9udw/DeoD4H/c8F9ECHixs04huJG1peSy+muYm2c/EyV5YOkjprwJGmGhEgZvlHEtFW14LuupJuaB+1b9fcRoRTytqVDsqAzC8IkSsR56JXColg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7846.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(261022105027099003)(261026140227099003)(261028144727099003)(4143699003)(11063799006)(56012099006)(261021123027099003)(10067099003)(261102123227099003)(261009223027099003)(261021121427099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VklCbmRVSzFWSW9xQUhTaFlDb2lRaVpUOEJMMFhkemdsc09wL25rTzBxaXVy?=
 =?utf-8?B?R3Fsa1FiNnBvWWZJMWEyOFpUNC9LZk1EeVpnWjV5ck9CQStUUE5MWURBbXpr?=
 =?utf-8?B?ZEhjNXFPUUtZT3FjNktCSG53Zzd0bUJBZVpPREp2b3c1WmJTSmNyVmxZeFgz?=
 =?utf-8?B?aUo0RU9kZWZQWTZxdWhOTXluOWRWZFk3VWMvNFRUVWdvYjFhZUVvTlhHRlk4?=
 =?utf-8?B?WWNMRm5LOXBJc3FLc1IrekNybXU0UzlCeWdaNG1kSGRWbFhQS2k2bnVHd3Ja?=
 =?utf-8?B?b0RNSlhUdklNczBKeFNZT2lPbFhDN0lPZ092aE5HRFZ2bFlnQ3dVcDhZWlNY?=
 =?utf-8?B?MW9vbUJXV3RXeXBnNnRsRUZ2MHVkeDFvaU02OFN3ZnROVVlhbkExZ0tiUUsw?=
 =?utf-8?B?Tm5MTnJZdllxTDllRVhlemRGVmZWUnVKdW9mZS9pQ05WVGVTTm9PUEdLaXNN?=
 =?utf-8?B?OUgyb3cwZG5YcElmTnh0dGt3eiswVlNCVHJnQTFZRkpxQVVrK2dDSGhpcEZz?=
 =?utf-8?B?UXJFUzFOdWZ6bGhTN3gzbXBhMFU1djlSejhNdEEzZDhYYlRDZ0tyaSt2VTF6?=
 =?utf-8?B?WHNXVm1yV3BOOGJmdDY0SFUwbTVraTZ4aGxTYlRtNUNvODhEcFVkVjVFZ3Yz?=
 =?utf-8?B?dVRqdXJsczNLR3VmVUdQZ2oweWhPRmpqTmpUdXBxbnhsbjh5Q3lIVmpuMy8w?=
 =?utf-8?B?ZlBmZkpiREorWENOdjdjMS9uK2JkVHRhMCt6SmtZNDR0UGtxS1RGMWJXcGxm?=
 =?utf-8?B?TjI4WStxZWpxVnNTUWdIZHFvM0J6TjBab0h6SEZYdUluWUVPOHlpYWJYOXd2?=
 =?utf-8?B?bjZxNnNSeUdvWUI1cHVWU3hqTzd2K1pQbG5mZnBsVkJydE5tbXgwcVJXWVB6?=
 =?utf-8?B?T3BUckcwNSszYVAzdVViZEFZd0taZlI5aUROMWZ5NkZxZm5tZzZYcXNoT0h3?=
 =?utf-8?B?WHFpVFNsYk1pN3hRMmMySGZYbWNmcUJXRkV5ZlpYRGhhVjBzTUxvbVdLTURV?=
 =?utf-8?B?bHczZDFtN1Nqam9WL3VablRFaG9vWXhwUCt2TXdJaTZ3TnJMcHBVZytBWVZo?=
 =?utf-8?B?WFpkdTJZSGNTS3dCdzgvb242Y21oQWtuQTBjbC9FTS9qczFGR0VDV0tJWndY?=
 =?utf-8?B?aENDVk9uV0FoWWphMzhjZlRYUVhXVjJROGZMVGlJdUZHWUxSR2ZTODJKVm9E?=
 =?utf-8?B?QTBDM1JoWXF5bjlGRDI0ck9pd3ZkOXhPRzFDdUgxV2JPa3NScC9IVHA3ZENn?=
 =?utf-8?B?YVlZdEJMN3BHOU82eWZmYUlmUUxiZzBVMEVhWUdIMGRwVGk2c2tFb1EwS1Vl?=
 =?utf-8?B?Uytta0NBM054blJlUHhqcHB2UWFoaXVkOHVldk9Jd3d5SjdSVzV3a2hPNUMx?=
 =?utf-8?B?VU44bGpDOGdDcFRjN0RLMmRxa3M3OWxZdWhoSU1zaW5WWU9CeFljajAyZE9B?=
 =?utf-8?B?d2h1UmtabkliTDUyTG1WeDJva2FPbDNNWHh2YTBLZ2FCL210eGgwcGdjTjM2?=
 =?utf-8?B?Qi9HOXZXWUMweFBETVMvL0ZiM25UbFI1ZW5WOG45c1hIeVYwVk1sVkQyNVAr?=
 =?utf-8?B?UGRzRG1RbFpIWjNzQ2JhLzVSTWN6MG1EdjlkVUliRFNuRHlaelpQNWRKSmFS?=
 =?utf-8?B?cHU0L29VUzR3cXVsbUh4UHBNbTBEbnBleldQa29sc05lOEtkSjVhVXNyckov?=
 =?utf-8?B?RDMwMlhWTzRRYmpnVjBUYUQ0OXZWcHVVQnd2NHZETlR6K1UrOHJKQXpjRHhq?=
 =?utf-8?B?alpvZitkbkhhLzZQT3ZaOFUxMXNzSG5IY3BSN05iVDdhRGU1Ymw5ZVloczhn?=
 =?utf-8?B?dUlVdjBVV0R2WUs5Y25uWWVWYVc0cXhXNktqYnA3UnNrZnd3bUgxb1lEdmU5?=
 =?utf-8?B?ZzMraExGWS90bFBsR3YyMUs2NktEcENwakM1ejFaakFjSGFLRy9Sbk9PV2J4?=
 =?utf-8?B?b0pFWlU3QUp2cDFoSW1INkE5L1FxMHZzN2wyUnFPL0xjSXR4dEs3NUdESjRW?=
 =?utf-8?B?R3M3UWVvZ01obWZMZUFLVlJOYlNSdXF0TEtaNVdMZ1pSa2c1QkNFZFlXbTRD?=
 =?utf-8?B?S1h6RHVOZFRMOS9FOVdlcm5vdzhxU1JUdTErSnVjbDMxeCs0Z0c0N04zNThF?=
 =?utf-8?B?RFYzQUVld1NDakJZVEx3c09IbW43T2lYSmFTL0FHMFMzWFVLNThreFN5QWhy?=
 =?utf-8?B?UGM2WTFnUFErWG1Fb0poTGRtM2IyT1M5eDJFamozeVNXS3NrRDhMOENqYU00?=
 =?utf-8?B?ZWNNWWw2NG1wWWszR0o3TUh1bEsyTkNqWkYxSlFLNk44T1lyQ1JNVExVTnhR?=
 =?utf-8?B?ZmxRRkU0YjZIQjZKY3hwNGZ6KzEzZWU3Q1VUQlVyWTFsTTFWSEpiUT09?=
X-Exchange-RoutingPolicyChecked: OW6cw+M73JCpEFzJA0cIXOj3UkLxZnMaarPDNU0n4nbH/Otbv69JvuJVuV6E83pir8akacWRz7ZXMieuu8eKKIP1TfqRPC2GRcY+/VemzvaOempg6ZG6c+DcQcnxxJGh+pMNFu/KXomi7lCoiSUM8HTBbPjHch2PyvaTwacBZAP6JNGXP9rSs6y0617iAzO499KHqkcGa6xu1y5e7q8ullcUnK18pbON93uxoI/0CWGfp+FCuqvL6kvC5pDpxonBs1vHhJe2WCRB4f26//t9oTepBLzi8wgR0MEly3NNHdSAVA8XpG1MU2S3pjFQFWzlVhkMLvaTox2I99WKnDFJkQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: fef2fc3d-1863-4574-e817-08df46716642
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7846.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 19:14:57.3408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +5pQtxL+SX2/W7wOB4l0dcsy0K49pZl8tILv7310FNYQlo3VL1iUkdvZ6VhTuB9bydcBxjG4x4DBrMioAvbFCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9225
X-OriginatorOrg: intel.com

On 11/19/2026 10:29 AM, Dave Hansen wrote:
> On 9/11/26 14:36, Sohil Mehta wrote:
>>  42 files changed, 1471 insertions(+), 135 deletions(-)
> 
> This set is too big and is stuck. I also kinda want to see it move
> forward. Could you please take all of the cleanups out of here?
> 

I am glad that you asked. I mentioned the same thing in my response to
Chang yesterday.

https://lore.kernel.org/lkml/12f686a4-a9f8-4347-a7f4-c0f893addfb9@intel.com/

> If it's plain non-KVM x86 gunk and you need it for this series. I'll
> merge it today if it's halfway sane. For instance, why is:
> 
> 	x86/cea: Prefix event stack names with ESTACK_
> 
> even *in* this stack?
> 
> Please just send those to me directly, in another series.

Thanks! I will send something out soon.
