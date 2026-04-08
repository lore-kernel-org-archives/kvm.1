Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8D439FCC1;
	Wed,  8 Apr 2026 08:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775636539; cv=fail; b=ErhrgfCwv0I2aA/0xNVf+/c41zFf5GCf8m6MtY6fvw43XmmS0GfPmonaXosbdnrmrntOHvu4TUU9WQ+lWDkU5rIsUDjGt5ydNfKuoMsyisl4+OZEzsWPxjXV9zG0BDLWVrTN/adZNVoQXl1nkREYF9r5UmOgemIjZnphhqB4Aos=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775636539; c=relaxed/simple;
	bh=LWnNME7zSvYKViuCIyeitEAJnR2C4924uUteGemWUmE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lrjaFgalR6PtUAEk6OmPiwbEDG4cYEl1/Pq2YVP84xean1EoovdB29gfs0a/Y6bU4AyMZoqY6Rk1yp/49SEFmlTfuW0Zxn+o9Mda23Pvgk8jGhookfiIinXymTLu+1QE0X6/wwlbhTusRl+/XyFj6mSB3AJI5InUy/Jw/cNRmew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nDF4Ne/K; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nDF4Ne/K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775636537; x=1807172537;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LWnNME7zSvYKViuCIyeitEAJnR2C4924uUteGemWUmE=;
  b=nDF4Ne/KqNFpZ4JE3HrXlNe9kIDowl4gVhTy+FLQaM4RLEkdixLiQiwu
   OnysqA2FyDHr6zMi14UYCaJRPkSGblJhoqmCbnFy3lkO+7VfXZ/p+1Bpp
   ALhCbO5++cXVYnXXY+IYRt+8BQO/DVkaw2LDHwQioRGpz2X6TebwPq6G9
   BeOhVPeokPAMNBNpffjZwC1jyhfh+OKsD67JfvTaVjBDlUX0qSI6sLXQO
   Jy1dv5ikO8PiKgHc4vmG7lea7I0ujfIBIQEpQz9jyRPCHe1c5qFzN5C8V
   QjIjDsHVIWtHknno+K6PpwOuPBl6sbNYYMZEjaXQdA1dV6SwsNwZWDyCI
   A==;
X-CSE-ConnectionGUID: TdcFZgJVREOgHfjyDvv3gQ==
X-CSE-MsgGUID: I8+wOIgnSLWTEo5dS6Ajiw==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="76801013"
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; 
   d="scan'208";a="76801013"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 01:22:16 -0700
X-CSE-ConnectionGUID: QvzVOI7JTKagunGpfLGxjA==
X-CSE-MsgGUID: zjKXWDR2RnmjUSangf67tQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; 
   d="scan'208";a="232778831"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 01:22:15 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 8 Apr 2026 01:22:14 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 8 Apr 2026 01:22:14 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.45) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 8 Apr 2026 01:22:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f1boPu5zne9u2KXH0txG6luxdB5iVzGGzFCww8OpOZNidptUUZjFuSPgedyZ5buNExnew54OIH75BaO0EQMJ1itY/cSEHiA6YgzB+JrvXiYSLDE7VOROwFLxdknhNH4kEX9PQObJEXySHSYVWGNVxLGtX7ZMyp0Pu7oAz9PwR2akboJGUDs4vOFzE0iLANx3o0VHsTX8bl1drgV1VKSe0dPK8A6WVVpNHrKQ7F5gJz6qMvkFrVcZVdzcDB4uq13TYy9BVIycqCR3/JZILBSTIZ2eJAgDObtNreX65+8jsMDteE5eYRfRLYI/7AOrNOYkdU9R1v12sA4KxU2SKjL7Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LWnNME7zSvYKViuCIyeitEAJnR2C4924uUteGemWUmE=;
 b=bb4VUKiT1XIbRav9npZ6gy7Fn+QXmuXdJXiA9DoIzdZekgH2GxHl1sJQG2zcC19E6j1SaZJRFSsO3yVDlsPe1TiwTk5FgfSjbsfnrsflhauhtBgJW/loJk4fR4klalFEn8Td1rSS9261cBN+lrGS9jaFA68dsTdYAFmr9m5Kyktbr07/HtNGayXIaY2UQVGwlMyYhTUu1QDxcJAaBM68wqVxDQVJ4BLkzGx52xAwqpPTQHlv0UzF0KoJUBZPlGzS3E5KRDTkdhWSMqGvP2cjZh/KptB+Ygkm0nwinY11SVmOQJG8x1QLo6YuuEnFY/zRUQ4mMfX5WZnRHWzCDheiiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB9495.namprd11.prod.outlook.com (2603:10b6:208:59f::17)
 by SJ0PR11MB6718.namprd11.prod.outlook.com (2603:10b6:a03:477::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Wed, 8 Apr
 2026 08:22:06 +0000
Received: from IA1PR11MB9495.namprd11.prod.outlook.com
 ([fe80::7e17:f6fb:7cf6:aa44]) by IA1PR11MB9495.namprd11.prod.outlook.com
 ([fe80::7e17:f6fb:7cf6:aa44%3]) with mapi id 15.20.9769.018; Wed, 8 Apr 2026
 08:22:06 +0000
From: "Reshetova, Elena" <elena.reshetova@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "prsampat@amd.com" <prsampat@amd.com>, "Duan,
 Zhenzhong" <zhenzhong.duan@intel.com>
CC: "x86@kernel.org" <x86@kernel.org>, "marcandre.lureau@redhat.com"
	<marcandre.lureau@redhat.com>, "kas@kernel.org" <kas@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>, "Qiang,
 Chenyi" <chenyi.qiang@intel.com>, "tglx@kernel.org" <tglx@kernel.org>,
	"hpa@zytor.com" <hpa@zytor.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
Subject: RE: [PATCH 2/2] x86/tdx: Accept hotplugged memory before online
Thread-Topic: [PATCH 2/2] x86/tdx: Accept hotplugged memory before online
Thread-Index: AQHcu6KLKDJ99GHWikalNKz+1MbbEbW+PPOAgADQbQCAAHLugIABpDmAgAAlqQCABe0qgIADLEIAgAEXMRCAAJQOAIABIMAwgACc5QCABxtYoA==
Date: Wed, 8 Apr 2026 08:22:06 +0000
Message-ID: <IA1PR11MB949508D72B9DB570770FF8B8E75BA@IA1PR11MB9495.namprd11.prod.outlook.com>
References: <20260324-tdx-hotplug-fixes-v1-0-8f29f2c17278@redhat.com>
	 <20260324-tdx-hotplug-fixes-v1-2-8f29f2c17278@redhat.com>
	 <56190adc345148396ba6b3e52672e662145f7dc7.camel@intel.com>
	 <CAMxuvaytU-pM+rviUbNGWMhvbAYutwvaSXW_O=sn+QfOzF35Xw@mail.gmail.com>
	 <7802b50589c80a7276a50cc473c1aa579750a30c.camel@intel.com>
	 <CABgObfZ7_w8Q-dW=Sd4YA3P==BuN1edPv7Ty4EpPyU8ctW6RLg@mail.gmail.com>
	 <424048885a01dcb6a7ef0256f0dc8a9adb546f22.camel@intel.com>
	 <cab5371d-e0f4-42b7-bae9-2c7f981b26b2@amd.com>
	 <49e8b24d836c1883e83ad72d1ab279f9e3eb7455.camel@intel.com>
	 <IA1PR11MB949557E04741169BA209A69EE751A@IA1PR11MB9495.namprd11.prod.outlook.com>
	 <9b1290bbc1283a2f35bdcd177d27ae7aea89151c.camel@intel.com>
	 <IA1PR11MB94952B22F6EB648ED7C1AE3CE75EA@IA1PR11MB9495.namprd11.prod.outlook.com>
 <f4639348586233245343005708372230f2d4a2cc.camel@intel.com>
In-Reply-To: <f4639348586233245343005708372230f2d4a2cc.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB9495:EE_|SJ0PR11MB6718:EE_
x-ms-office365-filtering-correlation-id: 72cc3bee-61d1-4a29-ea8b-08de9547ec00
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: rwUMDtDnQstdPbzOE6t54KCN8UTlUUiNspZWeJMTfkTQRzjao6M8HWcDJ48PtjbXQMUyWmJcuSWTEnE64hGwoIkWBINlHv4l6HD2MDHSmGdQC6zrJjSBNNwno67gJKcaf+Pwye6GHIZi20VXDqJ+XrE0VefDeXlpXJY5WFtwqQcKB7ctVaYuKbmzEiYURa8SFPRuynfZH3XIJMg7UzUIoH+im9CImAS/lgbYMhVczs7YR2MW50/+CuJrufJieQUU8VUcZ//okh/vf97sx2nKlY7MkVtNsVdxc1GKEHxBujWZe2EuQXAs6fFOiGpLF1fUk/8Z82TAO7wlkwc8nr1WBXLFdmjOJ0yX+eUIdn4vOEYZOo8bUJ0pr3CjXolYS3z/66yAXpQDOGijpkBtDfyhcJhdZFdQofWL4CURYXQtoslsjNcs7Mnaf5tnAYrjxYP/ShZAWokU4y0h+6EYZlAvi7Vu+DDpTlvxKcOJQB5s0sZkm2C0OwVSdqJ91xs9oewJcL0iYh/gYthq07/Z6YXV0TU/N2E1iuudWISNvknNDl5IHErB7Jn9xWs8NOYpDJWFk1OUbS6/lVzUEyW1Pxv/Fvghgb3UJGhLW3SI07m7fzKi0JJbomkfbI+vT8PnhR8a3ngwzTqu0ipvEVkhTlBQqi/fHtmbDbQuQtSIyCAetnpZ20wSyRFbZbYRq64CQ+0eNiNqH8oHUcNAfXhTmMVWCawM8htoLgBi9mG030AytRu9HOXauvGAnqwNbsNwJJFEWgcj9zxY6EpaSieN5efABv0A7YZvQ1unsvbus5yAINI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB9495.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NDg5ZVdBa3BCOWUvWDlJOGc1b3o1RURUQ0pZNG5OaTZsVTlUcDFTVVNOdGRu?=
 =?utf-8?B?eTgyMG9BQW5JS3ZGRUxqa0ZKTEo2Njk4VkhvZHRtNDg2WXJocUVhVktVTHFa?=
 =?utf-8?B?UU5sS1ZYWWtGcFhvQU9IWGdJeVdCK1dZU0x0cjNiQUFwaTlWZWxzdWtEYVVQ?=
 =?utf-8?B?U2I4amY0MWgwTzZjekRQZnBpNlY5SkxGc2JSZjd4SFU1VzMzajhvY3Y0WXcr?=
 =?utf-8?B?dm00S0lqZVpOSjFWYW84NzgzTExKbjJsQ1FjWDl3OHdRSlJEYzlINzFKbnhG?=
 =?utf-8?B?MkQ3ejJXYzFlVXZqbGRJVXM1RWtzQ0E5Y2lpU2hXMFNSRi9iVTV1Qlg0R1I2?=
 =?utf-8?B?L0xLVFBYeXRZU0FKVjRJaCtPSWJyRzRtSUtDVG04SXk2VmhqbWxkU2pFVDVS?=
 =?utf-8?B?MVhIMm5McEtQazd2b0htL29HVmJEVUM3Q2pRUFgwU040KzRNVGhrUCt2cVhE?=
 =?utf-8?B?ODlqUTZSQnVmc0JKUDIvbkJBTHNtcDFrTVlYWVlpUUlaUC81aDhzMldNdVl6?=
 =?utf-8?B?UStGelRtaEZxUnFhV0xVek9sMERKdzA1TmZOSEQ2RXQ1Ry9SRHltdkdHeFpz?=
 =?utf-8?B?QXBHeE5pUTRkd1VmVFVQSWNnTm42OGE2WXU0REhja0xLeldka0FLY2lFSE8z?=
 =?utf-8?B?RnZZWkdoUm95L0RQaGloWWlrRFFpc2llckpZdkhjbHZjVWcrY0VHSTZmV2x2?=
 =?utf-8?B?d1IvcTFyenFnZmg1SXpIcC9aUlNRMmI2V0dEOFRrZEhDNEdNZ1NrL3oxQUE2?=
 =?utf-8?B?OTZ0QmR6RzluUjg1NUdrU2U4MjJ5RngyUVpCMzF6cEsvRlhrZUIyWE1KR0Rj?=
 =?utf-8?B?T1IzV1dmdkNhNnFLWFppWCtRcmUxWUFjUlhXQ3REYm83VS9vc3l2RzZCUVZQ?=
 =?utf-8?B?U0FQeUZBcVVWb2pmcE44UkFsSFo0b1NxcXNLUDVSaUluZW5pL2dlQ20rSENH?=
 =?utf-8?B?N0tyQmhqUFhKUnlkeFVmWEorRFFmeHRJbjIvRE0rK0dwSEhucVh6L3k3TDB6?=
 =?utf-8?B?RHd2WXlIK084aHlLS0JVa1ZtbDhPaW92b1ZsSjJuY05rdWRBd3NzYmI5UmFX?=
 =?utf-8?B?QWJYcXQ2cjZaK09WcUg1SzJRd3MxR1p2TjhxR3YxcEd1MEtlSHFiVS9jLzBt?=
 =?utf-8?B?N0JjRWlVS21lb01oQ2F6SWxsaHUraDFFVUE2M283Z1hDbm9uR1dHYlllWXll?=
 =?utf-8?B?RThTdjBBZXVsRnNGUmFGak1YS1haNTVNYzU2a1FPY2F6NEZCMnY1QkczNkQw?=
 =?utf-8?B?bTNrbW1tMjRpNEJUbTVoYkVvSEMzZ3dkVmJsVDB1anNjcmpRamhvS0dUVmhI?=
 =?utf-8?B?WnBjNzNCNEQrSE5PK2x6WWtSVmpMZ0pFM3o2Z001c1B1SklNOEdXVkk5djJK?=
 =?utf-8?B?NG9QNFFMS2R3VVpqZjMzUzh3aWdoNDhob0dKTjhod0FzVHhyeWN1M2Izczg3?=
 =?utf-8?B?MklndDJaWmJ6Rnl1S3J6c0psakdoMkdiV0ZOanFxL1I2Rk4wNEo1T0I4N09s?=
 =?utf-8?B?R0loczQxamZ0cHVnaEJaNmdoN29wZmczMlcyOWN0SWxaOThKQ2l5WmZLQjJU?=
 =?utf-8?B?WE1ucWZRWHE2c0tUZUUrSjNSVFFrN1dqUm5rRlA5ajVzQnphOStNR21oNHIx?=
 =?utf-8?B?c0lDS2FUSS8zRzdmZk9zelVDemJ5Z0NjWEZrOVZSbkJ0SDhVT2M5b0c2QVdV?=
 =?utf-8?B?YlR4UzBtRlZFeGMyQ25kdE9RMTJmTi9TTGNkeDlaOURka1EzeGZsN1NBMXNZ?=
 =?utf-8?B?VGpUVVUvSVk3ZmplaXNQeWJ0Z2dPdEdVNWRXV3loei9kY21wVEwvY0RCaDBs?=
 =?utf-8?B?TUxrODJBaWV4MWZ1QW9YUHNIN1pLWDZBeEUrK1JkZjVKR21QYnk1MHNVR29H?=
 =?utf-8?B?aHZUbkw2dFdRbWQ1d2E3c3ExRm5CRTRTQmljaWVMUjZEaDlvbnRoSUJGRkJT?=
 =?utf-8?B?bGhEQlpmSWdTVU0zNDFrOGZMNE1zU01wVnZvcVNNTXJXSW5kelN6RXByVk9V?=
 =?utf-8?B?cy9tREFPZGswSHhCaitNeUM5amc2aWt0dVZ0WjJtQ2ZOY2NsRHJhUXRDUVhY?=
 =?utf-8?B?WlFzSHFadXBIY2xmcUViZUMzdmgxZmF5UDJZMGdReW8vN29DbzRCNWhrL0JN?=
 =?utf-8?B?OXNuZm5nZy9TRmFyVDF6d1ZPcU1ROWRlSmwxekZMMVVjYnI5dWowcFVzUkox?=
 =?utf-8?B?UzhabkZrYmZTSXNVY2cvQ21lZmEzWEw0aDc0c29pQnlQQ05qYkFYNVVSOFhO?=
 =?utf-8?B?Q1EvbEJHSGdDSVplMXNOSlFtZytVeDhqdzJneCtzeUhtZ0YwYVFoMTZWYUl0?=
 =?utf-8?B?bEFDOFVXakFaRlZac3BscGtROXlNZU1adVpRZkNQanhHT0M4OEIxZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: R3Jox8Buceyc+mmr4YH6XU3BOf+swqXnZ6kjJFXFFMZ451VqXFncLQuiEwcz+XncteC8MF2xYsH78TdQYKU/nP7T4GFkfWH3jMewkXDxM7r0ASECPzqREGO7mUaNEseEAcLgdAY3RwXKdFabDdCJvFtCzM4x4fRJHX1asyi/UZKKji009bmLej1HnmvVzdbk0bsZCwQLNpxYJkFeJaeAmQ+D3n7h2y4IpIo/VAECgO+/vAIHlDjUcO5MjbmRbKOAtRM5qEJSYHlbnZzA5qRQYl6eHlURTMhNxtreUdgkuVTRqi9iqHAefaDKcukzdU/Ec0IBBFe1r0osVfiWLSSp5Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB9495.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72cc3bee-61d1-4a29-ea8b-08de9547ec00
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2026 08:22:06.7579
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: if73BH980q7ldAMPUEKw4xgTvietts1plItPpGKDJHkWpBIP4UBRpAMQt6MMUuJuOsVPte0hU3XqD78UzQNeOUGpnq3mTQnPwXcDnamlTQA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6718
X-OriginatorOrg: intel.com

DQo+IE9uIEZyaSwgMjAyNi0wNC0wMyBhdCAxMDozNyArMDAwMCwgUmVzaGV0b3ZhLCBFbGVuYSB3
cm90ZToNCj4gPiA+ID4gPiBTbyB0aGUgcGFydCBhYm91dCB3aGV0aGVyIGEgdHJpZ2dlcmVkIGFj
Y2VwdCBzdWNjZWVkcyBvciByZXR1cm5zIGFuDQo+ID4gPiA+ID4gYWxyZWFkeSBhY2NlcHRlZCBl
cnJvciBpcyBhbHJlYWR5IHVuZGVyIHRoZSBjb250cm9sIG9mIHRoZSBob3N0LiA+ID4NCj4gPiA+
ID4gPiBJLmUuLCBpZiB3ZSBkb24ndCBoYXZlIHRoZSB6ZXJvaW5nIGJlaGF2aW9yLCB0aGUgaG9z
dCBjYW4gYWxyZWFkeSA+ID4NCj4gPiA+ID4gPiBjYXVzZSB0aGUgcGFnZSB0byBnZXQgemVyb2Vk
LiBTbyBJIGRvbid0IHRoaW5rIGFueXRoaW5nIGlzID4gPg0KPiA+ID4gPiA+IHJlZ3Jlc3NlZC4g
Qm90aCBjb21lIGRvd24gdG8gaG93IGNhcmVmdWwgdGhlIGd1ZXN0IGlzIGFib3V0IHdoYXQgaXQg
PiA+DQo+ID4gPiA+ID4gYWNjZXB0cy4NCj4gPiA+DQo+ID4gPiBZZXMsIGFuZCBteSBwb2ludCBp
cyB0aGF0IHdlIHNob3VsZCBub3QgYWxsb3cgZ3Vlc3QgdG8gZnJlZWx5IGRvdWJsZQ0KPiA+ID4g
YWNjZXB0aW5nIGV2ZXIuDQo+ID4gPiBGb3IgYW55IHVzZSBjYXNlIHRoYXQgcmVxdWlyZXMgcmVs
ZWFzaW5nIG1lbW9yeSBhbmQgYWNjZXB0aW5nIGl0ID4gYmFjaywgaXQNCj4gPiA+IHNob3VsZCBi
ZSBleHBsaWNpdCBhY3Rpb24gYnkgdGhlIGd1ZXN0IHRvIHRyYWNrIHRoYXQgbWVtb3J5ID4gaGFz
IGJlZW4NCj4gPiA+ICJyZWxlYXNlZCIgKHVuZGVyIGNvcnJlY3QgYW5kIHNhZmUgY29uZGl0aW9u
cykgYW5kIHRoZW4gaXQgPiBpcyBvayB0byBhY2NlcHQNCj4gPiA+IGl0IGJhY2sgKGV2ZW4gaWYg
aXQgZG9lc250IG1lYW4gcGh5c2ljYWxseSBhY2NlcHRpbmcgPiBpdCkgYW5kIGluIHRoaXMgY2Fz
ZQ0KPiA+ID4gaXQgaXMgb2sgKGFuZCBldmVuIHN0cm9uZ2x5IGRlc2lyZWQpIHRvIHplcm8gdGhl
ID4gcGFnZSB0byBzaW11bGF0ZSB0aGUNCj4gPiA+IG5vcm1hbCBhY2NlcHQgYmVoYXZpb3VyLg0K
PiANCj4gSG1tLCBpdCBkb2Vzbid0IHNlZW0gbGlrZSB5b3UgZW5nYWdlZCB3aXRoIG15IHBvaW50
LiBPciBhdCBsZWFzdCBJJ20gbm90DQo+IGZvbGxvd2luZyB3aGF0IGlzIGV4cG9zZWQ/DQoNClNv
cnJ5LCBpZiBJIGhhdmUgYmVlbiBjb25mdXNpbmcuIA0KDQo+IA0KPiBTbyBJJ20gZ29pbmcgdG8g
YXNzdW1lIHlvdSBhZ3JlZSB0aGF0IHRoaXMgcHJvY2VkdXJlIHdvdWxkIG5vdCBvcGVuIHVwIGFu
eQ0KPiBzcGVjaWZpYyBuZXcgY2FwYWJpbGl0aWVzIGZvciB0aGUgaG9zdCB0aGF0IGRvbid0IGV4
aXN0IHRvZGF5LiBBbmQgaW5zdGVhZCB5b3UNCj4gYXJlIGp1c3Qgc2F5aW5nIHRoYXQgdGhlIGd1
ZXN0IHNob3VsZCBoYXZlIGluZnJhc3RydWN0dXJlIHRvIG5vdCBkb3VibGUgYWNjZXB0DQo+IG1l
bW9yeSBpbiB0aGUgZmlyc3QgcGxhY2UuDQoNClllcywgZXhhY3RseSB0aGlzLiANCg0KPiANCj4g
QnV0IHRoZSBwcm9ibGVtIGhlcmUgaXMgbm90IHRoYXQgdGhlIGd1ZXN0IGxvc2luZyB0cmFjayBv
ZiB0aGUgYWNjZXB0IHN0YXRlDQo+IGFjdHVhbGx5LiBJdCBpcyB0aGF0IHRoZSBndWVzdCByZWxp
ZXMgb24gdGhlIGhvc3QgdG8gYWN0dWFsbHkgemFwIHRoZSBTLUVQVA0KPiBiZWZvcmUgcmUtcGx1
Z2dpbmcgbWVtb3J5IGF0IHRoZSBzYW1lIHBoeXNpY2FsIGFkZHJlc3Mgc3BhY2UuIFNvIHRoZSBn
dWVzdCBpcw0KPiB0cmFja2luZyB0aGF0IHRoZSBtZW1vcnkgaXMgcmVsZWFzZWQgY29ycmVjdGx5
LiBCZXR0ZXIgdHJhY2tpbmcgd2lsbCBub3QgaGVscC4NCj4gSXQgcmVsaWVzIG9uIGhvc3QgYmVo
YXZpb3IgdG8gbm90IGhpdCBhIGRvdWJsZSBhY2NlcHQuDQoNCkkgc2VlIHRoZSBwcm9ibGVtIGJl
dHRlciBub3cuIFRoZW4gSSB0aGluayB0aGUgY29ycmVjdCBiZWhhdmlvdXIgaXMgZm9yIHRoZQ0K
Z3Vlc3QgdG8ga2VlcCB0cmFja2luZyBvZiBhY2NlcHRlZCBhbmQgcmVsZWFzZWQgbWVtb3J5IGFu
ZCB0aGVuIGFsbG93DQp0byBkb3VibGUgYWNjZXB0IGlmZiB0aGUgbWVtb3J5IHRoYXQgaXQgaGFz
IHRyYWNrZWQgYXMgYmVpbmcgYWNjZXB0ZWQgYW5kIA0KZXhwbGljaXRseSByZWxlYXNlZC4gVGhp
cyB3YXkgdGhlcmUgc2hvdWxkIG5vdCBiZSBhIHBvc3NpYmlsaXR5IGZvciB0aGUgaG9zdCB0bw0K
bWlzdXNlIHRoaXMgZm9yIGFuIGFyYml0cmFyeSBtZW1vcnkgcGFnZS4NCg0KQmVzdCBSZWdhcmRz
LA0KRWxlbmEuIA0K
