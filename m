Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD0051A141
	for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 18:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789755133; cv=fail; b=nWd7QHcVV2fuQQ2zcF6f8hSlfy4ycWhq0nug4SvQFR6MGTfrkNWEEDdExERGCbemT8qNKmI4TEtweL4drRQSEaVbFhbDWmy+pKE/xDNioK58vjghkBQ9Gkj4OYyCYWmvmstfWHoE4rpwkNw60UN0qo5eQ5K5G9mGn1L9P59f0q0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789755133; c=relaxed/simple;
	bh=aOoCPXkIZokS+SV3+iH9sASybpBAJJuOsnTfOwiyhdo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qdp60A4f+0iEeWwFEeEwmYlwM4QTJAD639bSCuafQ4tEbamy3MNcl3i2K1Cg2wAarnQvaFEVIbG/M9wit29tEUboc5VFgN4QFCxgPBodPAVKBk7l9h4Su0KgzeYTQN9cRuXixzPd281lcC2hWWYosFbi+2hTl75FOHDNIudUlBI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RfYBniJF; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RfYBniJF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789755131; x=1821291131;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=aOoCPXkIZokS+SV3+iH9sASybpBAJJuOsnTfOwiyhdo=;
  b=RfYBniJFi7jBgxxImqRlwxpilv08yUNbMYBfmRbFzqEDNU46uClwi4Oi
   db9pF7902A25m7YvZUjnb6+ArvCm/kIUBLdrHWTI/RGfxDFkTqRiMzjH8
   KiKJIv1A8bLYmIFfNoj35REwx/YmxAvnM7O/moiEr/aeGVMk8SHQ24fdP
   bJHNwfbR1lJI4yk78R8fQl8YLQQn7t2ZOOZ8X8SgKu7GxjQdVL7s8kfOv
   AarIw99JLXdjixJRGFEabRqeOEzNxNZApOPrIUZ5doOCY3XsBaj0mo1M5
   51lUMwqfoz/q6kJdorfm7hCBfy1mGdW1ixoLPFsonEqrFDStAh8m0Oij+
   A==;
X-CSE-ConnectionGUID: fKyKkJQcTAWQpvGp6OQczQ==
X-CSE-MsgGUID: VE7nTfKTTJa+oE+q+O6TLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11909"; a="90296028"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="90296028"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 11:12:10 -0700
X-CSE-ConnectionGUID: LtCv3VMaQTO1oXCGiGFnAA==
X-CSE-MsgGUID: vpUIrqmUQzy4jnBR//MrGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="268250297"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 11:12:10 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 18 Sep 2026 11:12:09 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 18 Sep 2026 11:12:09 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.4) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 18 Sep 2026 11:12:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ypIh0nVi/03m+9wXbhm4ph39hs66WQcCUof5wmJ53jBKGYbRb1PPeyd9zH9Onl1qF6SFPWNSXPjqarLgbGHT012ooXPVlEZrk4tY+2J/ay9hACyGqttswi/h4KIiqHQmxB44GwvZcgQ/eQREBIjZ1c2QCWhceHzpzoCwJ2oM7lkbYKWmuhRruOoRy0XM/O8H2pcz2E/8epOX0OAfux4BFpzc2noAA4Vyw6dA91rhEbQG0xEWfefjeK6wjD8gF7lIFBzHfT82Dswagn979SzsnvU8o9La5BW2a1fGKphEu1V2+FhRFGTzEl++y72Oq3fuffhQHu3WYAlQlhChlmsk1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aOoCPXkIZokS+SV3+iH9sASybpBAJJuOsnTfOwiyhdo=;
 b=RmoPUwhJEjfgM+agqAUb2nSKoU3cVZanD/LPaSRsOJha8DLyVIneYISL9DqItAtbqaXhkT7srep6dvHMhSrNo3+DFc2VHXTFZZ9PC9u7uGG3Ne2jP7VM6TXIJU1xJ3mCL1x/I8e7D9fJo1d0MmQ9DYbgGt7v5FJEThgw27Zn9ysHLMjNfla0oK4P9w0hK/d82/0z8BL/KICAowUa8v0B7Aw1PGWHm1gErzXn0/9daBYtLzvAeeTJQ3W6VqCL/XcW4vI5doS6on7Epz9i/wgH1hfRIbxph6lSaQ6Q6rADDpQKQ2ck33Aalm9K1+BoH+UbpC84dUKF5k7YiL4FNxwCUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by DSWPR11MB9930.namprd11.prod.outlook.com (2603:10b6:8:3a0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 18:12:05 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 18:12:05 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "seanjc@google.com" <seanjc@google.com>
CC: "Xu, Yilun" <yilun.xu@intel.com>, "Reshetova, Elena"
	<elena.reshetova@intel.com>, "Wu, Binbin" <binbin.wu@intel.com>, "Hansen,
 Dave" <dave.hansen@intel.com>, "Annapurve, Vishal" <vannapurve@google.com>,
	"kas@kernel.org" <kas@kernel.org>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "Fang, Peter" <peter.fang@intel.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: Re: TDG quote analysis
Thread-Topic: TDG quote analysis
Thread-Index: AQHdRXUGnV1D6jtpckytZt9IbBOCMLbRf7KAgAANsICAAAqMAIAAM3uAgAAIGQCAAA/ugIAAEEIAgADUxICAAEy5gIAAHYGAgAAafICAACp6AIAAK0aAgACxHQCAAFN8AA==
Date: Fri, 18 Sep 2026 18:12:05 +0000
Message-ID: <7d40bcd97e01390a345ce1dbe26264e7b064a619.camel@intel.com>
References: <dae5a64112c9c949524226c66efac9c669df5b92.camel@intel.com>
	 <aqsfoHzOip3n4zdU@intel.com> <aqss_eQAY7soHRwJ@google.com>
	 <28f7a805c57da35d86b5c495cdf2b613a61d235e.camel@intel.com>
	 <aqvtG90zWq6SkU8L@google.com>
	 <3f97caf660cbe460b8bbaf3f2a72e4b6a3ea83d9.camel@intel.com>
	 <aqxGN2Zc8sOl2RKx@google.com>
	 <906d0cb6515b396f4e9d74f1d546c902ea3ce49a.camel@intel.com>
	 <aqyAED5ZK48eEZtq@google.com>
	 <56a61983c03806120e607dfd1e1b7c9046c1f54b.camel@intel.com>
	 <aq048KmPN5WPQ4sQ@google.com>
In-Reply-To: <aq048KmPN5WPQ4sQ@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|DSWPR11MB9930:EE_
x-ms-office365-filtering-correlation-id: 7b62addc-1657-4e54-0e96-08df15b0588c
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|10067099003|4143699003|56012099006|11063799006|6133799003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: HYau15XQDQlKVB4pdbqdZ7iaSbhbW53Dz3ihfUUcCg7s1diw+Ymk2Ye3VWJhR3RgYeIx7EpyYdO29KN1QksjUUw1nGSTBbBaL1ic2XIPSr2T6yjuxpgeULKSZiC0OlBidVc7mIV2zC3NR5RSv4gwC6lNiF2cKr8TcWdZ32N5NFKMG2tfm/TMs+8nQOSJYHyl50F9vPvoms+4oWsn8EyDNK9cyruS7UbFisZWzNQgnpaMZ9Gf2lOlI6Cm+wuSqSFKiKwEyhrBDehKB0iwBtrttNRT8qQcs0OgWUKORmRSso6Jp2jqBwB9N3F3v3u9QUKEOMVLpPf1t9V+vHkKL/Coz9yzZhCiA8zIbHIOxDtlHs3udjctdNxdgTGD4fFIIyf8UsgYinBFfM3FZJOWblAgOj/RmF6YWlugmMZVcQqR53T/tLw+ZMYvlfbLj7QLz1C50aMM8ueuPwNmbXqM+Uxu2UtdWuD97NUCPZtEoqalO3Zh6QPMvhSJauY+vTfQaUMYIVNnJH+GFrSyMkmbJtQtH5ZfJ6TwUSgI4n84ps3TqcqoWW3f0SnWsE9AbIloe2g5mdbbVFfk0d5bsbxpnEXNUq7mL28h0dsx0bjyYJVCA/3RkaVMuoN59WW2YIV28orEhPzbykFomv6v3wO8gbSD01KpmdWrOQ/Vr9Qqeze0un5mIIYmrlfHal9UK/z/sAsr1T6pyX+gpquSoXqtcm+asOCAZncArBAlLTLFjNQJ70Q=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(10067099003)(4143699003)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a212WEJuV0w5NGdCMVhaZmZQamtVckV6YUlpOGFJRmUwZXQxV1FmdjVQbUwz?=
 =?utf-8?B?TlljVkttUDFIcUptTVhrVGpJbktuMXZ3cFUybzIwdFg4bldaVGtMS2tBdDJS?=
 =?utf-8?B?Q1kzMGVFY1RqTEp3dTRFSVNNV21WSjJIak55WUZuVld2bG1YRHd2SHpzNTJB?=
 =?utf-8?B?cmVrdG5tWVlYY0lyL051Nm9MQktPdElER1h2c2s0VE90L0VxWXNqVXV5dDBu?=
 =?utf-8?B?T3ArWk1vdDhuNURpait6QW1ZNGl4M1o4d21JZUo1aktYWjc1amJYbWdFYmdZ?=
 =?utf-8?B?VTZtREtiRTFKdkRDaEdCQXE3eUZDM0pCZXRiYmI3bm9LNmJ6U3pHc3p5WlNV?=
 =?utf-8?B?Q1ZjVVBFZjhJUmRCaDluUTNpMFZpMWhIdHBlVEFNTFlHQWFFMEo2UVN0YW53?=
 =?utf-8?B?VnZiZHJNeS8wcUhnd1k2M2NPS2o0QzE1clN4Z0o1Z1Z3SDI5TVg2Vk9naVBP?=
 =?utf-8?B?TEpIMHhQTHRTazVGOHVWaXRsSkdGQ1pNUkpzM3ZRRjdSRCtSQUlVUzVuTzZp?=
 =?utf-8?B?YVNVZ1l4ZWpmWmh1Y0RvQ2ltZ091eUQ4OW4rZ040Zm01dWt6SjRpZnJHSjNq?=
 =?utf-8?B?dWNLa2RQaEUwSTllcnorUUo5ZTNIYXM1UmVuakpWaGVCc09NZERXWUtkRDds?=
 =?utf-8?B?M0l6eGN3aE12aXZXQjNTRDlyZ29vNEZQcXpTUkt1N2ZDVXcrRC9aUmkzcmVr?=
 =?utf-8?B?STdMRzFFd1ozYUJUeUV2eUVSclJyUEtHVFIxaXQvYWlJejUwOUJ4NndKc1hw?=
 =?utf-8?B?K3lyQ0VRSnZ4ZUd4V3RPMHdpdkQ2WG9WVWJqT3BTdGtlU1JoalJQVUxYREpF?=
 =?utf-8?B?Q2FVWXlpYW0wdHJyOFo0N0YvelErRWx1bkpieDJmR29NK1dMSUVCaCtVZm5k?=
 =?utf-8?B?MHByL2hoUHUxSDBkUW9RSkhjb1lIVFhIbXVWay9hZjllOVdwRGV5U2NyWEx1?=
 =?utf-8?B?L0VPY2thL1hvOVI5cGJuQktZc3RQK2ROQkY0L1NhdWNvQjZJTlVXZEluSFNU?=
 =?utf-8?B?cVY4a29kSGdGSzE3dEJQd3Rlc2RiUGZXYklEN3NVNEJUaWR3NUZpYWgxTmZC?=
 =?utf-8?B?amRzNnBhVDhxd3dSQlBwVE1ORWVpczBhd2x0dVBNUkF6UFlBWUdHR01yZzJF?=
 =?utf-8?B?eXBSL2FMWXNRWmdiYjVLUC9BT3ZWVUNrYWQwWi9ua0UzblJVSGplUjA1anBx?=
 =?utf-8?B?QldiYnNyenl1QWRwaFc3SVlsckYxRWVsMmk0ZzJsNzJBSjl3U1A0ODkrc2FB?=
 =?utf-8?B?aEY1VUV5ZjdYT2JVVGtqZlRYbFVlQW11N05aczZDNFY5RHMwb3I4WGp3OXhl?=
 =?utf-8?B?R3pwUno5c3FCVy9hczZ3YzJUMnNOQWtuNzYrWWt3U2JIRkRBQVp6aitiOU52?=
 =?utf-8?B?QWpESnMyelhyeCsyZWVZQ09HUXVIMS9ZVXNLWFo4YVZsNnVWTmRxS3JiUTB4?=
 =?utf-8?B?Zzd5aUpFOHdxR2ZqRkVPak5peXA2MVFZT3phMWUxNHdMU1pwWHR3RlErR2Vj?=
 =?utf-8?B?elVRaWwySzNUZDBncUYvUDJGV09sN3lkVjRIa2ZoSkdGSlJEOVlmaWtrYkl6?=
 =?utf-8?B?SkFtUExQWWZaQ1dPc043b1FoRVZHN0hoVmRBb1dTcW1pOG4zMjVudU1leFBP?=
 =?utf-8?B?dVdKUVA0T3FCYlhQcE5nSkY3WlhLYkwvVmpydlBBWkluN2I3SmRNSEhRSUlh?=
 =?utf-8?B?dytKRmYyNWgxMXVNYXFJT0NYeHpsN25RNHMzZUh3Z0YzU0lHRTJLZDZPSExZ?=
 =?utf-8?B?aWl4Y21KK01qU2xZSWhMYjhPaXdodllNQ0hJZUhnU2UvSHl2UTQ1eUhpazdE?=
 =?utf-8?B?TEhzM3BUVWNwaE5SVjZSREdMb2c0TDdMQmx5NTF4cmZ4MXBtQ1d2bll0ZGVv?=
 =?utf-8?B?czY1aEs0V011YkVjaDRDOERQREdTTTNINGxFYTllMVJNL1B6Wk9lLzNUNzY4?=
 =?utf-8?B?SFBGZzd3aTdWMEg0a25qSkc2L01iSXJDd3JBWC90ZXhmbzRtQ1RMSEFxUnla?=
 =?utf-8?B?Vzg4SjBmKzFya2l6eXJHbXNKSlN2UlZyVHVmdkYxQTVpKzRqajhmNS8xN0Fm?=
 =?utf-8?B?aHZhWDJHQmtJSklpbUp2ZTEzRGpuUG9ERjFQRDZEdnduNngvbE5SZXA0ZVBX?=
 =?utf-8?B?R0UwblNiOEI4YVB1T2R4N05rZTRVUmZjZ2ZTZjFmMFFVQWkwL3R6Sm84QVMy?=
 =?utf-8?B?UTJIVVI0UGkybFFyT2dmcHBhQ0FaQTMxRld0SDZqYnV2ZjZaVnFOSy9JRTFB?=
 =?utf-8?B?cGh4TFNzdHA3dyt0SDdrdHZkYm44SzJMZzM0MDlvbXBzcG5GTDgzcUJndENy?=
 =?utf-8?B?NHV6TzBNbmJoM3RyVFB2RHo2RnRVdWxBQnMwWnNleXc5STZHRUhwdllZamhm?=
 =?utf-8?Q?IZ8KiawT/TJArzNE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <126F3F39DDC7C94980D3757DE5F44204@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: FERY6LUYzlD4HopvWKIP41cNt84w5UEgVyyjkfYyQPQmOr9fKkQd4ip+usJtyoYuVMUZ2k3soK4RzvEFHErY0ueY4HCVJrb03t50wJW/FsqgcQGNyYNzH2Ixn5ciwrLdsFwJAgerq/kDeOWBhhl38FJzrsKBLEDiw2ae0bu+BSbKjl6xK/z4RMwIrBg4SH45/bSDIpHKX7JKE5FMoCb3BayKf/N4kw1hcwHigi+YVsRkXU4CGrt2pjqWkRCJwrFGKMWwp3MFfBlYqV8T7U8ZhxdKQ/wA5hXLlHNkK3BHccsbY69POzodq1hPZdW5m57ro5XI9CmVPDVN26h88btrpg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b62addc-1657-4e54-0e96-08df15b0588c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2026 18:12:05.2705
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0stWNsJqrdYAkB8GbbQmrzNSvvejpNhujUoldPRHQ4AMJEIdI2xATFLTYg1W48Yorqh9RBV/m+reZ8Vjqyca1c+JmUyj21GJZjBl2AOCrFM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR11MB9930
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTA5LTE4IGF0IDA2OjEzIC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBPbiBGcmksIFNlcCAxOCwgMjAyNiwgUmljayBQIEVkZ2Vjb21iZSB3cm90ZToNCj4g
PiBPbiBUaHUsIDIwMjYtMDktMTcgYXQgMTc6MDQgLTA3MDAsIFNlYW4gQ2hyaXN0b3BoZXJzb24g
d3JvdGU6DQo+ID4gPiDCoCBJZiBzdXBwb3J0ZWQgZm9yIHRoZSBzcGVjaWZpYyByZXF1ZXN0IHR5
cGUsIHRoZSBob3N0IFZNTSBjYW4gcmVxdWVzdCBhbg0KPiA+ID4gwqAgaW50ZXJydXB0ZWQgcmVx
dWVzdCB0byBiZSBhYm9ydGVkLg0KPiA+ID4gDQo+ID4gPiBUaG91Z2ggcGVyIHRoZSBhYm92ZSwg
YXBwYXJlbnRseSB3aGV0aGVyIG9yIG5vdCB0aGF0J3MgZ29pbmcgdG8gYmUNCj4gPiA+IHN1cHBv
cnRlZCBpcw0KPiA+ID4gVEJEPw0KPiA+IA0KPiA+IFNvIGV4dGVuc2lvbiBhYm9ydHMgYXJlIGEg
d2hvbGUgJ25vdGhlciB0b3BpYy4gQW5kICJzdXBwb3J0IiBoYXMgYSBudWFuY2VkDQo+ID4gYW5z
d2VyIHRvIGJvb3QuIEknZCBiZSB2ZXJ5IGdsYWQgdG8gaGVhciB5b3VyIHRob3VnaHRzIG9uIGl0
LiBTaG91bGQgd2UNCj4gPiBsZWF2ZSBpdCBmb3IgYSBsYXRlciB0b3BpYyBvciBnZXQgaW50byBp
dCBub3c/IEkgKnRoaW5rKiB3ZSBkb24ndCBuZWVkIGl0LA0KPiA+IGJ1dCB0aGUgbW9yZSB3ZSBn
ZXQgaW50byB0aGUgZGV0YWlscyBoZXJlLCB0aGUgbW9yZSBpdCdzIGEgbm90YWJsZSB0aGluZyB3
ZQ0KPiA+IGhhdmVuJ3QgY292ZXJlZC4NCj4gDQo+IEhvdyBpcyBzYXlpbmcgIkkgbm8gbG9uZ2Vy
IHdhbnQgdG8gY29tcGxldGUgdGhpcyBxdW90ZSIgYXQgYWxsIGNvbXBsZXg/wqAgSSBjYW4NCj4g
c2VlIGhvdyBhYm9ydGluZyBhIHJlcXVlc3QgdG8gdGhlIFMzTSBtaWdodCBiZSBzb21ld2hhdCBw
b2ludGxlc3MsIGJ1dA0KPiBpbnNlcnRpbmcgdGhlIGVxdWl2YWxlbnQgdG8gc2lnbmFsX3BlbmRp
bmcoKSBpbiBhIGxvbmctcnVubmluZyBvcGVyYXRpb24NCj4gZG9lc24ndCBzZWVtIHRoYXQgZGlm
ZmljdWx0Lg0KDQpBcyBhbiBpbnRlcmZhY2UgaXQgaXMgbm90IGNvbXBsZXguIEJ1dCBhcyBhbiBp
bXBsZW1lbnRhdGlvbiwgdGhlcmUgYXJlIHRyYWRlb2Zmcw0KYW5kIHZhcmlvdXMgb3B0aW9ucy4N
Cj4gPiA+IA0KPiA+ID4gWy4uLl0NCg0KPiA+ID4gDQo+ID4gDQo+ID4gSSB0aGluayB0aGUgYWJz
dHJhY3QgZGVzY3JpcHRpb25zIGFyZSBub3QgaGVscGluZywgc28gSSdsbCB0cnkgc29tZSBtb3Jl
DQo+ID4gZGV0YWlscy4gVG9kYXkgdGhlICJ0aHJlYWQiIGludm9sdmVzIHNvbWV0aGluZyBsaWtl
IGEgdkNQVSBpbiBhIFRELiBZb3UgY2FuDQo+ID4gc2VlDQo+ID4gc29tZSByZWZlcmVuY2VzIGlu
IHRoZSBURFggYmFzZSBzcGVjIGxpa2U6DQo+ID4gwqDCoCBDdXJyZW50bHksIFREWCBNb2R1bGUg
ZXh0ZW5zaW9ucyBhcmUgaW1wbGVtZW50ZWQgYXMgZ3Vlc3RzIHJ1bm5pbmcgaW4NCj4gPiBTRUFN
IG5vbi0gcm9vdCBtb2RlLCBjYWxsZWQgTlJYIE1vZHVsZXMuIFRlY2huaWNhbGx5LCBlYWNoIE5S
WCBNb2R1bGUgaXMNCj4gPiBzaW1pbGFyIHRvIGEgVEQuDQo+IA0KPiBTbyBteSBhYm92ZSBzdGF0
ZW1lbnQgdGhhdCAiaXQncyBub3QgdHJ1ZSBpbnRlcnJ1cHRpb24sIGl0J3MgYmFzaWNhbGx5DQo+
IHZvbHVudGFyeSBwcmVlbXB0aW9uIiBpcyB3cm9uZz/CoCBCZWNhdXNlIGlmIHRoZSBxdW90ZSBj
cnVkIGlzIHJ1bm5pbmcgaW4gYSBURCwNCj4gdGhlbiBldmVudHMgd2lsbCB0cmlnZ2VyIFZNLUV4
aXQsIGFuZCBpdCB3aWxsIGJlIGltcG9zc2libGUgdG8gbWFrZSBmb3J3YXJkDQo+IHByb2dyZXNz
IHdpdGhvdXQgU0VBTVJFVGluZyB0byB0aGUgaG9zdC4NCj4gDQo+IElmIHRoYXQncyB0cnVlLCB0
aGVuIHRoYXQgY2hhbmdlcyBteSB1bmRlcnN0YW5kaW5nIG9mIHRoaXMganVzdCBhIGJpdCwgYmVj
YXVzZQ0KPiBpdCBtZWFucyB0aGUgcXVvdGUgb3BlcmF0aW9uIGlzbid0IG1hbnVhbGx5IHNhdmlu
ZyBzdGF0ZSBhdCBhICJnb29kIHN0b3BwaW5nDQo+IHBvaW50IiwgaXQncyByZWx5aW5nIG9uIHRo
ZSBWTS1FeGl0IHRvIHNhdmUvcmVzdG9yZSBhdCB3aGVuZXZlciBpdCBoYXBwZW5lZCB0bw0KPiBi
ZS4NCg0KWWVhLCBJJ2QgdGhpbmsgaXQgaXMgYmVzdCBub3QgdG8gbWVzcyB3aXRoIGNyeXB0byBp
bXBsZW1lbnRhdGlvbnMgdG8gYWRkDQphbnl0aGluZyBsaWtlIGNoZWNrcG9pbnRzLiBUaGF0IGlz
IHdoYXQgZXh0ZW5zaW9ucyBicmluZyB0byB0aGUgdGFibGUuIFRoZSBvdGhlcg0KcmVzdW1hYmxl
IHNlYW1jYWxscyBiYXNpY2FsbHkgd29yayBsaWtlIGNoZWNrcG9pbnRzLiBCdXQgaXQgaXMgbm90
IHN1aXRhYmxlIGZvcg0KYWxsIG9wZXJhdGlvbnMuDQoNCj4gwqBCdXQgZ2l2ZW4gdGhhdCB5b3Ug
c2F5ICJUaGlzIGlkZWEgY2FtZSB1cCBiZWZvcmUgYWN0dWFsbHkiLCBtYXliZSBjaHVua2luZw0K
PiB0aGUgcXVvdGUgb3BlcmF0aW9uIGlzbid0IGEgYmlnIGxpZnQ/DQoNClRoZSBpZGVhIHRoYXQg
Y2FtZSB1cCB3YXMgdG8gaGF2ZSBhIHNhdmVkIHN0YXRlIGFyZSBwZXItVEQuIEJ1dCB0aGlzIG9u
bHkNCmVsaW1pbmF0ZWQgY29uY3VycmVuY3kgaXNzdWVzIGluIHRoZSBTVyBiYXNlZCBmbG93LiBJ
biB0aGUgZnV0dXJlIGEgSFcgYmFzZWQNCmZsb3cgd291bGQgYmUgUzNNIGxpbWl0ZWQuIFdoaWNo
IGlzIHdoeSBJIGtlZXAgc2F5aW5nIGEgcmVkZXNpZ25lZCBzb2x1dGlvbg0Kc2hvdWxkIGJlIHJv
YnVzdCB0byBjb25jdXJyZW5jeSBsaW1pdGF0aW9ucy4NCg0KPiANCj4gQnV0IHRoZSBvcmlnaW5h
bCBtYWlsIHNheXMgdGhpczoNCj4gDQo+IMKgwqAgLS0gR3Vlc3QgSW50ZXJydXB0cyAtLQ0KPiAN
Cj4gwqDCoCBJdCBpcyBub3QgbmljZSB0byBrZWVwIHRoZSBndWVzdCBmcm9tIHJ1bm5pbmcgZm9y
IHRvbyBsb25nLiBUaGUNCj4gVERILlFVT1RFLkdFVA0KPiDCoMKgIFNFQU1DQUxMIG1vbml0b3Jz
IGZvciBob3N0IGludGVycnVwdHMsIGJ1dCBub3QgZ3Vlc3Qgb25lcy4gU2ltaWxhcmx5LCB0aGUN
Cj4gU0dYDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5e
Xl5eXg0KPiDCoMKgIHF1b3RpbmcgZW5jbGF2ZSBkb2Vzbid0IGtub3cgd2hhdCBpcyBoYXBwZW5p
bmcgaW4gdGhlIFRELiBTbywgdG8gaGVscA0KPiByZWR1Y2UgZ3Vlc3QgbGF0ZW5jaWVzLCB0aGUg
R0hDSSBleHBvc2VzIGEgd2F5IHRvIHJlZ2lzdGVyIGZvciBhIG5vdGlmaWNhdGlvbg0KPiDCoMKg
IChTZXR1cEV2ZW50Tm90aWZ5SW50ZXJydXB0KSB3aGVuIHRoZSBxdW90aW5nIGlzIGZpbmlzaGVk
LiBBIHF1b3RlIFREVk1DQUxMDQo+IMKgwqAgaGFuZGxlciBjYW4gc3RhcnQgdGhlIHF1b3RlIG9w
ZXJhdGlvbiBvbiBhbm90aGVyIGhvc3QgdGhyZWFkLCBhbmQgcmVzdW1lDQo+IMKgwqAgZ3Vlc3Qg
ZXhlY3V0aW9uIHdhaXRpbmcgZm9yIHRoZSBxdW90ZSB0byBmaW5pc2guDQo+IA0KPiB3aGljaCBz
dHJvbmdseSBzdWdnZXN0cyBhY3RpdmUgcG9sbGluZy7CoCBEbyB5b3Ugc2VlIHdoeSBJIGRvbid0
IHdhbnQgYWJzdHJhY3QNCj4gZGVzY3JpcHRpb25zP8KgIFNpbWlsYXIgdG8gY2hhbmdlbG9ncywg
dGhlcmUncyBhIGJhbGFuY2UgYmV0d2VlbiAidG9vIGRldGFpbGVkIg0KPiBhbmQgInRvbyBhYnN0
cmFjdCIsIGFuZCByaWdodCBub3cgYWxsIG9mIHRoaXMgaXMgZmlybWx5IG9uIHRoZSAidG9vIGFi
c3RyYWN0Ig0KPiBzaWRlIG9mIHRoZSB3b3JsZC4NCj4gDQoNCkZvciBhIGhvc3QgaW50ZXJydXB0
LCBJIGV4cGVjdGVkIGJhc2ljYWxseSB0aGUgc2FtZSBmbG93IGFzIGEgbm9ybWFsIFRELiBGb3Ig
dGhlDQpndWVzdCBmbG93LCBJIGRvbid0IGtub3cgdGhlIGV4YWN0IHZteC1sZXZlbCBzb2x1dGlv
biBmb3IgaXQuIEkgdGhyZXcgb3V0DQpwb2xsaW5nIGFuZCBoZWFyZCB0aGVyZSBjb3VsZCBiZSBh
IGNsZWFuZXIgb3B0aW9uLiBOb3Qgc3VyZSB3aGF0IGl0IHdhcy4NCg0KPiA+IA0KPiA+IA0KPiA+
IERhdmUgd2lsbCBwcm9iYWJseSBub3QgZ2V0IGEgY2hhbmNlIHRvIHJlc3BvbmQgdGhpcyB3ZWVr
LCBidXQgd2Ugc2hvdWxkDQo+ID4gbWF5YmUgZGlzY3VzcyB3aGF0IGFjY2VwdGFibGUgZ3Vlc3Qg
bGF0ZW5jeSBhY3R1YWxseSBpcy4NCj4gDQo+IFllcy7CoCBCdXQgaXQncyBub3QgbmVjZXNzYXJp
bHkgYWJvdXQgImFjY2VwdGFibGUiIGd1ZXN0IGxhdGVuY3ksIEkgY2FyZSBtb3JlDQo+IGFib3V0
ICpwcmVkaWN0YWJsZSogZ3Vlc3QgbGF0ZW5jeS7CoCBFLmcuIG1ha2luZyB1cCBudW1iZXJzIHRv
IGlsbHVzdHJhdGUgdGhlDQo+IHBvaW50LCBhY2hpZXZpbmcgNTB1cyBsYXRlbmN5IGZvciB0aGUg
aGFwcHkgY2FzZSBpcyBtZWFuaW5nbGVzcyBpZiB0aGUgUDk5DQo+IGxhdGVuY3kgaXMgMTBtcy4N
Cg0KVGhlIFNFQU1DQUxMcyB0b2RheSBoYXZlIG1heCBsYXRlbmN5IGFuZCB0aGV5IGdldCBtZWFz
dXJlZCB0aHJvdWdoIHNvbWUgdGVzdGluZw0KcHJvY2Vzcy4gSW4gcHJhY3RpY2UsIHNvbWUgZXhj
ZWVkIGl0IGJhc2VkIG9uIHRoZSByZWFzb25pbmcgdGhhdCB0aGV5IGFyZSBvbmx5DQpydW4gb25j
ZSBvciBhIGZldyB0aW1lcyAoc2V0dXAsIGV0YykuIFNvIGZvciB0aGUgaG9zdCBzaWRlIHRoYXQg
aXMgaG93IGl0IGdvdA0KZGlzY3Vzc2VkLiBJdCB3YXMgaW4gdGVybXMgb2Ygd29yc3QgY2FzZS4N
Cg0KQnV0IG5vdyBJJ20gd29uZGVyaW5nIHdoYXQgeW91ciBzcGVjaWZpYyBpbnRlcmVzdCBpcy4g
SXQgc2VlbXMgeW91IGhhdmUgbW9yZQ0KaW50ZXJlc3QgaW4gbm9uLUtWTSBpbi10aGUtbG9vcCBn
dWVzdCBzaWRlIGxhdGVuY3kgdGhhbiB5b3UgZGlkIG9uIGhvc3Qgc2lkZS4NCldoaWNoIGlzIGZp
bmUuIEJ1dCBpdCBtYWtlcyBtZSB3YW50IHRvIGRvdWJsZSBjaGVjazogWW91IHdhbnQgYW4gYXZl
cmFnZSBhbmQNCndvcnNlIGNhc2UgbGF0ZW5jeSBmb3IgdGhlIGZpcnN0IERJQ0UgYXR0ZXN0YXRp
b24gIlNXIiBmbG93Pw0KDQpPciB5b3Ugd2FudCBhbiBhdmVyYWdlIGFuZCB3b3JzdCBjYXNlIHBy
b21pc2UgZm9yIHRoZSBmdXR1cmUgZmxvd3M/DQoNCk9yIHlvdSB3YW50IGFuIGF2ZXJhZ2UgYW5k
IHdvcnNlIGNhc2UgYmFzZWQgb24gd2hhdGV2ZXIgZ3Vlc3QgaW50ZXJydXB0DQpkZXRlY3Rpb24g
c2NoZW1lIGlzIHVzZWQgZm9yIFRERyBleHRlbnNpb24gY2FsbHM/DQoNClRoZSBsYXN0IG9uZSBz
ZWVtcyB0aGUgbW9zdCByZWxldmFudCB0byBtZS4gQW5kIHRoZSBwb2ludCB3b3VsZCBiZSB0byBk
ZXRlcm1pbmUNCnRoZSB0cmFkZW9mZnMgYmV0d2VlbiBob3N0IHRocmVhZCBiYXNlZCBxdW90ZSBj
YWxsIGFuZCBhIFRERyBjYWxsLiBCdXQgb2YgY291cnNlDQpub25lIG9mIHRoaXMgaXMgYnVpbHQg
eWV0IHN1Y2ggdGhhdCBpdCBjb3VsZCBiZSBtZWFzdXJlZC4gVGhpcyB3YXMgdGhlICJoZXJlIGlz
DQpob3cgaXQgY291bGQgbG9vayBpbiBnZW5lcmFsIiBkaXNjdXNzaW9uLiBTbyBJIHRoaW5rIGl0
IHdvdWxkIHRha2Ugc29tZSBURFgNCm1vZHVsZSBQT0Mgd29yay4NCg==
