Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB92412C0C;
	Mon, 21 Sep 2026 20:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790021512; cv=fail; b=MhZqGP2WhmQgM7L1uwiembVkaPwFarUTOl/6ENwX3MHmohYfTI2FuQbUOUPjdTNxKySDkQTsUeLVPVqJMXKGxTFObLaEr5prNE13+JnVKTeW4KiuhHOGV/RnsUGisTBhTdwfwmdTy1ox7m/oexCgUoSfa7IvmtJ3LgIS+UWc1p4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790021512; c=relaxed/simple;
	bh=iLNfn9Ocf5GeKRrcRc9F7ISBHy5Gdfruy29A2lt/toA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ViNLyGTRVQIpj2aLadXD7T/3BZr0No9NBNLnqbmIdO8LBuMz8w0qauZXUL+wTujzjVpUWqt5XoiLadwJwcQqDiLB3JIi2ZpHYx7iEs8qbZxovAG56/2ewb9TCJuOUx0pzwMpor3jKWSB8wtSRCSEgLPuBn3eKMiDqOLY/yzGCHg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=koKhjxdr; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="koKhjxdr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790021509; x=1821557509;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=iLNfn9Ocf5GeKRrcRc9F7ISBHy5Gdfruy29A2lt/toA=;
  b=koKhjxdrE2fq5D7T+3w5ZKM3dICJDjxiPTbtOF2WszpW7BKQD0N+Jyev
   g+hqujxgOWTaa3byWhWvsJXeybz+ElyQcU01iiJIEr8roP8sgCljcU/cp
   7VneW68JdZvVBrG44knNbhyMvqVX0pkvc1z0emKRwdHdAGLA8jM2i3Frg
   OaRCScDb03OZ4QSeU1HVCHOhpOUBsr0slRRWx4Nicx0OIYydalSPYfP0V
   plfaIfEye0/I79fOYMiSMNiG30aseliFi1yAyKqMoYugtqi7R3LWJf//o
   Qz+qfBA7qFRsqbirHRc48+1JwJ/heR1kwRdDFZy12lZc2GB8ixdmxU+dq
   A==;
X-CSE-ConnectionGUID: 6qZ0Bs1uQZ6PtyzgWruGVA==
X-CSE-MsgGUID: H93yEw5tRDy9MQa8N43atw==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="116096225"
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="116096225"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 13:11:48 -0700
X-CSE-ConnectionGUID: zBGS2KZOQj2mI+ucZtUkEA==
X-CSE-MsgGUID: 2TZpXyQgSyCyl1GFY7s2/Q==
X-ExtLoop1: 1
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 13:11:48 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 21 Sep 2026 13:11:47 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 21 Sep 2026 13:11:47 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.20) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 21 Sep 2026 13:11:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dRu5/RrMpL73xd73Ksq61ySC8gwWiWkBnrIT5eiXFfpHjqqvHx3F3foY9KqVntF7/JwTUCJ/A3ziZZZ9mKVfsQEtfZl+BCMQE5Yi65SDiK9U3rpzGDhRzCIvWFHNpkmNjWrPHYn1G3VCqakUHb7Onrm7BT/bhDRnKO+4Uk4OJVO0F9s8Z60SLwVhGoj2RonGqaF0OcWGLPuWcpldyWFSGt95BkzTsFJb3u2yblkz4kednkXJvm7MxDkdRwWufTiBexGKn8vhyhgUlV6HULvRh6iye91fkO/DYjkXd9yhikf9ObhxEFBlJgnLhFu34anq2ruLMOoBHx2s4udC2Kxu0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iLNfn9Ocf5GeKRrcRc9F7ISBHy5Gdfruy29A2lt/toA=;
 b=RlnkHcZIRYpjCZcpFHe8OTgraDt9A5+2OjAbEscu+kfqPKr2r0xf7EBjsvoNz8FnZd/v3Phba2lST1YQC0fKwEy85jzjG6olN22XY/Id4jAcYUKyUrM2ph9lO9wsaKalHUS3AdG3BGR7HNPHdr+0S1oo2CuPBflmyhXlbRx+dQzN+8FTrmOU5nu0SyPsEgFSgj/iMUysQkTRQGiLLSXzAjdMDL3aMSTAPP7WWSo+JgSBCc4wfY8EbaaTq8pIx0GzX6vglrSjkHEb/8yz/IMBFiqAxsM0NR7npPLfH6b9LqghIC9L6bIEatoFE/OhUDR1lYfJRSDs9RPA54onPhRAwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA2PR11MB5162.namprd11.prod.outlook.com (2603:10b6:806:114::22)
 by PH7PR11MB7004.namprd11.prod.outlook.com (2603:10b6:510:20b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 20:11:40 +0000
Received: from SA2PR11MB5162.namprd11.prod.outlook.com
 ([fe80::70e1:28f7:f440:ff0c]) by SA2PR11MB5162.namprd11.prod.outlook.com
 ([fe80::70e1:28f7:f440:ff0c%6]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 20:11:38 +0000
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "rdunlap@infradead.org" <rdunlap@infradead.org>, "corbet@lwn.net"
	<corbet@lwn.net>, "Hansen, Dave" <dave.hansen@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "kas@kernel.org"
	<kas@kernel.org>, "x86@kernel.org" <x86@kernel.org>, "Edgecombe, Rick P"
	<rick.p.edgecombe@intel.com>, "skhan@linuxfoundation.org"
	<skhan@linuxfoundation.org>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] x86/early_printk: Add earlyprintk=tdx to drive the
 UART with TDVMCALLs
Thread-Topic: [PATCH v2 2/2] x86/early_printk: Add earlyprintk=tdx to drive
 the UART with TDVMCALLs
Thread-Index: AQHdSgLautbTNw8zgUWTW1nFZjVjYLbZcwmAgAADwYA=
Date: Mon, 21 Sep 2026 20:11:38 +0000
Message-ID: <58df7c2c57f2e00b0322216ec56196781023ce62.camel@intel.com>
References: <20260921-b4-tdx_earlyprintk_tdcalls-v2-0-ad1fde3f25fd@intel.com>
	 <20260921-b4-tdx_earlyprintk_tdcalls-v2-2-ad1fde3f25fd@intel.com>
	 <12013d91-b945-40b9-a6e0-a025460eab72@intel.com>
In-Reply-To: <12013d91-b945-40b9-a6e0-a025460eab72@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.60.2 (3.60.2-1.fc44) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA2PR11MB5162:EE_|PH7PR11MB7004:EE_
x-ms-office365-filtering-correlation-id: c03512c0-335d-4cb7-a51c-08df181c8b5d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|23010399003|7416014|376014|366016|38070700021|921020|10067099003|56012099006|3023799007|4143699003|11063799006|22082099003|18002099003;
x-microsoft-antispam-message-info: de7KxvvyCwLOCWMli1k6EekPcsb/s5cgRyBYRjRqSShYaZwj2FgEfA4nsUTUHOQi09R2lDEusROcoGe6NHs3ie/y4JpJG3ycN7noMbK5h+KbW4I8RKZOd1usWweOpnMHzq/zmkROecq1TsnP6QfBVAQ5Sbvc+BGAWEbooeUFofi1sXgH6MYyubxtT5enbEVPF9eBXmOvYLmt/g+cTAHNAxkC0StwfohoWJdUD9mLyIBvX7zdQD4sbU2ARFW6VTf2/U+fI4wNplQRPxYgMwgbl8imdrXb5719O1xZtYoU7bSQulTJBM/aJxBRQJhlZVy4qIus5bjT+TrT8Is5VBSUhejLDxiTGuUzmcNSPQXCfXZuYM6Z8D+7DJqDvLJ9poDy4xZILVlNq6JTbqTU69R1ec2s53r9h5aCKcnq74mDZ88cridmL1rUF1z0+7UH5hC78nJrGaG9OI/oHFzxUYRdQ+fD0AgRFnIu1hmOPkpTLDzIhP2uLIZ+1mGDH7GE6DOGNYmVM7nsH9O6wkKLWs1QE1XXuL4TlMJpL9haSnynTdAICax0CxwTF6NE3uD2L13wElM0qVQoWZxbtW0exC20WMmjwX4NIB9Qusho5ZjiiaEoFTp1TwmTCFYDiAy1bpS31EakM6sRkHwYX0ICp6H3tKLtz0AU9uIL2LoBAbRMMdbFAWeWc42uJJfSGWPRJmgbqytnxcvmWY8aWnGcDd1T/E62dWT8tVIcSuZrDoFDzIMRDUV8NSIFJQeCv6HDCX1Z
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB5162.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(366016)(38070700021)(921020)(10067099003)(56012099006)(3023799007)(4143699003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WmJMTnhOWnBUekpwUVZuMzFGNEhUUk8vZWhDYUZvMTJlSEZVblhyN1FmTGtn?=
 =?utf-8?B?OVRpaytrMnZtZXNNd04yTDdNUTRxeGNnWHJOSjRCQmxObDhucWZ3YjRTTUxH?=
 =?utf-8?B?ajM3VWFhdHQ2YTB0WUxiTnI3R1R5RW1ZbE5LZlFQV2N0YTRtUlQrVUNISFNY?=
 =?utf-8?B?NmNYMjN0a2hhWWd0QU5rTjhCZmp4dmxXeERSa0VWSWMwRE1sVkt5SHJmSndM?=
 =?utf-8?B?NklFYzlpVjN2aWtiREI2elEzemh5blJEQitoZlQ2RmEzNDFTU3U5Y0pKOG45?=
 =?utf-8?B?ZzE4NTkyaWx2bXdqRWFuY0RqN05wZXMxeWIvK2dhMzhMaDN5QWRqK0hOcmZq?=
 =?utf-8?B?UUdGMXFYWjhyYkQxTmZUeW5YZVl6NjRUbnhpUEt1WGFWVmZNWVZtMjNtbGZT?=
 =?utf-8?B?RnpqRmNBNTFRQ1RQMU1FY01lRkJodkF4RmR3bmdmR0JGenloWDJwY29MNGpu?=
 =?utf-8?B?L2lzcnNmSS9kMmwySUpwNFlhayt0ZHR5elJoUHpnK3UyTm93NHI3YWp0bE5U?=
 =?utf-8?B?Z3RTdGZtOG84c2tON1F5T3RFZlhQWGNRM0RpcG40SU1ZWTFJcDZzSHBuQUdO?=
 =?utf-8?B?N1BxK2lsblZiZE5nWnpKb2pYZWV5UGRKUXRNWHhxOU9DR1ZlTTBVdnIzMkp2?=
 =?utf-8?B?ekQrREt4bVBaSlRQMk1RdVdaOGlMV0FaMXFCeEZBdFE1VjNKRS9ucVJqSUhx?=
 =?utf-8?B?UXBjZ2dGZGV0T3JYZFA3cmRnemJGMHVpWFBMTWlUOU5kOVN6YjlXeGR1cVU4?=
 =?utf-8?B?eWhnYndUTm9tajRWM1hsY2ljVFRjZWFSL0F3U3hDQzZOWXZldTBtYnp0Y054?=
 =?utf-8?B?VlNhWTNLMkZQNU9jUWRzMkdrN0JiR0ZDS1hSUFo0aUQ4S1ZLT3NXMlI4eEJv?=
 =?utf-8?B?RGY0d2Uwb0EvSW9uVG9XNUJocFJVSmtOeGIyTWNFcUx1SityK1pzOU95QS91?=
 =?utf-8?B?Wk4vQ2pYSnc1Lzc3L1l2bnN3aGxndmd1M25YNnBEeVU4WXZqZFRvQjdkbVZa?=
 =?utf-8?B?cTBEcm44bVpZYXJuQ2t1eGVTQVh1WDUwL29zWnhyWEhwUytHNmQvNk54clV1?=
 =?utf-8?B?U1ZVR1FYS09Eck41blpUalp2WmVuTHdxQU1iRzdwMkxIdXB5eWpoUWxCTnBq?=
 =?utf-8?B?ZVZoUXhYcDJTZXgwNTZnVXdCbS9zYzRnQS9EeVN1MlhsQmU4RlJYWlZpYmtN?=
 =?utf-8?B?VVIzeWZLc0RVdk41MjZXYTR5VmlvQW5pSHo5NzV3ZzdlYmpsSThuUFRiQlpL?=
 =?utf-8?B?blNsRWJDekM5akFGdjVuTmV0ZHhiL0tpOFNCbFpTSnl6cGNhZTE3YXl2ZzQ1?=
 =?utf-8?B?cUx4cjdBbDBndUovT2piQzJwMG1GMmxwQmtZNmdMK2pNbzZnL24wNUdxZU1Q?=
 =?utf-8?B?eGk3Wk4yM1g2cDU4NnJMVGFXVll4TngwdTZtNlpoUnRnWDlsWWZhYnBwSW1H?=
 =?utf-8?B?bHI1ODBEejJmUU42dTV2N1YrNUJORTIwZk1OZERyTjlFbVk0ZUYrQkdlb0FN?=
 =?utf-8?B?SVlOa1kzek91aUcvdlNiVngzL3l6YlRYdXZMQUtDUDJFWWVBb2orUXpQTHh0?=
 =?utf-8?B?Tm9vVGI3TFhwK0NMZ0JSMlZab0xJdXdqUlVpZU9EZ2k3MzNadkxKRlc4N3ZI?=
 =?utf-8?B?RmxnM3I2YmFMcjNtckRoejhld1c4cmJWajBBZ3F0SFA0akJmUW9wSDJWa2tT?=
 =?utf-8?B?TG1Dd1V5WjRTRXlabExqd0h5Tzc0TkdNelJId0RDaDZpRFBld2VIU3NPbXhF?=
 =?utf-8?B?VVl4ZTFVb3pkOWpFd2d0ak5TWUc0Z2gzZmEzc1R6d2tzU0dzcDk0U0M0eTll?=
 =?utf-8?B?OVovWFl4UXJzR2FGeEVuOVBscXE2SDdvSnVEczRXbzJMWU02RTlHeXo1ejlW?=
 =?utf-8?B?TmNEL2YrT3hEOUx6RmRyTEN1NnVQcVlka2k1bVBFMjVLYXRqMytUbHhnaHF2?=
 =?utf-8?B?Q0FPOWViZDZEY2tRby9OaVVQbVlBTHI4MFpqb2cvb0Y3ZHdxWUhSRmx5ZEpZ?=
 =?utf-8?B?TUxaVThGaUl0Wnppb1RXQnpGWkJ3RFByYUlBTldudE1NTmI0Y2c5ckwrNXlN?=
 =?utf-8?B?aTU3QzhvVExYVHo0L05KaEJMQS94WFVHVnRwZjRlZmo3RjlmU3RGdkhObUN4?=
 =?utf-8?B?eTRlOWtJb2U1NFhkeUFwYnN0Ym51aHFPSTZFWi9CbE1DeXl4b0xpQ1NObXRX?=
 =?utf-8?B?bE5CbFB3UXZaR3hoY0F5RzdMUlFRNlhWeW5BNE05MEM5Mm1GVmdVSmp5L04v?=
 =?utf-8?B?eWdOQ1FNUFRuc044ZDJOVk1ZWUJXajcrRjdmZGRFYUt3TnhhcEpXek9EaUVi?=
 =?utf-8?B?TmlYdWFVa0piSTBENEp1SGR5dkdhZjhHR1JQUHFvQ0RNVzhMV3RkR3BUc0U3?=
 =?utf-8?Q?q8b11ctM2/df9Umo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <692E277A02E36644BFE322C548E3E040@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: IgEpnh+nadcR2clS35npSA/PuPF6SAcGbYyAml38SGKL3a0+RRne2c+WKRh6Q8bn8JfQoCv1kq9CJN4PojBp5jtRtih39i4kvfVJEi7/bZSCkMrUIsB+FK1usD5xrzDYwMB7NczH7D3xD4tRNJ9lsgO4lSVzY8lmAUCy2RuUfqYb0tTHNxWtMckLfnq29ZKIgvOhmrujYSZdzw9ruRCxYRwJL4c3mpeYqx6RMTS+WvXYHsLMUU8q5UWa2j4/ZS+vxDe6e1YuEUhJDhMdnLn7+DXJC/NENJJCOLjVtqWfCkigWQLJ09nX+qMsRXGb33cTHU7K8mFQS7+uIg4p9zGbXg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB5162.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c03512c0-335d-4cb7-a51c-08df181c8b5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2026 20:11:38.5607
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KwNFG2pQkk8OLVYKYPBNaRSqKX+83q9ns4iMwo+qEpAtbuKjrg6YLy5k0B9LmwGefdNY1kurGVCwZShv3bAAuycTuQFQdW+2BTFvYwiTMrw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7004
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI2LTA5LTIxIGF0IDEyOjU4IC0wNzAwLCBEYXZlIEhhbnNlbiB3cm90ZToNCj4g
T24gOS8yMS8yNiAxMjo1MiwgVmlzaGFsIFZlcm1hIHdyb3RlOg0KPiA+ICsJCQllYXJseXByaW50
az10ZHhbLHR0eVNuWyxiYXVkcmF0ZV1dDQo+IA0KPiBJc24ndCBrZWVwaW5nIHN1cHBvcnQgZm9y
IHR0eVNuIGFuZCBiYXVkcmF0ZSBraW5kYSBzaWxseT8gSXQgY29zdHMgYSBmZXcNCj4gbGluZXMg
b2YgY29kZSBhdCBsZWFzdC4NCg0KSSBrZXB0IGl0IGJlY2F1c2UgdWx0aW1hdGVseSB3ZSBjYWxs
IGVhcmx5X3NlcmlhbF9pbml0KCkgdG8gc2V0IHRoZQ0KJ3NlcmlhbCBwb3J0JyB1cCAtIG1haW5s
eSBzZWxlY3Qgd2hpY2ggYWRkcmVzcyB3ZSB3YW50IHRvIHVzZS4gVGhlIGJhdWQNCnJhdGUgcGFy
c2luZyB0YWdzIGFsb25nIGJlY2F1c2UgdGhhdCdzIGp1c3QgaG93IHRoZSBoZWxwZXIgaXMgc2V0
IHVwLg0KDQpJIHRoaW5rIHR0eVNOIHBhcnNpbmcgY2FuIHN0aWxsIGJlIHVzZWZ1bD8gVGhlIGd1
ZXN0IGNvdWxkIGJlIHNldCB1cA0Kd2l0aCBtdWx0aXBsZSBzZXJpYWwgZGV2aWNlcyBhbmQgc29t
ZW9uZSBjb3VsZCBjaG9vc2UgdG8gcmVkaXJlY3QNCmVhcmx5cHJpbnRrIG91dHB1dCB0byBzYXkg
dHR5UzEsIGFuZCB0aGF0IHdvdWxkIHdvcmsuDQo=
