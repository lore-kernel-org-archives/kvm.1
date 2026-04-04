Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B28B1A6805;
	Sat,  4 Apr 2026 00:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775261724; cv=fail; b=eX2EJ9a9CUNm8R5RnBn0UBVYD4t2pbRAwMBu/BHbQ4+A/hI78+sNB5BVIMQaxUlmAsP//M7TbDCK6kJZ1NRW6Lq291HCIGfcmCSuf5SySsGMVHaXDv8CxRDbGkXBVzIl8qeOpr1JZpp88r3dcMmLxLWQdW4BMhcZWIyaJ0VUocc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775261724; c=relaxed/simple;
	bh=3+XLbKAnFhb8cbwHMt6lL0yFne7HAG9nCi6TP6Xscbs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sJxI9+KbacgmMQiiWdEY3nEuZloxUn7Rmp42Cko3kegHIn64lCLAGwcMdDdkb2nVXtarmIkEETzMIXWvLmGDYPzDUqL2rcaI6aqM95i0Q+hJqKi6M+UwejM/j7AXZebu4ub+gPUjvAr0RVfakCfuetS9kTEfqWXjUarCO2600ig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CPbmuT4a; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CPbmuT4a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775261722; x=1806797722;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=3+XLbKAnFhb8cbwHMt6lL0yFne7HAG9nCi6TP6Xscbs=;
  b=CPbmuT4a5tozKa38DBNtmDPHboZMHMkeB13c5RtqjMTY+byoiE/DisJp
   C6MzQzPxM0S56qGF8+SdAiR2H4IOKIPG1+1fnreQahwogRCYP/F94VRfp
   IA3xgMCZWA8MjHbWsrAOVV2fVNgKkWtvQPYbM+vwyt8hJy0zJ5x4bl6Im
   vSBFN0bAR3TN9b/4HrTWB/gXPLpV+axHI0E+Sri4XX7CWa72Xjdwsd4G6
   pN6oPmr/sSA9/kaKh7FoxPW6Xi4IjoDgdBSgckWK3Zqbn/rXhU2D3j4vk
   ZAYsbZ2eEB12oncJ6PGiQNiBj6gxijjDuBe+pmAFsWLcRXWY11w4FEcbN
   g==;
X-CSE-ConnectionGUID: HdK+ZmvIQ7iXutUueR1l+A==
X-CSE-MsgGUID: uUlvqQ+CSVqDw0hBgHBSSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11748"; a="87709985"
X-IronPort-AV: E=Sophos;i="6.23,158,1770624000"; 
   d="scan'208";a="87709985"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2026 17:15:22 -0700
X-CSE-ConnectionGUID: 9vLsi8ADSNy9wDjh8ZCJHQ==
X-CSE-MsgGUID: CfYqfsdbRBilJdGg6mZASw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,158,1770624000"; 
   d="scan'208";a="227625289"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2026 17:15:21 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 3 Apr 2026 17:15:20 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 3 Apr 2026 17:15:20 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.2) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 3 Apr 2026 17:15:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TqWyHYxDUe8ttTwFIujZVZKOMSQO1R6wykpevQ59EGiU4zn8RvmiCDhx1WnafvF1geqE+9Kw02R7Cog5mG8bXQPcN0vfy9nRVSBlH7ofLEywpj3aTBfVOeJENUSnnliGwYygwTVbyKIGYwjk937v9QQ01jXZabrY+JjKZch7nfu9d4Zx8iLlbmuGl6hPVlldurXsM8fD8KVjjVwdNUb9gGYWSpBK8bUv3lscKbPHc2xUyZQS73iAIV0skGOXY9RHqDDVLBaFtLJPiUxADIfEcNQGZv8TQtCbqUSNmPHQ4S/bRPEhs/+fmIi5ylTIGLPXhLjrfXHO60YtyO8JKxoUDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3+XLbKAnFhb8cbwHMt6lL0yFne7HAG9nCi6TP6Xscbs=;
 b=E3B2zIX37BlSrS2Iwe6rz8EaoG6pzgQ4XtfzsoBGIpI/Fti3O1aylYCAyv9gawttElmC8DX0jwN6nYxzLxGhu0t7kirdYYTqFio1+nX2ngvwzfstb//HP1yiKlqxQAJ/Arxt2wL8lNCSt+CKylm9LTWhoaLjMpgaHQNtc4C2hIK4mpO/2Iu7A2UPwBvbKwimhKc4g6SZ4qmM7OUt0y0rBNZD2Ls3mRyL4d+NovgbAsmBQPxHEcdWIwDJavo5SHTWwpbTvxzvWin1zsA2O4DvluS1zxts5FFsyfZHGPjS0njU+j7ANio731ccparPipCviBcEWgw8+IEDmn2SPprgog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by IA1PR11MB8788.namprd11.prod.outlook.com (2603:10b6:208:597::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Sat, 4 Apr
 2026 00:15:17 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65%6]) with mapi id 15.20.9769.017; Sat, 4 Apr 2026
 00:15:16 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "seanjc@google.com" <seanjc@google.com>, "Zhao, Yan Y"
	<yan.y.zhao@intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "Hansen, Dave" <dave.hansen@intel.com>,
	"kas@kernel.org" <kas@kernel.org>, "Huang, Kai" <kai.huang@intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 07/17] KVM: x86/tdp_mmu: Centralize updates to present
 external PTEs
Thread-Topic: [PATCH 07/17] KVM: x86/tdp_mmu: Centralize updates to present
 external PTEs
Thread-Index: AQHcviZXKVkTxmL/NkWOkEaa1Zh4L7XGnJGAgARKfICAACVXgIABYwyAgAAFGoCAAKFSAIAA/hEA
Date: Sat, 4 Apr 2026 00:15:16 +0000
Message-ID: <d4319635e971e38534509b7424c6c08fa729209c.camel@intel.com>
References: <20260327201421.2824383-1-rick.p.edgecombe@intel.com>
	 <20260327201421.2824383-8-rick.p.edgecombe@intel.com>
	 <acoUt9vy8OPU1SW9@yzhao56-desk.sh.intel.com>
	 <8a107d4da92d4cf910f9a70991a0e67b42e04d4f.camel@intel.com>
	 <ac3Ng7IZpzJczZ2x@yzhao56-desk.sh.intel.com>
	 <4dfb4c106c834cd13da78872bfb262e98581fa55.camel@intel.com>
	 <ac77oSNltyE6vkVD@google.com> <ac+C9FdF34JRNLWH@yzhao56-desk.sh.intel.com>
In-Reply-To: <ac+C9FdF34JRNLWH@yzhao56-desk.sh.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|IA1PR11MB8788:EE_
x-ms-office365-filtering-correlation-id: a6062e73-ce90-4ecf-fff7-08de91df3fee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|22082099003|38070700021|56012099003|18002099003;
x-microsoft-antispam-message-info: 7hguNe8ZjW9m5DEonh8ZcwkoxDfUWXQ2wFJH79Rugi9ijWfDvOsxU8o5iCgD++xxY0TY7uO4LQB7skplz/oSg6GMRdhHybTqj5JpgJM5FQdsCEvZfn2Q8EGJVxsyaeSYyeIH68G34RpaI6r8dcmTtZEJtchNbIVcjE6hErhiBPajbjcZJUksuqH6xXcnP7uiy5iYG2LEJvqwd9o3PBHyaSxEnf5ROb+sxMDOmsD01LdFadp7yerapo9B1EhL//YVCj9+LXEL9kFVPTrFGoQdEu2KOsJaV286jnl7f+k8EdGax9XaeCz6vmjhsZGNvqHL+qd4Is7D+e/LXEdWxb/RRwoYO0t63W4Z9w9h6Rjk37lPvzqRXri9RjLxhqLkMcpyjCtRbVwDqSfTW5IBCvJ3MVk9kNwKzdAwF4nDASMqrPMBbFfp1nOodn2WofLcqyiWhkU/+uAhhzgxccv39o5aTt+yWYg7cDQaQ0B3ekGoHopOZ2UYdvF1izev2+BJ5BSryk9/PnK9EAcdqtHrhGuyEC8gAQMcWX/RQprkiYN5DickQWUXRU3jz2eFHpoOXHIDxzpjZAOf/UijJ0NG92ZMrBs3i//t6OUH4Jb9tw7iC7fQCY2PWJg9f717rfMPp7d/RzAVO507fQP+/BV+kuFgjQ4nHi8Q6Dqy2s8VsA00nT2ZBaOoBJwJiipl5h5c5SSSx+TYnohfNTcIlVEYYiNMQ06Ejpt6kw6axEJKdxpbRa7YcWl6/Y8XMRvwHNq9ZVEqJg/0z8rDhMhuR9VdEHjiq/ob8ute2pjwOGkDBncf7oU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(38070700021)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UllVTnE0dWtPeTJueStpQjNNWElXRW1TSCtLSTkvOWFjZFRvQ1pXY2E2YS9U?=
 =?utf-8?B?L3Q1M0o1amVRTVFmdmFzRFdweFNhN1p5TkpjR3Zpbm5vcUlEV3I4eHhUVTEz?=
 =?utf-8?B?WVR2UUtDQlp2L0VWbVNMMUNnaW5rTnJzRnU0a1dzZ2xZYWxqN1dpL3ZLTktx?=
 =?utf-8?B?YmprUi9TTEtxMFRPZ2Q1b0dkMGNFWU8wUmFyL1lXc25XbzhvRjNmclRraEEz?=
 =?utf-8?B?bjFZcmZ4Z0h5bmNITnBXTUZqZkhIUUNUeTZOMUwxcFcxWXdTRWdFbmtrYU9D?=
 =?utf-8?B?bFF6K2lSbGNtS2d4eTFZQkVXQmtIT3lsNVEreWoxNGNYVVZ3QTRhMEk0YXJW?=
 =?utf-8?B?S2RYLzc2eUFETStXanhvMXlhQ2txR0xpREhoOURweFByL3krZkVmR0FLSm1j?=
 =?utf-8?B?MGo5Nk5VWTBRMmlQdFdTdXRuM0dNRHoxSWtRSDAzYXNvc0F0MHZSUTBYSHBk?=
 =?utf-8?B?MGJ0L2hXbXMyaXg5dHZQSnZuV3FYZW5SSEpvd2VEb2MrK2F3bUxxRURRUG5E?=
 =?utf-8?B?VDYyaGdTbVY1TlJtSWdLK1NPU3oxNGhURjJZeE53NmU4MkpoYjlMRU9JMEZZ?=
 =?utf-8?B?Rjk0VmRXN1YrTzZVSGN6WXhIUnBzMkFsei9GR3BtMTNqbmVhTTk1ZlUvUDV5?=
 =?utf-8?B?UW1LZktMU3ZXWFZ6RW45MXVqZEJmdTY4L2VwOHVBOXl6MlR4bXpRMVBsM09r?=
 =?utf-8?B?U01CdHVyWEwvOGM1NDNBQlZJdFh3VEtrSjhZcHgvQzVzSy9PTmt1NGtvaTR4?=
 =?utf-8?B?Q3FVRHNOVmFqbXJYbzN5SWpvcWFYOU9PZkJVTElaQXVBTWhIYytJTi9NWjZO?=
 =?utf-8?B?VmhxWGhHRitwcksvMDYrSG4rSW5zYVFRTDZOSS9WQW5HK2ZQVjJISXZyU2V4?=
 =?utf-8?B?cUdYbVFrb1I3Mk82MWFEZ0ljdEVTYXpnQ2huYUg4dXVMRE9HdXpPbCttSk94?=
 =?utf-8?B?RzJmTzRXcExxcEg0RDZEOTFVNW9EeWt6M096eDdPU0prVGw5N3NHQTdhT2hE?=
 =?utf-8?B?OTMzQkhYWDBreitYQkNaSkxyN2FKRTU3eWI1UGVZbXM5dTFVRTVjMUpXVVdu?=
 =?utf-8?B?TmtvYVdCZ3QwL2thNXdQa0d5dGZrc3lSNjVkRXd6aW1UeW9IbEUzUXVJWm93?=
 =?utf-8?B?SEg2MndwSEFEOWpSdjBMK1ludElrakU3MURMRnB1andnVEVUTXVFQndjclRD?=
 =?utf-8?B?ZnhzbnBKcVFTeDVJV1gvdUxwUjdxTktTbFI4NzlUam95K0dTd1NxUWVheHVM?=
 =?utf-8?B?dk9VcjczSjc2SVl1d3FZbVN6akIrVjRzcE41aExHN240dldlMFpLV2gwbnEz?=
 =?utf-8?B?MjBOZmFLRTl5MjMvWDFLbFBSamxmTld1WDhEQzZoT2t5QzBRUEVYZkc5SmNi?=
 =?utf-8?B?dElJcDlsQlc3MmNvQTA4SWxKZGx6MDdzSDkzMFZ6WGQzcGVLWE91eUxiZ1Er?=
 =?utf-8?B?UmFsZWJpREl4V0ltS1o5dDdTRW8yMXMwakhzSUVUVEp5SVRhL2IwWU5OT2Ey?=
 =?utf-8?B?a1ZLT2lHaWFPVVBpcXJRL1JPT2pOelNzbHFrTWgzZWMxUW90b0poN0FMbjh4?=
 =?utf-8?B?NUpRQTN0Y3dDSHRkN1kvUVk0QytvYmx1WVhTd2w5T3RYQXhKZE1jRk95ZWNH?=
 =?utf-8?B?MHZOWUFwQkFIZitDS2xZb3JGem8vNGN6ajlERk54NnZxZG9LbDIxQmFQOTBM?=
 =?utf-8?B?S2NQNzVzTkJGT0FsQ2V4VXRBMURwVTNnQUNwZzRNWVlwejJIV1paam8zVHgw?=
 =?utf-8?B?QnRDZTBHRkFtNnpwSlg5Ymk4WkFFWm9JODM1NVh3RllXdWwvaVM1R2plcEkr?=
 =?utf-8?B?WFhKaGEraUd5V2EzQ0VnQ2FrekNlb2JPeWRRQWtMcXJHUGF0Y2lqRnRjdnFB?=
 =?utf-8?B?SW14ajgyQWNpMWdjaGVqaHlLMndXdWhnRGtZOUNQeDcwdFRJR09FOWNweVFE?=
 =?utf-8?B?WVdweWd6TDZ0V09pekttS2dXc0tOK1dWSkw3RWpwS3JNcHhHeVphelBSYWtm?=
 =?utf-8?B?aWRQRFV2VFF6ZlhRUWdwMmF2Ui83UHpMYWI5NS9GbWFDYkh1NklHUEZ2Z0xn?=
 =?utf-8?B?d3lpUW4yd2x6bzZnWURZVUM5WWl4QnU3Z2FsZ3pmRmJxY0s0OHlqZlg4OG1t?=
 =?utf-8?B?VEQxdFAvaGhYa0NDcVJRSEQyeEdKSUJmNnJqZ2c1RUIyeXk4c1JJQ1V4NVJy?=
 =?utf-8?B?eXUzN294aGtoemZJcTZkaU43Sk93YlA0T0pMYkZCR09kUWlpdGdCWTduQWpH?=
 =?utf-8?B?UnV4OGd3K1hYS1RQelp0SlJGYmtmSkYzb1ZrR2o2UTl5NW8yVjdJRkxtcnZy?=
 =?utf-8?B?ZFhUZ0YwTVR5cGY1T01xZ01xK3hycmVpV0MycDlVVmpCdjBlOXJHZTVMTU1z?=
 =?utf-8?Q?OPD0NUCLBVKtFGgo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3A70ADD75D0FF4478965DAADB1066C9B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: p0kcFQ1xf6JnQ8P2sViw7vj5SoYVnSXpvVNJzVoHzwJ/pHowsEup7HNG1fQtQ551Nls4YKuZhTLPxwM9IEj5mpOLE3qHI04bPIHGUEXclurb3otbT3VVSIZ3/pipNP36Dnx20BNET4PaMcTMxJM+5mEpb8LaTtjwTDl/jc9vgcVF/5kWb1oAECKT1Q30PBn1aahoDMeez79uhzYK0uUoRuEXUjoJQfuWR5nze9qkMA0g050jo1SanJ9qK9QlgOYVUN0UoAK+YJtvweFu+ctkOPUsyWW0zDUWqOu9eqa8ULvkN61KzYtlVevUiZ3O9849DSI+Ic3C9iSmDhYOGAnU8g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6062e73-ce90-4ecf-fff7-08de91df3fee
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2026 00:15:16.9253
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ugdvzBlT3SFOCJp6G1TYOEljwlcd8NxiuzdSzxUu4ulSyN+JdOmeWu9VpR4Oj4qZ1ruYuV4fh9Z0GC7bIlifLd6v8MvJmBz21UsN2AwjyfE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8788
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTA0LTAzIGF0IDE3OjA1ICswODAwLCBZYW4gWmhhbyB3cm90ZToNCj4gSG1t
LCBzb3JyeSBmb3IgdGhlIGNvbmZ1c2lvbi4gSSBkaWRuJ3QgZXhwcmVzcyBpdCBjbGVhcmx5Lg0K
PiANCj4gVGhlIG9yZGVyaW5nIGluc2lkZSB0ZHBfbW11X3NldF9zcHRlX2F0b21pYygpIGZvciBt
aXJyb3Igcm9vdCBpczoNCj4gDQo+IEJlZm9yZSB0aGlzIHBhdGNoLA0KPiDCoMKgwqAgMS4gc2V0
IG1pcnJvciBTUFRFIHRvIGZyb3plbg0KPiDCoMKgwqAgMi4gaW52b2tlIFREWCBvcCB0byB1cGRh
dGUgZXh0ZXJuYWwgUFRFDQo+IMKgwqDCoCAzLiBzZXQgbWlycm9yIFNQVEUgdG8gbmV3X3NwdGUg
b3IgcmVzdG9yZSBvbGRfc3B0ZQ0KPiDCoMKgwqAgNC4gaWYgMiBzdWNjZWVkcywgaW52b2tlIGhh
bmRsZV9jaGFuZ2VkX3NwdGUoKSB0byBwcm9wYWdhdGUgY2hhbmdlcyB0bw0KPiDCoMKgwqDCoMKg
wqAgY2hpbGQgbWlycm9yIFNQVEVzIGFuZCBjaGlsZCBleHRlcm5hbCBQVEVzDQo+IA0KPiBBZnRl
ciB0aGlzIHBhdGNoLA0KPiDCoMKgIDEuIHNldCBtaXJyb3IgU1BURSB0byBmcm96ZW4NCj4gwqDC
oCAyLiBpbnZva2UgX19oYW5kbGVfY2hhbmdlZF9zcHRlKCksIHdoaWNoIHByb3BhZ2F0ZXMgY2hh
bmdlcyB0bw0KPiDCoMKgwqDCoMKgICgxKSBjaGlsZCBtaXJyb3IgU1BURXMgYW5kIGNoaWxkIGV4
dGVybmFsIFBURXMNCj4gwqDCoMKgwqDCoCAoMikgZXh0ZXJuYWwgUFRFDQo+IMKgwqAgMy4gc2V0
IG1pcnJvciBTUFRFIHRvIG5ld19zcHRlIG9yIHJlc3RvcmUgb2xkX3NwdGUgDQo+IA0KPiBTbywg
dGhlIHN0ZXAgdG8gcHJvcGFnYXRlIGNoYW5nZXMgdG8gY2hpbGQgbWlycm9yIFNQVEVzIGFuZCBj
aGlsZCBleHRlcm5hbCBQVEVzDQo+IG5vdyBvY2N1cnMgYmVmb3JlIHRoZSBzdGVwcyB0byB1cGRh
dGUgdGhlIGV4dGVybmFsIFBURSBhbmQgdGhlIG1pcnJvciBTUFRFLg0KDQpIb3cgYWJvdXQgSSBh
ZGQgdGhpcyBpbmZvIHRvIHRoZSBsb2cuIEkgdGhpbmsgeW91IGFyZSByaWdodCwgaXQncyBhbiBp
bXBvcnRhbnQNCmNoYW5nZSB0byBjYWxsIG91dC4NCg0KTm93IGl0J3MgbWFraW5nIG1lIHRoaW5r
Li4uIENhbiB5b3UgKGlmIHlvdSBoYXZlbid0IGFscmVhZHkpIHNjcnV0aW5pemUgZm9yIA0KcmFj
ZXMvcmVhc29ucyB0aGF0IG1heSB0cmlnZ2VyIHRoZSBLVk1fQlVHX09OKCkgaW4gaGFuZGxlX2No
YW5nZWRfc3B0ZSgpIGR1ZSB0bw0KQlVTWSBvciBvdGhlcj8gTGlrZSBpbiB0aGUgaGFuZGxlX3Jl
bW92ZWRfcHQoKSBwYXRoLiBJIGd1ZXNzIHRoZSB3cml0ZSBsb2NrDQpzYXZlcyB1cz8NCg0KSG1t
Li4uIHplcm8gc3RlcD8NCg0KPiANCj4gPiBZYSwgSSdtIGEgYml0IGNvbmZ1c2VkIHRvby7CoCBG
b3IgbWUsIHRoZSAidHJpY2t5IiBwYXJ0IGlzIHVuZGVyc3RhbmRpbmcgdGhlIG5lZWQNCj4gPiB0
byBzZXQgdGhlIG1pcnJvciBTUFRFIHRvIEZST1pFX1NQVEUgd2hpbGUgdXBkYXRpbmcgdGhlIGV4
dGVybmFsIFNQVEUuwqAgT25jZSB0aGF0DQo+ID4gaXMgdW5kZXJzdG9vZCwgSSBkb24ndCBmaW5k
IHBhc3NpbmcgaW4gQG5ld19zcHRlIHRvIGJlIHN1cnByaXNpbmcgaW4gYW55IHdheS4NCj4gSSBz
dGlsbCBmaW5kIGl0IHRyaWNreSBiZWNhdXNlIGl0IHNlZW1zIHN0cmFuZ2UgdG8gbWUgdG8gaW52
b2tlIGEgZnVuY3Rpb24gbmFtZWQNCj4gaGFuZGxlX2NoYW5nZWRfc3B0ZSgpIGJlZm9yZSB0aGUg
Y2hhbmdlIGFjdHVhbGx5IG9jY3VycyBvbiB0aGUgU1BURSAoaS5lLix0byBtZSwNCj4gdGhlIFNQ
VEUgaGFzIG9ubHkgY2hhbmdlZCBmcm9tIHh4eCB0byBGUk9aRU5fU1BURSwgYnV0IGhhbmRsZV9j
aGFuZ2VkX3NwdGUoKQ0KPiBoYW5kbGVzIGNoYW5nZXMgZnJvbSB4eHggdG8gbmV3X3NwdGUpLg0K
PiANCj4gQmVzaWRlcywgYW5vdGhlciB0cmlja3kgcG9pbnQgKGN1cnJlbnRseSBiZW5pZ24gdG8g
VERYKSBpcyB0aGF0Og0KPiBiZWZvcmUgdGhpcyBwYXRjaCwgdGRwX21tdV9zZXRfc3B0ZV9hdG9t
aWMoKSBjYW5ub3QgYmUgdXNlZCB0byBhdG9taWNhbGx5IHphcA0KPiBub24tbGVhZiBtaXJyb3Ig
U1BURXMsIHNpbmNlIFREWCByZXF1aXJlcyBjaGlsZCBQVEVzIHRvIGJlIHphcHBlZCBiZWZvcmUg
dGhlDQo+IHBhcmVudCBQVEU7DQo+IGFmdGVyIHRoaXMgcGF0Y2gsIHBlcmZvcm1pbmcgYXRvbWlj
IHphcHBpbmcgb2Ygbm9uLWxlYWYgbWlycm9yIFNQVEVzIHNlZW1zIHRvIGJlDQo+IGFsbG93ZWQg
aW4gVERQIE1NVSBzaW5jZSB0aGUgYWJvdmUgc3RlcCAyLjEgbm93IG9jY3VycyBiZWZvcmUgc3Rl
cCAyLjIuIEhvd2V2ZXIsDQo+IGlmIHN0ZXAgMi4yIGZhaWxzIGFmdGVyIHN0ZXAgMi4xIHN1Y2Nl
ZWRzLCBzdGVwIDMgY2Fubm90IGVhc2lseSByZXN0b3JlIHRoZSByZWFsDQo+IG9sZCBzdGF0ZS4N
Cj4gU28sIGlmIHdlIGFsbG93IGF0b21pYyB6YXAgb24gdGhlIG1pcnJvciByb290IGluIHRoZSBm
dXR1cmUsIGl0IGxvb2tzIGxpa2Ugd2UNCj4gbmVlZCB0byBlbnN1cmUgYXRvbWljIHphcHBpbmcg
b2YgUy1FUFQgY2Fubm90IGZhaWwuDQoNCkkgdGhpbmsgd2Ugc2hvdWxkbid0IGNvbW1lbnQgdGhl
c2Uga2luZCBvZiBURFggc3BlY2lmaWNzLiBJdCB3b24ndCBjb25mdXNlIG5vbi0NClREWCBkZXZl
bG9wZXJzIHdvcmtpbmcgaW4gdGhlIFREUCBNTVUgSSB0aGluay4NCg0K
