Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.14
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792990851;
	b=l0oYF4NL8qirkhEPOkbPtomBv70YhLevOwCzKFHSP2S9+CuN51bLzIXsL0fAY1KxgxeU
	 dpXzIT66nX48GfckfoqJHmUtLpy1w6txpqXMXl/qwNPnBvh9xxQDlaw4tFsxl/f7LYOtV
	 BYD3rI+WHznox4fIQSdACiJM02P+ExgRE768lJdqOM2d71ZQEtxNR2+rbTgqV3Y1eP+RE
	 E7jyupzKgjc4gVc2LyaG7nrLX+dmeOgVOP0TZIl+8HjUdqSuNL19BM+82G3e6GCrQnopq
	 lVlZXomPW0HpNZ7L192CvOTEINqMKXBF+pX2MSdB5KB6qzxqas+YsS+00yM/S7NGe4Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792990851;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Message-ID:Date:User-Agent:Subject:
	 Content-Language:From:To:CC:References:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
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
	bh=gMiVr0sKbJYBbZsFJmhkPQG5yJSSKc+QHx3UdPsjGp4=;
	b=peD9SMfSe9jtY+gI4CtdcWrLOkjhdrW6GUYbjth27lLBX4srSd7kqTE+Ee/BUJNIr5r6
	 qBzr02SrPOxD+T5Jzythk1Dz/AGj1936BbT0PgCQ0IayVQ0ZlEJDmKst0JRo41JmvV/Se
	 wWNDY1ONAwdWPRGABBLzY7UDsvzKA3gu3qlnMRFXHIs2du+k31hEY2tH6K67rXZH0SL3D
	 ElcDdMxcx7XJB6yj9ho/9XDqrdW4Y6xyXHw8l624wxAWMd4+GjN9tL3/bsWiiTbIywY58
	 qsuBTbqbffck4DUmfqoMjbMvZA1DrM1LuDx7zjXWpr0XM4uWqToxnS4Y0vnbRdc9dpw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="Vd/fxVX5";
	arc=fail smtp.remote-ip=198.175.65.14
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067FF606A31B;
	Mon, 26 Oct 2026 05:00:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 067FF606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Vd/fxVX5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792990848; x=1824526848;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RmbnGDgmtVCwoLoIxfGQGHGIKsBiwnYPJsPqJ/vAnL4=;
  b=Vd/fxVX5AirLU7fvgbtvWQ4tUVm2UwMjUO9mxwPrUYo3nWk1L1+3rz5O
   JFNT1e3A9eVXPlzYDkphNzqoJpKehWeuRFSgwbdeOi6JgweeehOd0wGUk
   fdnptWeMBmWSaJtgXzzz40yWoGdQD4/7icjwRFoKNtEelzWkhi+BDN6od
   BnSi10Shxuh2vsbi0bQfwpr7rEJzic8Se4nbPr+7ECqT3TBJetYxmEx0y
   uUEXTlq1hq52Gx5Hw2uvoZ5vln+7ojG8yk5k1jqnfBAC8HeSMArAMiwSt
   lNFMFm30kM0ztPBz5asBiNh0vgDISVeR00uosuISmODQZzcPSGAvUyZBs
   w==;
X-CSE-ConnectionGUID: CycZd7AnSzWQpcun08rYzg==
X-CSE-MsgGUID: mhWGtTb6R52pI1FgjfbNTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="1522190"
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="1522190"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2026 22:00:48 -0700
X-CSE-ConnectionGUID: meamlQx6TRyh58w4eVU+5Q==
X-CSE-MsgGUID: M/jIXsn/RROaGybGP9emtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="5996531"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa013.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2026 22:00:47 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sun, 25 Oct 2026 22:00:46 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Sun, 25 Oct 2026 22:00:46 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.0) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sun, 25 Oct 2026 22:00:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oMWPwKODZzhrMQVDkwxN40RbGb7qPdrZj6w4HsJ8b+rDrRpW4AYr+3X6hm9JkWnwlITslfMJ3o0c3zirBpph0PuBGZeaLvzBZaC+wA9WYrgwFCQh1MywOEkcX9zYzdpC8+wQ32TyhddCC/bPttrffhPn6Ix15pMttpaPiGbQJYT4ETxLYRAKTwdcIwJHX77njFttK1S0NWzFeR8iILxSTMeKxxlxDcSBuWkZgsV81eN554nOcuV8pKujyGDQpSfOtKU81Ghlf/y7HBXFyqngpWtACPOVb4As6gkqn4M8mRXfZZQ6uNCJ4476gqEYn1d0P/0JRsSgZORzqMokyx+7Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gMiVr0sKbJYBbZsFJmhkPQG5yJSSKc+QHx3UdPsjGp4=;
 b=Kg0bJF4XTcVdsSJqtVPG/uB/J4WjV2GJd9n3g+z9rQkCq0XZxg7Kd0GHCvZLgou/9yaJ595Hhgnj1aoP3CZiD9AxaJXbgU29Pj0lVOdrAWNefeemhGOciqmxDewOHsCEqR0w6VvO7KFm+OopSVp3zHUxmM4VtvYCYKGbxO9/9jcntuUJy08yBMufTxZvfA73U5Fr+T1MTMwO3d9GmD/RhU8IguuLJlx3tbXMuBWqo1cQxiC2Qjq9rLBpEITp0mLHcT5ZJ9ikvtM8lHABOMsPftHp5CQjJ/tkeYs9L2lnfvR0v6O52fZzHCuBeDqFFTTooJ6+lPr1ggqqusltroWeLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7846.namprd11.prod.outlook.com (2603:10b6:930:79::14)
 by SJ5PPF12B0A4A9B.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::811) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.21; Mon, 26 Oct
 2026 05:00:37 +0000
Received: from CY8PR11MB7846.namprd11.prod.outlook.com
 ([fe80::cae0:d05c:b2fc:c395]) by CY8PR11MB7846.namprd11.prod.outlook.com
 ([fe80::cae0:d05c:b2fc:c395%5]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 05:00:36 +0000
Message-ID: <5af354c7-9bbb-4ff2-b450-c08cc5b46304@intel.com>
Date: Sun, 25 Oct 2026 22:00:33 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 02/28] KVM: VMX: Initialize VM entry/exit FRED
 controls in vmcs_config
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
To: Binbin Wu <binbin.wu@linux.intel.com>
CC: <kvm@vger.kernel.org>, <x86@kernel.org>, Paolo Bonzini
	<pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, "Jonathan
 Corbet" <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, "Thomas
 Gleixner" <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin"
	<hpa@zytor.com>, Xin Li <xin@zytor.com>, Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, Andrew Cooper
	<andrew.cooper3@citrix.com>, Tom Lendacky <thomas.lendacky@amd.com>, "Nikunj
 A Dadhania" <nikunj@amd.com>, Shivansh Dhiman <shivansh.dhiman@amd.com>,
	"David Woodhouse" <dwmw@amazon.co.uk>, Chao Gao <chao.gao@intel.com>, Zhao
 Liu <zhao1.liu@intel.com>, Yosry Ahmed <yosry@kernel.org>, David Matlack
	<dmatlack@google.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
References: <20260911213659.2025974-1-sohil.mehta@intel.com>
 <20260911213659.2025974-3-sohil.mehta@intel.com>
 <acc168cc-e021-43dc-8846-ed1b2d69facb@linux.intel.com>
 <a0f99d8b-b67d-42f3-b76b-90187a0bea5d@intel.com>
In-Reply-To: <a0f99d8b-b67d-42f3-b76b-90187a0bea5d@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ2P220CA0004.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5da::11) To CY8PR11MB7846.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: CY8PR11MB7846:EE_|SJ5PPF12B0A4A9B:EE_
X-MS-Office365-Filtering-Correlation-Id: 78c34fd3-f209-433a-7752-08df331e12d1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|4143699003|11063799006|56012099006|261009223027099003|261022105027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: jxnuyAtar8J1+6+DnbO4t0Hx8g6vwDQYrnVmoYmf+/sCvsu/AjrBQqOYx55VA3Gx26p0D/OG1XbSpaXTcL47GRiNhwdC8olscvtqqPjoop3Bvlahr7x8JBJHlNkf1Xz8ns6zHRLujdYod5ceqMSv+JX1PYfd1Ro+B7Z4KP06lHUNomU1MFepqMqOWYWIe7anG/LdJ9M5CP9kSXr++QljZkPoJrjdG1YXNRuk3Z/XVYz7FTH+O+7okcuVNSs+zb566pumr0hIiBPo19OPZ08xhdDwpCRIqg1l6m9MlcKjo62aox8xMgQrj1peEP1Q88XhNGcvCkR+QHRTqDLYODfLHDQVLWZE8Elo/4J3z4F4icYcDwS6Xb9jQzl6BGlyv2RVkMUWsBHU3XkmS7+XzbwMiH8JgQu7LVfWNO5dYtwEbj1UQopRWV7mV+KqKUcbs54EM2v4NA+vvT6B5IqyWakDGzW1ujrBplKLtgb/pSjEV2unzs4UgHbt3JgKoMO+WdyaVBu+XAqrCxYNDqlqoRZ2ePSrV53XtQpoKuFscZhqhSD/cpDdHFw8zT36KHPOu7OBTi++tCRhlcC9IPZ7BEE0imWn595s0MoBdA2/VX1pGSWsPNrJDSP7BkzAUzdnP1v1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7846.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(4143699003)(11063799006)(56012099006)(261009223027099003)(261022105027099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VkVCTVNJTUtBZ21SaTJheWVENE14WmwrQktxMFdDTzRiVnhlOU5LU3dSd1VH?=
 =?utf-8?B?Wm00Tm81eFpoNTdjK1ZpL3ZFbm9ISE1yNkcwRnlFSmpaMXNvZGlZQjVTcjNC?=
 =?utf-8?B?WkN6Wkt4dXBQSG80YmNMUU8rY3Qwano1NGFrRHMyMGFPSzJGdjBsV0NuRUpu?=
 =?utf-8?B?SWNCaW1FQ1RSQVB5dWtMcm5tajlXUTNSVVJLQmhEZ1RTSVJpQnpCb1U5UEpw?=
 =?utf-8?B?a05BMDUxOWpKOFRUTDNOTkNZVC9JMzRqOU02a1d3YWFXL256ei9aRU1VK3k1?=
 =?utf-8?B?d0pvZmFDL2dHTmYwYiswY1l1S1c1czhERXBEaWNlaGpTVGd4UGJ2ZVduQ0F5?=
 =?utf-8?B?akpmUGFrTU5RN094VU0vaVFib2ZZN3RSZ3pmaGVqdkZhcm14Vm53b0I3TVBt?=
 =?utf-8?B?NTN4cEEyeC9OYWR0WXpSQS9hYWxEbVU3KzA1M3F2emtaVnZvVzJOTzJ3WnNI?=
 =?utf-8?B?TitZRjBaYlpvS3M1cUx5M3NlZDhmcktSNjlha1JQdVZxNDRmNjBjSDVYZTR1?=
 =?utf-8?B?aTltd0JXR1NDY294TVJhdDE5VnNFZmpRa2s4WHUzcDR6OHhpaHMveXhVZUpP?=
 =?utf-8?B?b2pWQXBtenE1S0hKTHFwdkZrWWFMc0hQcHloTklvNC9MZ3FOcXRQSFhvM21a?=
 =?utf-8?B?a3N1TG5mVkJBK2dXa0NabFFFVHdYUFlzUDZ0Nkpua3dXQ1EvWWZ2WmIvb21s?=
 =?utf-8?B?K0FkMUNmRFE2SHlYcDZXQ0pOWWVmdE1XU1AwdEdDUEJlS3BwMEU2Q2VpQkhF?=
 =?utf-8?B?ODNxVTczMi9ESHZXdk1vZnhPTk5oTE5jcHN0MnZBa2xWQVBkOGcyVlZCdHY2?=
 =?utf-8?B?bTRZdGNsejdQVmNoMStOd0FvLy9sQnFOam1kQkNwWFFucmJGeDNKQ1hhSjQ2?=
 =?utf-8?B?YkZsYmloQ2VyaldJSWR3b01IaUFmQUQ3cWFnZWkwVjhRczFIQ2N2WXgzY2Yy?=
 =?utf-8?B?M2puS25VSUNJa1NKSnJ5dVZOa0ZubEJQOHdmb1hsVlIwMWhEL2MycTV5TGxC?=
 =?utf-8?B?MkR4ekVsczFFTjNJVHIrL3NGNFl4SlhzRUpWNkNZK3BUdDRDQlh3VnVpSHFK?=
 =?utf-8?B?ZWFsQklkVDdlcXhNb0xlZjZIZXpzcDJyM1pyaG5kaDZRL3FQcE45WmJiR2Zj?=
 =?utf-8?B?SVhOeGtwdVVxbG03c1FNRUVDMnY0QzJzbkNBSmdJU2EwOHNvQ28weUFZMG8v?=
 =?utf-8?B?ZnRWMFNLa01yTUZ2Z3FRaC8yKzVUSGtUYTNPMmZyQTNjaE45VUZlWWpVeUZN?=
 =?utf-8?B?Y053ZUIrYzBwL2Q1NHlaa2hKKzJqUlpDOE1mQUhveGhKTzBtd1FuMnU4S3A2?=
 =?utf-8?B?bWNxeXhVbE1selFXRUZDNnh5NHVQV1VtNGc3eVVEbDZzd013Skh6aGtzRldo?=
 =?utf-8?B?L2pTUUlBeUtQVG9NQnZPbjZZZ2R3WklmQWVXVURuZ2MvNTdIalFNamtFKzJT?=
 =?utf-8?B?QkFyL3dseitOUWp2djlmck9lenE1bmxuaTgrU1lXSStYOTB5V0ozaXlZS1VK?=
 =?utf-8?B?YmxzSjh4ZzhpUjkvSGE3aHJYa2tkQTg5czQ1UW5LbXdRSEg1czcrNmFQdHcy?=
 =?utf-8?B?Slp2MG41M1JOU2VVVnd5cU1jUEZzQmxXWVAzS2dLSFFhdmNyeUErTS90Rk5S?=
 =?utf-8?B?bGlBSnc3cUlrd0YwaFhwTnQ0SjZjTmV2a2dGME5mQ0lUOW9pWGJ5YllieTZt?=
 =?utf-8?B?WGhzemRMM0hhVSszb2R2WkhJWnJYaE9oSTBHK3dIekZJZnU1UlZHMTBia3By?=
 =?utf-8?B?cXlscm9JWmI3RHFIR2djbnA4TlAwZ1JDOENKdkpweEhsYkp5cmN3NWgrRWVU?=
 =?utf-8?B?dmFkL0s1a3dVV0VxRURyMHRXK3NLbXRWZGxoMmZUMmdYOWtNcFRLYmN3aC9y?=
 =?utf-8?B?d2ZHbFg4YmduL21QUVhISzRNVWlnK2pjajdvVUNnTEJKK2I3RklqY3BoNlNy?=
 =?utf-8?B?UzJrNjNJSTFUL245dlRoc0MrVTQ4Vzl5L0NKYWkxeEhLTWgyUGp0K2FwUTRx?=
 =?utf-8?B?WENMTGRJL0VtR0dtTE1USzBqem5ubjFiYW5ZY0huNmlkZ3kxSXRGTnRXOUY3?=
 =?utf-8?B?NFBnNm9sYmZKOVMvQ2MvbjVaZmFoRlVYVldLZllIcnVsUnoxRDFGUXQwb3VK?=
 =?utf-8?B?bzdFWDRCNXlZVFZlQ09HYklqUVRiaWJLcjFSMmwvSjdmQ0hOR0hZdi82Ymc1?=
 =?utf-8?B?QTJWb1RrT1ZOeHlhV1BRL0tqWitLQW5SekU4dy9wbHhrTDVCbmc4NERyUFpK?=
 =?utf-8?B?c25CamhXSnVQN29ld2JuV25VU05xbUtJc2Z5M1o3VGtZMkp3UDhmaW8wSys1?=
 =?utf-8?B?RTZTbWFmditiT3lxaEtXazZWbnNUZ1dWU0pYaHVDejdrQUQwYytLZz09?=
X-Exchange-RoutingPolicyChecked: XOPPQYJdW7DqpwEwfkgftmWqvSl+jWXRkLAutrE4e7+ismb/a/y9rYvhxwUqGQhcHMSH4S2qj5lrV3BNFk1tqwG/Ez9xSMuG0zVu5zTYuyNk/FITl2aNmJBnoVBEPAMSy1jYorwPtpY8XGTRiDiNZU1oVi2nTFjh/PII7NpR4y3NQvEGp+QZvKXYoubs4q4h/vyxHCfleHSMF1XltVWMGxk0K2dRpZRJ/P5v0TWJWOFCIsR40PyWEkI5xXnf29ZvTa23lcbVaX47RQxf3PupgLGkXAdd0+R1+0rENE42HjdVjgY6AoubSacHykPaBO0sxALZL/9qcGM5mo7FYeGV2w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 78c34fd3-f209-433a-7752-08df331e12d1
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7846.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 05:00:36.8973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1A5/N2LpOM/XRTnN18MYfZdT71Pui/zadubpLZRs9pO64JRH7Tnsfeq7eogJfP2zFxEt6Y9qRPzZivLpq4ENYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF12B0A4A9B
X-OriginatorOrg: intel.com

On 10/22/2026 8:10 PM, Sohil Mehta wrote:

> I couldn't find any precedent for this. I don't have a strong preference
> here. Is it worth making future-proof?


I did a bit of digging. The current entry in the table is the result of
Sean's preference provided early on in the FRED series. See

https://lore.kernel.org/all/Z739wdGmk4ZuWJ8v@google.com/
https://lore.kernel.org/all/ZUz3cPmnqSq7Lol9@google.com/

IIUC, we want the FRED entry/exit controls to be consistent without
depending on the ordering.

The current vmx_check_entry_exit_pairs() doesn't cover the FRED case (a
single entry bit mapping to two exit bits). So, the updated check would
cover this scenario.

> if (!(entry_controls & n_ctrl) == !(exit_controls & x_ctrl) &&
>     !(entry_controls & n_ctrl) == ((exit_controls & x_ctrl) != x_ctrl))
> 		continue;
> 


1st line: the entry control is set if and only if *any* exit bit is set.
2nd line: the entry control is set if and only if *all* exit bits are
set (which is specific to FRED for now).

Also, to make it easier to read, planning to reformat it as:

struct {
	u32 entry_control;
	u64 exit_control;
} const vmcs_entry_exit2_pairs[] = {
	{ VM_ENTRY_LOAD_IA32_FRED, SECONDARY_VM_EXIT_SAVE_IA32_FRED |
				   SECONDARY_VM_EXIT_LOAD_IA32_FRED },
};

Please let me know if you disagree with the approach.


