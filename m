Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779B84FD7A3;
	Mon, 28 Sep 2026 21:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790630735; cv=fail; b=QWsm2NKyk5q3rVA90tK8+veDN2T0vmvVa9sWzi8K5FpJdTK8smpk/k4+xl5O9Lh03gKTiPzAQoLBKv1ga8mXGk5aRLal9LQTshaYCr/uJ4K9NL+pb1rq4j5poMrVcHvkrDhqgQ6mwjtKdsWIe62QkqJVYL6uDev1PW9uSBZ7Gz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790630735; c=relaxed/simple;
	bh=3+gbwMTE4fRql0yPXvKRlXmpu+maeNiGHUrFnFywd7s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=czIkB0vggFI0K7EdAVv0Xwpjg5BQRhLF93jfbUEkFJ2ljsDWuHRj+SXtGpRUfZT1tWCq35v4nxjxp5KoW8pVpXdumaGsY9/+t0QXk0VFSETRL7k6dBqtwV7Q3Uyb9fOWdm9nZOhioqrialmwRoABgZms6bjJ7BMNTR9nANWl7e8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gKWgacqY; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gKWgacqY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790630731; x=1822166731;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=3+gbwMTE4fRql0yPXvKRlXmpu+maeNiGHUrFnFywd7s=;
  b=gKWgacqYD7dERBXtG5fzB+eZgM/KafD0CQhyn7yw8A9Uog1WMs84JqvA
   LNh8lrmhdzvDCrnjfwlz44vlCUq16T8FQI1pKZW6S8qDoNQ1O5mWIzZZo
   K+DFbysFblDkNuiuwEeynB+d3Hot/I0//zjtiEaw7pUzlPwFUP6bey9CR
   dYze7RvjEjNBt6TvR8BM0HXeuUuWT9eG+v5PWt5K3PW4XklhrnGhaqTmn
   HRcGln35JpEMizuS+DzdnEdESKtjpKhe1N2IgvovAokDgOWSDgoLfdOnI
   tGYGiKEe7MWo6azYyJe406Wf2Zgzk+yIk8wKYZbpdlx2sFKzEKqIquimk
   A==;
X-CSE-ConnectionGUID: B+e+Ay6PT3qu5+WzAD76dg==
X-CSE-MsgGUID: Kpuo+ZC7TMGsnYYgLnR+VA==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="91362801"
X-IronPort-AV: E=Sophos;i="6.27,129,1787036400"; 
   d="scan'208";a="91362801"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 14:25:27 -0700
X-CSE-ConnectionGUID: YzqmJsKWQwW+yFKo3kL9hw==
X-CSE-MsgGUID: +/O5o//kR/abEP35hw0MDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,129,1787036400"; 
   d="scan'208";a="278375073"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 14:25:27 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 28 Sep 2026 14:25:26 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 28 Sep 2026 14:25:26 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.39) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 28 Sep 2026 14:25:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u5xqwjNL89yJcUviousqCcQS05A4D3nealBVXwinlMIONEu8cPmIhrpqfC0pr3MSftS/eTikkXcGCwH+aZP/JMM/EO2WlEyiVmeLRK8PIZR0KvNLi/J7nZIe7aP1s3NUrpkFcyjhkrtcQyjZ3KfqJWfqIN6qSKwxNyJSJ3U1UxASOVm9sX4KxL+Hileh31vknJqsEjJkzYiwqZrRj7Ab3Jv4mlabRgKtwoB1FmITxZHjaPPNwNhEg9Yv3LqJBU8PzFIKJPekylBLG/RPg7Mbx8Lg618ZB7j0IROmVvnOynkuGtCT0oUGauiD5iAKFJ4elLgPj394+whc75Q8PgRfPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3+gbwMTE4fRql0yPXvKRlXmpu+maeNiGHUrFnFywd7s=;
 b=U7ZBIfH7U60k9Mk9lqKESiRmiGNZk1+vC7cALIyEoC7BVRNn5x7gauFCFuB78TBtDjJ2pAgFxnt3CtL04S95xROIkiNGsq9jZSUo30efRMpNWnO0cOo44cP8CKNtWcE32XvOEXX8dLE776zPDuWUO0HHkKFsd9NxNQPup0e7WX+EqjA8LfEorJK6EDAmOXzdfewra8tJpzmUBYVRsUI4tII3QQiwmS9fWD8e01FXSvR+lJ4oFXuVLv2Xhw7YVUbqH5YNUXE4q3O69wo40q0G0Zwbwbdy/VPMLgIOZSEkU8lrf5UWPkNJCCe20ABaswq84HOUKR860nTMA8YiWkpmCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by SJ0PR11MB5868.namprd11.prod.outlook.com (2603:10b6:a03:42b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 21:25:22 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0451.014; Mon, 28 Sep 2026
 21:25:16 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Fang, Peter" <peter.fang@intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Li, Xiaoyao"
	<xiaoyao.li@intel.com>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "kas@kernel.org" <kas@kernel.org>,
	"seanjc@google.com" <seanjc@google.com>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "tony.lindgren@linux.intel.com"
	<tony.lindgren@linux.intel.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"hpa@zytor.com" <hpa@zytor.com>, "tglx@kernel.org" <tglx@kernel.org>,
	"bp@alien8.de" <bp@alien8.de>, "Bityutskiy, Artem"
	<artem.bityutskiy@intel.com>, "sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>
Subject: Re: [PATCH v5 5/6] x86/tdx: Add a helper to query maximum Quote size
Thread-Topic: [PATCH v5 5/6] x86/tdx: Add a helper to query maximum Quote size
Thread-Index: AQHdTzGsoGIHh9qePk+bCG/ii8ItOrbkVhWAgAAoFACAAAMngA==
Date: Mon, 28 Sep 2026 21:25:16 +0000
Message-ID: <dec9a448fe5788b748ba616074270242fac5fa79.camel@intel.com>
References: <20260928100913.2265687-1-peter.fang@intel.com>
	 <20260928100913.2265687-6-peter.fang@intel.com>
	 <bd235459708f5233444f31270d8785c0818c107f.camel@intel.com>
	 <arrYlnkCq4GDIG9M@intel.com>
In-Reply-To: <arrYlnkCq4GDIG9M@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|SJ0PR11MB5868:EE_
x-ms-office365-filtering-correlation-id: 7322b432-0fae-455b-d899-08df1da6fd6e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|23010399003|366016|1800799024|376014|10067099003|11063799006|6133799003|56012099006|22082099003|18002099003|4143699003|38070700021;
x-microsoft-antispam-message-info: C6U06hQOnsjUX6dsGWtG78Pf/zg+V+Sar782udy7L/oIoTAsHa4qiLZX9vEGbsu0HNKav+Tdt/Hi4/Ck+HbyAUQtV4BpvAdXIfS543Wf4GqpzgeRtYTiRZvjgPJCFq0Zzyww8DKlXGvlGmupMO6YszlWIZ1NoT1mm4JIlitHHixqmrEtcDNLgAsaH6LA2CMDZHyISEBWqoJXEzTAIsDajrLKjZvkXvhrjgh/319EqVyGdkVSujTSDVzTLPijA3ovflVFCqEyftjRVJmFGsw+Y83HUW+pZ6lO9UZvok3fk9/SpGsEVY3G5gWqAv/A86AkEasHXd6rnjG4IK3P2S0iAnnfMlUhq0gnPP+CCHvBFpCjMOso2xPT9kiuAYDCJo8dFKtJ2TZjRRzRvqTxCE8UWR3Xr0EiFmKaUiBsbKXCgyKDsY0utXg7mQoIr7YdL/WOIQjfX6drDOfq0f5jq1YqdTCXoJjh1KwWviM27LQal5aMLFlA6Xh4DoB8maPi8np7vblgxxvPIpnTP/BnDpvbwVm963kj0s8AsaZ5se+wPMviENZ+r8ZnfbrqdYofGVNbHYBaPYV3SgX+G2se8SMFUvN1nvwx4b1A0EDrC7Aaa+TggnF78PCOygbeO+lltuDT2VOyi8tO3sDQ5bgiDgHQaJKGXcrJa4UqsYBY+Zu1mn/w8qbatrj7HQD8Ka7+nrD6dRu/do5oXIB2OgZAkkEnfnO3gd/jZS3p8gHtkgCeTTs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(366016)(1800799024)(376014)(10067099003)(11063799006)(6133799003)(56012099006)(22082099003)(18002099003)(4143699003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UGtUWEJmRHBXYm9EcFJFZ1hQcHlZbVdQZ2tONldmWDhWOVVmKzlDY3BKUWlJ?=
 =?utf-8?B?WmZxRW42anBwM2hrQklLaUt0bzlWWXJlUlYyUS9mUXN5Y3V4dFNFUE5kOGlV?=
 =?utf-8?B?SGR1U2g0UVZrT0pkR0JMb1gybFRLM2Fyby92T0FZaTR5WmhCOW1GbUE3cTE1?=
 =?utf-8?B?MzJzOWpYNWsyRW1FR1o1dmF4YkhQRWRsYUYvbFBQdVRyVHUxWlZzVDZhQmZT?=
 =?utf-8?B?dllNdXd4RE9wRHhibjkzYnFsRGozbSs4Rlp4TEs5aHFOanJXYkxMS1Y1c2Rl?=
 =?utf-8?B?b3JBbVR2djI5UzV6RWg2ZDlieDNGQWZSUFdzNm4ybVJqR3FtRjlGQWpVWEY2?=
 =?utf-8?B?THlMNE5JWS8xY2lWYlZZOE0vUk4zK0d3cUtZcFdtK1MyZm1DbzhDWlQ0NjAz?=
 =?utf-8?B?RzFVUFpWWlBhbVVkYlVFMFpVUHhwMWJqbUIyV1FlYStVS05qQm1RUTh0RWE4?=
 =?utf-8?B?WGx2VEtBS3h2M0NFWlJweFg3NFBlTDJIdFVmQVpDbWVYbGtCdlhQSjdiZzBs?=
 =?utf-8?B?S1VUK3dBTDZkcVd4NFhaNERkZkVrQWZKalJHSzZ4VWFpY2cxd2cwSi9PUVFa?=
 =?utf-8?B?SVYxdnhPTFZQUFNkSkRSRlhEOUhaUHQ1OWVTcENZRXdNZ1ZJWlBBYWVheVNs?=
 =?utf-8?B?OUdyTjBVK1dBRGR2NHVYd3YxVHJPaHAzajdaK1o0RU9FWXJRVUF5THlJNXli?=
 =?utf-8?B?VnNPSkNjUFhjakE5THZkRGpUQkRrU09SVXdNNjJ2U0NXQ2VPRUVzQU1CenJu?=
 =?utf-8?B?a1Z3M2o4dWxjWlNRcEhPbXVQTUFoSzE0c0lnQnc5d2FhRkJLNFVhZ2lUZ0V1?=
 =?utf-8?B?eTh2NFFQVFNlbkJvbTVGVDlxRW4veXFNYVRFMFJLVUcxOXE4cUt3dDdMQVlL?=
 =?utf-8?B?M3hBeFRXVUkvSWc3SnViYmpaa0xtRTFGODZtTEdNSW4wU2JSeGd3WGVzQ1Zv?=
 =?utf-8?B?azhSWE5HZkxhb0IrYmdFVW9JZFcyZm9kMVE3RS9iUEM5OHBnWGVWZEdmeEFV?=
 =?utf-8?B?bDdKNTUyNG5HaXV0Mk9FdFF6LzRoNHhyQlZFcUptM0xGbUk2UUZQS2tTZ2x5?=
 =?utf-8?B?c3Rlc3A2c1BTUmRTYlcvNWhnb05xVU5IUFRxNUFFb016YWtiREtIaU9yTGtN?=
 =?utf-8?B?SHZIVHZNR3czVURpR2FadkZpSi9qSldxdUJOb0J5WkppTGt4OGRidGYzdllJ?=
 =?utf-8?B?MW5tYjBnd1NqbVAyeU9YTmJzSEVqZHhQUGo0YTdUcVl1SCt0YmhvaGFtaEJB?=
 =?utf-8?B?a0kxMUNIQ0daalFmQXJXZHFCMjBRMFVqZXdvd3lGQ3I1RUtEcktpRmdUZi95?=
 =?utf-8?B?QXFGUXh0eFdYVnljWko5SWkxNmFTR0ZMaU81U3ZlYk9OQVh3bEdlYjhDOEp3?=
 =?utf-8?B?UzdQaTAvazNMdG84SHRiOE1tUkVReGt5REVaakJxdWpVRGdaOFVVVTU2a2xU?=
 =?utf-8?B?Y1VsbkEybTREZWp0bzA2UG82dkhSNjR3dnpnazExMXNhaDJmM2N3QnB5S3Za?=
 =?utf-8?B?WkRmc0dMS0N2ZkRVWHNWSHZxSGFBU1Z1TXROLy9GQmlqSEppM2xsSEdFT3Iv?=
 =?utf-8?B?TW8xNVk0QWNRS2JycWsrMmNJOVRWckRGd0Iyb1hNMGM4cTJPMG1lbktvei9t?=
 =?utf-8?B?OUQvb0ovNTFwVjZtQ0FqS3dlOE5Ib090L1J2akxvMzVvZ0o0NSszUW5teEJQ?=
 =?utf-8?B?RWNYNXZ1UUs1YTNKdHcwbmowNm5naE1oZUNqV1RKa0xFQlk5TjJBbGFOSW80?=
 =?utf-8?B?ZzNUVm5SZ1FwKzRjbFBTQnBDQzRna3l0UU1XL1QyQUU5RmYrSFRHc2xhNVk3?=
 =?utf-8?B?VUF0VUhaaDM1eElpSURHWE90VDZaVnNQaWlYR1E1MnUxRVk0ZFU3UGJpWEZC?=
 =?utf-8?B?OE9qQnBvbjdjNS92YTVXUFp4ZG5tbnJCcXZFYUZXNHFwNVp1NnhVSTJaVG02?=
 =?utf-8?B?cjNpQlZBS3JFWllUUWNpbTZvT1I5SktqWVFWZ05iT1cwSy9ONjFrMzcydjF4?=
 =?utf-8?B?WEdyTHQwTGMrQ1ZhdFFMMUVyUWRVbHV4aFcrSUpHNWhPZTNVRUZweXdGTG5D?=
 =?utf-8?B?Y2ppK3c4UkF1YlNTUWJtY3Nia0Y0OUVnZDNUSUJIMGF6Nlh5a1UxWit4cnBJ?=
 =?utf-8?B?Y3BVRnNNMHdtQWhyS290RDkvZnN0RFFHQU1xZUxlRTBtVlg2cGNaOElPcVNK?=
 =?utf-8?B?bmo3bjZURzRjSWlrcVpaSTVPbHBiL08vbGhHNjRjOVRiQmk3ZHhZQU00Ky8z?=
 =?utf-8?B?bk1YZ0Fsa3JIcDB1ZWdtclRzTENtQjYva1lESnNZQmQ1a1ZoWWQzcC8wWTVW?=
 =?utf-8?B?eTRLNGJIWm1PRkxpSDhQZWtzZHpoZmowTW02aEFIM014dHFCSFE3Q24yNW4x?=
 =?utf-8?Q?EHVm23el+ezJTmwE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E5F752BEBEB9A4479AD0C2F3E5B0B3FD@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: opmcQluS2kqE0yVIfo2N07tdPexDpzSoASSuIobwnDvgoFUbyChl9IHbpw/yhjT/QUe4kvVNxI+l72T4ESy1AcaSXXrA5dGW/WLzHUq0KtEnRwzVWZA9GyO7IECONYZYE5EDg4loWZDHIMXWsLKsV+O+tEmfj8ufvjfK0RUD5noUAqmhparWCBFvI2iQqB3eeU6zW5rMZpZUmSvAKn8TUAuKTQfL4paKTFvGvQdBhxwwTp5gZjflfDxnZZmxZqWQ1Ajez/S5iDXUDbjMMetYwhvKwh5V0en81/MPk/kozrfRh9dxPbUVM5k0CiKXqcHqkf5RCYWgJm+uQ9lM9O95bg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7322b432-0fae-455b-d899-08df1da6fd6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2026 21:25:16.3478
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VAmr0EV3OHFk35neOirzCPQ51Hd/U27KgCzcO6W6SrSJsiZlypd33YzZjxydORSZVYZmhI2Z6BS8gI7U9GkayKlq2PGcYH4B5YAFO7Kyrj8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5868
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI2LTA5LTI4IGF0IDE0OjEzIC0wNzAwLCBQZXRlciBGYW5nIHdyb3RlOg0KPiBP
biBNb24sIFNlcCAyOCwgMjAyNiBhdCAxMTo1MDozMkFNIC0wNzAwLCBFZGdlY29tYmUsIFJpY2sg
UCB3cm90ZToNCj4gPiBPbiBNb24sIDIwMjYtMDktMjggYXQgMDM6MDggLTA3MDAsIFBldGVyIEZh
bmcgd3JvdGU6DQo+ID4gPiBbMV0gSW50ZWwgVERYIE1vZHVsZSBBQkkgRGVmaW5pdGlvbnMsIEF1
Z3VzdCAyMDI2LCBURC1zY29wZSBtZXRhZGF0YQ0KPiA+ID4gwqDCoMKgIGZpZWxkICJURF9RVU9U
RV9NQVhfU0laRSINCj4gPiANCj4gPiBUaGUgbGF0ZXN0IHNlZW1zIHRvIGJlIEp1bmUgMjAyNjoN
Cj4gPiBodHRwczovL3d3dy5pbnRlbC5jb20vY29udGVudC93d3cvdXMvZW4vZGV2ZWxvcGVyL3Rv
b2xzL3RydXN0LWRvbWFpbi1leHRlbnNpb25zL2RvY3VtZW50YXRpb24uaHRtbA0KPiANCj4gSSB0
aGluayB0aGF0J3MgIkludGVsIFREWCBNb2R1bGUgQUJJIFNwZWNpZmljYXRpb24iLiAiSW50ZWwg
VERYIE1vZHVsZQ0KPiBBQkkgRGVmaW5pdGlvbnMiIHdhcyB1cGRhdGVkIGluIEF1Z3VzdC4gWWVh
aCB0aGVzZSBuYW1lcyBjYW4gYmUNCj4gY29uZnVzaW5nIHNvbWV0aW1lcy4NCg0KSSBzZWU6IElu
dGVsIFREWCBNb2R1bGUgQUJJIERlZmluaXRpb25zIC0gQUJJIGRlZmluaXRpb25zIGluIFBERiwg
Q1NWIGFuZCBKU09ODQpmb3JtYXQgLSBKdW5lIDIwMjYNCg0KQWghIFRoZXJlIGFyZSB0d28gbGlz
dGVkOiBvbmUgZnJvbSBKdW5lIGFuZCBvbmUgZnJvbSBBdWd1c3QuIFRoZSBBdWd1c3Qgb25lcyBh
cmUNCnN0aWxsIGxhYmVsZWQgZm9yIGNvbW11bml0eSByZXZpZXcuICJUaGVzZSBkb2N1bWVudHMg
YXJlIG5vdCBmaW5hbCBhbmQgYXJlDQpzdWJqZWN0IHRvIGNoYW5nZSBiYXNlZCBvbiBmZWVkYmFj
ay4iDQoNClRoaXMgbWVhbnMgdGhhdCB3ZSBhcmUgdXBzdHJlYW1pbmcgaGVhZCBvZiB0aGUgc3Bl
YyBiZWluZyBmaW5hbGl6ZWQuIEFuZCBURFgNCm1vZHVsZSB3aWxsIG5vdCBiZSBhYmxlIHRvIGNo
YW5nZSBhbnl0aGluZyB3ZSBkZXBlbmQgb24uIFdlIG5lZWQgdG8gbWFrZSBzdXJlDQp0aGV5IGtu
b3cgd2hhdCB3ZSBhcmUgbG9ja2VkIG9udG8uDQoNCj4gDQo+ID4gDQo+ID4gU28gd2hlcmUgaXMg
dGhpcz8gRG9lcyBpdCBzYXkgYW55dGhpbmcgYWJvdXQgYmVpbmcgcGFnZSBhbGlnbmVkIGFscmVh
ZHk/DQo+IA0KPiBJbiB0aGUgcGRmIHRoZSB3b3JkaW5nIGlzICJNYXhpbXVtIHNpemUgb2YgdGhl
IGJ1ZmZlciB0aGF0IG11c3QgYmUNCj4gYWxsb2NhdGVkIHRvIGNvbnRhaW4gdGhlIFREWCBRdW90
ZSByZWNlaXZlZCBmcm9tIFREWCBNb2R1bGUiLiBJdCBkb2Vzbid0DQo+IHNheSBhbnl0aGluZyBh
Ym91dCBwYWdlIGFsaWdubWVudC4gSSBjYW4gY29uZmlybSB3aXRoIHRoZSBURFggbW9kdWxlDQo+
IGZvbGtzLg0KPiANCj4gQnV0IGV2ZW4gaWYgdGhlIHJlcG9ydGVkIHNpemUgaXMgYWx3YXlzIHBh
Z2UgYWxpZ25lZCwgdGhlIGRyaXZlciB3b3VsZA0KPiBzdGlsbCBuZWVkIHRvIHNsYXAgdGhlIEdI
Q0kgaGVhZGVyIGluIGZyb250IG9mIGl0LCBhbmQgdGhhdCB3b3VsZCBtYWtlDQo+IHRoZSB0b3Rh
bCBidWZmZXIgc2l6ZSBhZ2FpbiBub3QgcGFnZSBhbGlnbmVkLiBTbyB3b3VsZCBpdCBiZSB1c2Vm
dWwgaW4NCj4gdGhlIGVuZD8NCg0KQWggcmlnaHQuDQo=
