Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10ACD31354F;
	Mon, 13 Apr 2026 19:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776110096; cv=fail; b=m2uO8EXZlgPBqA+WW/Y1uX4SzAsJx2MBPTmgYr9fCVCaKcAmbjzxLzNAsjxaWqNhZWEhaoAB9gzaBBDv817z3nS4Akoq0cKIgO+vo/7k8is1yOUnslVaaNejYMfMxbmjA/uHufHTZH07s0h6EekHw869a/Sd9JCrGB2XUEynYz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776110096; c=relaxed/simple;
	bh=ToCweAhP7yf0FpIYLj9KL8mUtamhu7N/fpXG1jDqApA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NBuwBAi3wguGNc6jZj9TeYUUxEiUs0huMzSaDeVWtwCW4tgNRbBP321be6ODEoTV32xnzi3Z1S96VM6jeJ/SYVzVH3y/9JSEBbevytO/fkpjxn+xv73UMvGFcMkx9r++wW+V6EWp3CtWJkb1FzXQS9BsbHRhbQ/Q3GmC13Thmnc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hPgKQqed; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hPgKQqed"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776110095; x=1807646095;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ToCweAhP7yf0FpIYLj9KL8mUtamhu7N/fpXG1jDqApA=;
  b=hPgKQqed97aDCy1SeivkaiFkq0L0zrLIDVA66TwQfk5iqAqNaXO9iXRR
   oE4yrDGuX/VSLr5GckIYSmKbJbOigPswaQNIlfkMh3yUGO02Faq3ewLkw
   hRkV1aGPZGfFnEpY/NzU2EUl2B1frxT4tB4HyM3s+y9HYoj1ddxzy5ox0
   TQwyio3FqNzU5dYss/ebEzfUDDmvknlZ+MwSn5TbhAbg4/Vg6aj9VHlbE
   kL+kDb/zDpq7UYla2wnsHeu11V/wnTSLwegC6OMKWq2kzyTddopvJCD8s
   Ysb/tIZv3OmH6TGJdJ5z1MotzmBh7zXfCbJ/3t5XviPQ73fOXcVdTv08t
   A==;
X-CSE-ConnectionGUID: V8NF1zZmRLmXa4hv8kqpKw==
X-CSE-MsgGUID: VXXG6XNdTlSdjw3x+XVZbw==
X-IronPort-AV: E=McAfee;i="6800,10657,11758"; a="87356688"
X-IronPort-AV: E=Sophos;i="6.23,177,1770624000"; 
   d="scan'208";a="87356688"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2026 12:54:54 -0700
X-CSE-ConnectionGUID: Cr6Hho+mQ3aNYfoHCOsnCQ==
X-CSE-MsgGUID: kJE9kNyhSaqBeXqQAIQkJQ==
X-ExtLoop1: 1
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2026 12:54:54 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 13 Apr 2026 12:54:53 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 13 Apr 2026 12:54:53 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.21) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 13 Apr 2026 12:54:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IiLQwm63TojeOUTY1Q2YE2mzQD1eTkCfdVDO7HOIaZK1yzE7EeVpDFMg0EgLtpTPQ5/CyFmWrYwU2j5u9BXpu/mEsOi7T4Z8AgEtfwYqR0vJ5fNOY/olMpR2cCjCITKM7OcY5WsshHstEwFLcvuMF2xjsd+70wrC5Q6sk8yOK+3KePf3ZdKuybjLKFV3djxBdRhaiJS69gpRhys/AYUAhStT2/LjCSGaSQcLuAF2o4i6SyGAsrNuGJuBx7Um7w+ZkP/x1Ua6zixFf6Qjq0LU8UHJC9q2v7t6FG8e8JeN48Ui8pMzCqxC0iH3dqwC94m1P2H2GO749zNUzJY6JGih8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ToCweAhP7yf0FpIYLj9KL8mUtamhu7N/fpXG1jDqApA=;
 b=hHpvnuy8FpAGTitXDyHmYLzN7MRjxx7Ek4D12Ib9mTrYF8KKaLk0oI1mT1kwAmc7GolceSWxYfkGsfwzlhnszJfd6xliqeebLjzdCbcN9NW+lg1I2lbDZAunpFNq/hgS5Y3QaoUCGkH2WDXL40k4YRteh1VXvcXbFWkfSJNZRI7s2R41HHP3dp100oR21rxFehRDuwV7WS2eRkpWMsjbtRc5sO+rpUizog6jmFSbK2nA/0TzIuj9qk82D9ZP27QDvPhxYj5jo44ZXxV8foeQ2WW3jQJ7uWoGUKdH5sFO8ZcGAKC0Y+VvcCvqmMXJslNvg7EV9lxDuZSxHtwMtR37Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by MW4PR11MB6809.namprd11.prod.outlook.com (2603:10b6:303:1e9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Mon, 13 Apr
 2026 19:54:43 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65%6]) with mapi id 15.20.9818.017; Mon, 13 Apr 2026
 19:54:43 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Gao, Chao" <chao.gao@intel.com>
CC: "corbet@lwn.net" <corbet@lwn.net>, "Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"Huang, Kai" <kai.huang@intel.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "kas@kernel.org"
	<kas@kernel.org>, "seanjc@google.com" <seanjc@google.com>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "Chatre, Reinette"
	<reinette.chatre@intel.com>, "Verma, Vishal L" <vishal.l.verma@intel.com>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "Weiny, Ira" <ira.weiny@intel.com>,
	"skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>, "Annapurve,
 Vishal" <vannapurve@google.com>, "sagis@google.com" <sagis@google.com>,
	"hpa@zytor.com" <hpa@zytor.com>, "tglx@kernel.org" <tglx@kernel.org>,
	"paulmck@kernel.org" <paulmck@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
	"yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>, "x86@kernel.org"
	<x86@kernel.org>
Subject: Re: [PATCH v7 21/22] x86/virt/tdx: Document TDX module update
Thread-Topic: [PATCH v7 21/22] x86/virt/tdx: Document TDX module update
Thread-Index: AQHcwQwJdwUB1yLCckK/FbLSo0Pwl7XdfKQA
Date: Mon, 13 Apr 2026 19:54:43 +0000
Message-ID: <e092b38474a1c01f59f071a114390c1e01a43259.camel@intel.com>
References: <20260331124214.117808-1-chao.gao@intel.com>
	 <20260331124214.117808-22-chao.gao@intel.com>
In-Reply-To: <20260331124214.117808-22-chao.gao@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|MW4PR11MB6809:EE_
x-ms-office365-filtering-correlation-id: aea33320-0798-42ff-f593-08de999681f2
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|56012099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: 9ZWsmao47WErytb8EMvcU8dR3r9Y9CWoVRHaGmAoqNIChXoAEpYITORgcdDm8XuJc/nprjU0feKTwSBvOCBJ6jqEKKQUuA4Ein9et0G4IRU7i0nUNyOHTYQSfgvnMAhermwJa01O+vOkRcPyuWcvbTQiL/zc/jtRc9F7+buge94Vrqa37N4bYxWDOvNFFlgxUjYWuoNexIB9mhhJB9Yx3vUg3MVTTTd1LfVKBu987avxdydxEkdINJZ2gxugx2GxX2jhA78dhPwOlRegd5kEEjNHyP1hH2BCKAy1UxA/2QX3yWopRPudKZC89QUAxC5sbfKchTn/Cwr0pBMWPgVwSuFVpsmQ8pg/HyXrnViLfBuB9oRbV5uZFP5hqxP3ilbA4buqz4fT4ZpPZDQ1oIDrckgoulyGX1LAOIL7s18IcMPYbbVxWbU1PL3ITvpAXOw13Fuub4ggVKGvtR2l/fe3Z5hAvKPPZlaIEsZR5O5UyldJ0xeCJ6eyUpJo+LjTkvyDJTVFuhO5FYipEPsM5YFkwomFaq+vGvcmm59J6gGkoJLkf9MYRMQG/99KzLtRVJLUiW5L9v0KI9NR5/0ikZf5shhLWBF9HmQHRawvrNTeNDaV1QxhJtXJznwAKpxFZTw09mR7AEDu852GjjRDAgI2SeSlFm7nnaDgYJFPxCgPJtmTuX34YuPuezGiGBE9ALeSslPwrnGEIWW49ClOfrrvqIv6V8McG0kR46SKEcgqZuK6NBZ+hk0vQKkTH0VngI1sDhXycgjCjC0buEUlMpFImw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(56012099003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dTBNLzZpaXBDdzVwa2ZnNjZHMTEyN1hFbVQwenBDTHZDdUYwM2hQVDRRekYw?=
 =?utf-8?B?NTU5aFQwS3N6VE1jWUFhdENUV2dUayt6cHhlVXY2cnFEMHFBRDRoRFNwVGd1?=
 =?utf-8?B?SFlrTlJWd05WVnhtclZwbnVqMWpHRjI4RllKcFE1ODR2T2VMS1FDS2plaGI5?=
 =?utf-8?B?dTNtUTlZSUlyMit6WkpSUjVDbDhYS0dRUFhTMzRYR3NSdjdsUncwSWYxM2w2?=
 =?utf-8?B?clY4SWlhZXhOZ09PTkV3NUo2cmhSeGNveThKT2NtM3kzUGN3Y1dnZUpOWHhD?=
 =?utf-8?B?WGVlK1ZDQjR0Z2dpb1dYV00xbVFUd2NJb1k2RFR6YmorbXN0WEQvNDZtUDdz?=
 =?utf-8?B?UU5uK2EzQ1NtYUJ4aEZtYS8xY1NxZUdIbDlnT0JlMU56RTZiWVBBWmRTZW9W?=
 =?utf-8?B?STFJOUZiazJuWStNVUI4RS9CaGpMdDZUZjdjVVJuUVBqWklTdmRxRkdJWGN1?=
 =?utf-8?B?OGlKelJ4akNITEs3bEE1TmFQQnJKMk9jc0E4SjFFbzF1NW5OMFdCT1ltY2RM?=
 =?utf-8?B?SGNmRHViZ2sxdU5DVEN4M0ZWWlRPaDhpZjQxNDc5VW5GaTVDRndQMzVHNUNo?=
 =?utf-8?B?Yngzb0RKaVJCRFV6SStmTUdCMXFyTjF6U1ZDYjFhK0pqSTBvME1WeUlwcnEz?=
 =?utf-8?B?Y3h4bzRQYXVHYzk2TDkvNkQrVXdCc1dUbldOY2h2QVBSMFNFb1FwbjJJVW52?=
 =?utf-8?B?M1FLRTFZcTVWNkNGcEtMTzVSTTc5cGRFYjdEYzdKV3o1em8rbW1tYk9rVjUz?=
 =?utf-8?B?c2pJY0MvNHpXbHZLTkMxVnZaVWVCWkt2Y1RPVHdsUXZabUovTXl5cDQ4M2pC?=
 =?utf-8?B?S3cyQXIwMUxnZGxYN0ZubnZSTm5ud3ZOU2JXcDRUMnBGSjZuTWpjMFJYS0t6?=
 =?utf-8?B?aVE5WXZiUitXS0FGZG83d0pxUUFRRWhKSS9FYUV6MGJGamlLTTZKcUtyYTFn?=
 =?utf-8?B?Z1UraGpGNG11am5BY3YwNUhUL2tiYTl0cTdpRXp1cE52a3p1amVNRWx5b1dj?=
 =?utf-8?B?QWpIalVjcDkvQzNVdXVWa2YwODFldGFhRUp1UUVhWHdyY3R2bTVuVWdWeUFT?=
 =?utf-8?B?RWt5QVdmYmk4U2RCTFF1ZW5jTlZicWFvVzNKSmRhMDhxeC9ic3pmb1Flb24w?=
 =?utf-8?B?dHl4bGV4cE9qMTVrbTVWYVpiU0JiSlRzN1A1b3NVTzRMdEpDVFM3dXpUSVRh?=
 =?utf-8?B?L0tYaUR2TTY4T0hDSnlPMVl1NmR3QmI2SVAyMTdQUW9wcy9rOUQ3Nm5RaEZ5?=
 =?utf-8?B?NElZUXBTamEvVGtZQVlFaktjdHR1Ukd5QStURnRqbHl3eExxVlZLa05yV3Bh?=
 =?utf-8?B?cEJNTFRZWTVHZnppZ2c0d0o1T1BtSEFKdTNQLzRPWno4blk3Q1ppMEdtSDY4?=
 =?utf-8?B?b0xwZmlyNmRKSUNkNU5tT2tzU3lnMVNQRTF0MXdTUmF1M01mRkp1dVVIT0g5?=
 =?utf-8?B?L0VvTWxKZi9kSnJCS0NlSzFHcTdubmhzTk4xa2JNcTZlYy85NUlxS0VzMzBD?=
 =?utf-8?B?aVRCTDRUdUdnV2hKaXBxQmNzUjkxQkEvNzloTCtIaTIvMC9lRU9Sano2UDRF?=
 =?utf-8?B?b3YvK1pwYS9jcTBmeThyUURSTkxBaHF4bnU2dnB0ZTlBbDVUL0dCYmZYWTVB?=
 =?utf-8?B?WklxRmNOdnM4eHpibUErSS9RQ0R0L0g2SDFvWHN5cHljc0kwbnhmaE1RbnFm?=
 =?utf-8?B?ZDNhd3VUNm13MXdyVHQvTHNVYWloTEdjdWl0NXVrV0xwNkhhQ293QTZsZUJ1?=
 =?utf-8?B?SERrSTRWMU53ZXJzS0YxdzZtYytqc3V4N2hIODQ0WDNOM1RZRTUyTWQvMDg1?=
 =?utf-8?B?ZDNoZXdhZVJSWkdjQUNTUmc2eUhYQXVyaWkwQlEyMlpjMlB6TUo4cXlTUmRa?=
 =?utf-8?B?WEZnenJNdGM0MnFNVDVEeHhaTXhLSy9kTGJjUUZGNjFPVTN2Nm9zS0VwTHRM?=
 =?utf-8?B?aUdvc2c3WlNRT2duT1JKcm5LbXEvKzFjbWlyeEJJVkVSaERpRkFtVzh6K0Rh?=
 =?utf-8?B?UTJhM0Nhbkg3c2lHbTFxejAyNWpzQ095QW53LytQYVpNZjYxUm0wMnNIWVpS?=
 =?utf-8?B?K1k1M2xHVW5zcEc0MkJhR3VyNFF5aDUvQi9yYThSamlBWjR0U0tCUlkzemxq?=
 =?utf-8?B?R1Z2dVMwbXUzc2FmWXRMYnlYdTNYSklMd21HQ1BRZVJEU25rU0hHSGJUNzV1?=
 =?utf-8?B?Vk9lZ05yaEpKOW0yb2h4ZkpSNlp2VEorYlNZVWRHeTVMRWJEMUZSR1BxVEJ0?=
 =?utf-8?B?NDlHZk53MWVaVDcwb2NleUpXQ1p2eklvdGdabXNXZytEdzk3NTZ1QjZVZ0NM?=
 =?utf-8?B?ajNTOHVObVhRV0o5b0RHV0NZZU5Ta0d0NnorMld6bFY4TlgyM05PdFNNTW04?=
 =?utf-8?Q?OuyEifjOvtvCRjoM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <080D4A9BA1782F4A8AF963E333B055AA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: eY2qbgGeb/q528GZZ8nAp8Ra0WHETL7wn6yAgtdV6cYRGhoLmbphy6Setrtv8QJA3GOnvovEErOMxOFwihlvJQj9S2OjxihyUlCH9kazLvZPWDIzMb87+4BYrk77MoCN0Vc3Bc/e19m/hIpAonpvfg4j/XeurxxqpnbnSkbDNgNvO/zAceb9kT1pl8xXJHrLAFj8GnnGcBCucM+2W3/WYSOQ0uUJGjqLOMVMlW6/91ViMV2Yf+gUYXGbQ8NnChuno7DxRs55raD/7AQHjaPE37OMaeJOAgYlp/sRC9w+t2ox8cFuE87lEgkPZxLaBuSw7yTI5OaNTIOC0XIMnGiyvQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aea33320-0798-42ff-f593-08de999681f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2026 19:54:43.7381
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QLy8hjZklGU+ddadLRhzwIda36vzQ72agx8uVmMbZiSBv6DtSfPfZJGCdJPp7MLvMpGGIFTMhFa/ODTMcqDmfvbNPzLgYWwqRNkPko3RHug=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6809
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTAzLTMxIGF0IDA1OjQxIC0wNzAwLCBDaGFvIEdhbyB3cm90ZToNCj4gRG9j
dW1lbnQgVERYIG1vZHVsZSB1cGRhdGUgYXMgYSBzdWJzZWN0aW9uIG9mICJURFggSG9zdCBLZXJu
ZWwgU3VwcG9ydCIgdG8NCj4gcHJvdmlkZSBiYWNrZ3JvdW5kIGluZm9ybWF0aW9uIGFuZCBjb3Zl
ciBrZXkgcG9pbnRzIHRoYXQgZGV2ZWxvcGVycyBhbmQNCj4gdXNlcnMgbWF5IG5lZWQgdG8ga25v
dywgZm9yIGV4YW1wbGU6DQo+IA0KPiAgLSB1cGRhdGUgaXMgZG9uZSBpbiBzdG9wX21hY2hpbmUo
KSBjb250ZXh0DQo+ICAtIHVwZGF0ZSBpbnN0cnVjdGlvbnMgYW5kIHJlc3VsdHMNCj4gIC0gdXBk
YXRlIHBvbGljeSBhbmQgdG9vbGluZw0KPiANCj4gU2lnbmVkLW9mZi1ieTogQ2hhbyBHYW8gPGNo
YW8uZ2FvQGludGVsLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IEthaSBIdWFuZyA8a2FpLmh1YW5nQGlu
dGVsLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IEtpcnlsIFNodXRzZW1hdSAoTWV0YSkgPGthc0BrZXJu
ZWwub3JnPg0KPiAtLS0NCj4gdjU6DQo+ICAtIHVzZSAidXBkYXRlIiB3aGVuIHJlZmVyIHRvIHRo
ZSB1cGRhdGUgZmVhdHVyZS9jb25jZXB0IFtLYWldDQoNClJldmlld2VkLWJ5OiBSaWNrIEVkZ2Vj
b21iZSA8cmljay5wLmVkZ2Vjb21iZUBpbnRlbC5jb20+DQoNCg0KDQo=
