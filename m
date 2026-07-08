Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C5C233955;
	Wed,  8 Jul 2026 23:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783553887; cv=fail; b=OwWWb4aoFRUBDgrC0IAncVTO/Kde1CAwSoic0gw5LX91K2AkiSPouNvz12v/7tONAUROfnj1oBK05x3Nc4Wr7CyhEjyiL/se4IhUcI+SUoJVEt0UlkJ9ytquytqrZd13gXdEPSFXrgKzSqXLuQmds10FJWT6Q+cuXt8GOj019u4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783553887; c=relaxed/simple;
	bh=KDoVhBW1wzuMLqkBYbaC+7FWzi+GGgd3FX8HQmTBYWU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DYkt+PE2lxz6bT0CqwCRU9gs0YpjOyv4y7V0Rq862Yh9WMLLD8mZmY6k6e4htJlJex7xCUK4kDX7XD1wHs+r9L2gU+g3HOH68C+lPaXzGDK8nXEKoZtuYPBpvDvB436P12VC+jSvRWDfwaPk2TXacW+Y9GUijLiuzuS+ckhpTi0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YVe5S82I; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YVe5S82I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783553886; x=1815089886;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=KDoVhBW1wzuMLqkBYbaC+7FWzi+GGgd3FX8HQmTBYWU=;
  b=YVe5S82IWxccwRQf4IzCIsKbfN5X1TEq099AaKWmKXZaoIY5FEWoKEbr
   fI9ux+RxAQfMJKs7Qcec6AOtDnAPbylkpwE6hbONZViX6QJdRk5IY62o8
   v9hJYjcKy0RV37EOnL/Q9e/XoWCuCegGjB3Tmi8Ftlf9Y2ihFn9zaKa0n
   jhEiSdzL4U2w0I6+YFCZ2cjPs4E1TSiGRM5Q33DToG4AFvHUFxSvrgze7
   /GMB/rLGLh+Hrru7Qx9B5eYl7O8L8HvL9bLIXnHqSJkKUjINkEk9+Dmm2
   ywqU576+0RmxENjD1ALyvwO3N8kxGhX78tb8v2MyP8RfhmJ46NLfjLQ+1
   w==;
X-CSE-ConnectionGUID: e0RN9FkcSWu59KdjDnorCA==
X-CSE-MsgGUID: sPV/153zTJS2h2ZLWppKQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="88053710"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="88053710"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 16:38:05 -0700
X-CSE-ConnectionGUID: yUyv03X1Q6SBSUWYUoLIyg==
X-CSE-MsgGUID: FGDPAQ/PSAGpheVwxPexKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="253331271"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 16:38:05 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 8 Jul 2026 16:38:04 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 8 Jul 2026 16:38:04 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.40) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 8 Jul 2026 16:38:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OuQgbbFx/zbaYmlBA6QLxORBW9I20gNBQgbUpii4K3CX+//esliNBR6zA2uKmaXKxaLjxIx6x3o2M6XiQ+k8xBGn7N5OC7JZMBLfC7avEQL1s/ZcP9HdWRPLQ0+HjgM7fqT4dKan3qJapzFnphTjCiV/ffy92gea+3Yi2MUEuLte2arRnIofdAijop9/uPFW+vyMmy0JRBIoHhiIg9k1Gi2F/INq2SE/Hqqj5q2R3y0k1WpdPzLZ8LQr/b4hPB00it0dX1KqjUCwIJG8mqukkbKSMZA14IgsPAL4Bblrb4hCYusIQrl7YDCKS8awF0p5Arxf6cGBUP1Ub73G0Istxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KDoVhBW1wzuMLqkBYbaC+7FWzi+GGgd3FX8HQmTBYWU=;
 b=OnjRRLvjuaPWDyPKfP1cHXhm+dav67Lq2mhL6Wwx/9MHufZ+eK//dfH3+Q8SERrUwAR+N+GEessRrdQoq4Yc2vS+BOvIXYQzG/tIiKIA09qogkUqJiHVHso2PnFsUrhKAvypjZhMOEhvJC2EAFkQV8jkB5cOAXGo4kmJerZIKsSjPKkJdstNpIvL9rA2bXT1qtla781ZC5yUwUZA3hsB66/Dr8IT9wauKq6E7dO/eEytdvW8+Oy+Vzy7tFGbVyJvV1bUQKgTM9U5zXeTzE1ib2oD4c2SUphFuKMdPQZ3IctlIIjl7FQUMwf4JvQjF4C1hvqil5h0osAwU6Pkrr5enQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB6776.namprd11.prod.outlook.com (2603:10b6:806:263::21)
 by PH3PPFF1A08ABF9.namprd11.prod.outlook.com (2603:10b6:518:1::d5f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Wed, 8 Jul
 2026 23:38:01 +0000
Received: from SN7PR11MB6776.namprd11.prod.outlook.com
 ([fe80::9c32:5b6b:3a48:dfa1]) by SN7PR11MB6776.namprd11.prod.outlook.com
 ([fe80::9c32:5b6b:3a48:dfa1%6]) with mapi id 15.21.0181.008; Wed, 8 Jul 2026
 23:38:01 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "seanjc@google.com" <seanjc@google.com>, "Fang, Peter"
	<peter.fang@intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Li, Xiaoyao" <xiaoyao.li@intel.com>, "Hansen,
 Dave" <dave.hansen@intel.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "Hunter, Adrian" <adrian.hunter@intel.com>,
	"kas@kernel.org" <kas@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Xu, Yilun" <yilun.xu@intel.com>,
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>, "Mehta,
 Sohil" <sohil.mehta@intel.com>, "djbw@kernel.org" <djbw@kernel.org>, "Duan,
 Zhenzhong" <zhenzhong.duan@intel.com>, "Maloor, Kishen"
	<kishen.maloor@intel.com>, "yilun.xu@linux.intel.com"
	<yilun.xu@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v2 16/17] KVM: TDX: Add in-kernel Quote generation
Thread-Topic: [PATCH v2 16/17] KVM: TDX: Add in-kernel Quote generation
Thread-Index: AQHc/v4hZvKBjyrt6EaJpy4HaHV03LZPm3EAgAXDgoCAAPWbAIABfw0AgAAOb4CAAR0dgIAAF2IAgAPbnwCAA/GkgIADVDOAgAAW2ICAAAVzgIAAE1kA
Date: Wed, 8 Jul 2026 23:38:01 +0000
Message-ID: <fcaaf27b3ea5091b712119ace068a99d13b4e1cb.camel@intel.com>
References: <20260629100301.GA1743876@pedri> <akMQ3J6fK3DUBsPH@google.com>
	 <23a9173f6e278ca7dfedce3374626c6ea3e1b47a.camel@intel.com>
	 <6a445e4be6b12_3a3568100db@djbw-dev.notmuch> <akVNdxCzk-n4bgMv@google.com>
	 <9df36c49e6be69dd9eece71f70a404a84b1563ab.camel@intel.com>
	 <20260704054342.GB2169894@pedri> <akvsgVjwb00P1EuA@google.com>
	 <08c9bf2f-75be-4244-b99c-153ec1f604ca@intel.com>
	 <20260708220915.GI2169894@pedri> <ak7PHTGEuxAZCvXw@google.com>
In-Reply-To: <ak7PHTGEuxAZCvXw@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB6776:EE_|PH3PPFF1A08ABF9:EE_
x-ms-office365-filtering-correlation-id: ffe11eb0-b4d2-4fc3-1a81-08dedd49f340
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|23010399003|7416014|366016|1800799024|38070700021|11063799006|56012099006|4143699003|18002099003|22082099003|3023799007;
x-microsoft-antispam-message-info: gkbOXiuYLGFUTrNr6bpS+1NyL/StUgDKiepIg6IJNixPlMx+F8pZavwsRMw+Xji29OrzInMeW6iCutxlzIeSqe7wJE02il4R8CU+aZYNa3RTocjebkoRSJ1pW0HS14Y+3U0wv4D0S1mpsRg5Z2015CYj6nOXx8tGOVz+R4tH7ttialPNqPQ+x8j57PYcY6LjMA3TP16z4gKvcA5pK3UnxYTyveSQwDdIoA0r/vmWCuqsVheumXGCx8K432ISvG2ME9IjA7sqhQfv+R3ULd7xEDKjA7ErOHqwzNRnx2EzJG6CZx+sVbrNaGeRYlbAawvmQWt0dyaP8fBUyF0U8Fs/6Z8j3LjSwKhnp1Du8JwCzEUjaJJ4DafA11ltatx323j0aOk2S8+bQrW/QG7JrT9k9BPz8ipvwPXFSZ/tFG7j4mJBfT8H+3YldvpozRu4tk2lM/F8+nYA5PP0CGGxi0omwWz7a4YciRi1Kbhth7OvUNDt9AbvAfpmOIDfJ0MFgXWs4zzIFA10X1NjVVNHl0Hk0PhN9zkahf+uFBjIcH92nkRC5dcXQUG3VDj6BiH3uKXLWWqqcQAIJEeHZLWJ1jp/JR8N96RlmsordH7Va4MXmePk/15XtyKVgP8hX1i8+hMXq6YMOBn3mdr9mept19bYifd0ci1jobMBIU50GPJ7x804oXCiMYQxq3bQPvKV40axzTOSgQXLmf/4cBYfagTXYxohor49u8VhG/qVcgFtp8A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB6776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(366016)(1800799024)(38070700021)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SVd5WlAzOWYyTHZHTStMNWNhc2ZZU1hiWTc4cjc0bjV5TEEvWjVqd2MzR2xQ?=
 =?utf-8?B?cFF0KzJzcXkxaENtZ0ZIeXVoLzgvWUkrZFFlakdNdVNxcmxwVW9qM2xoQ0ND?=
 =?utf-8?B?VkgwbEhvZU1FYWdXY3pkQ0xaTGZDYTZlcVZQK3dvM0xyNjJaN3FoQ09vZWN6?=
 =?utf-8?B?bkpsb05pM2JkZGoybHJVY2ZKb0pKd05VMHlUeDg3RXlHU211ZEFPRDlGc2N5?=
 =?utf-8?B?dk02YTFacE9lQjlPbnZ1bEZ6eXBaYm5nZWJKRjBUMkNQbU5nd3Nwd0V2Sjl3?=
 =?utf-8?B?aHpJcFE5R2I3SFNiVEtTdHBTVVhkVHdON0hadjNqZ1A0OU1SRUFHL3dzWXd3?=
 =?utf-8?B?V1dYOWppa2tSYTZjYkZ6SWpNN1R1NFpUekxsRkNYNWRUd3dlaFVwM2F5anJW?=
 =?utf-8?B?TjJIWnp5elBhSXkwaEZZZitIRjlKVlQ2UjZPdEEzb3U2dEFyWVgzVWp1Z3Rv?=
 =?utf-8?B?b3JmTnF6ZFlPaVBFb1g2R1JIYVUzeWxVYVkvbW9EUGpvdUh5UXhycEhYaU5O?=
 =?utf-8?B?M3NyVjF2bThRd3d6MEZrUWhlZWlXQkY3WnhkNFlJMjZTUHVWdVBZM3dwZisr?=
 =?utf-8?B?R2wzL1d5MXFqcW5mdytjZjRQamRYNlFhTDFXQ09tSHZNYXVwaHlyTWpOSXRE?=
 =?utf-8?B?aEpyRHNka21oL00yclJ6NVlBU0N6cWxqUm4weHBuQVRTWWd0QXIvbkoyMXF5?=
 =?utf-8?B?SVZpMVYwMDRZVHBVOThyYmk3TVozcGViWnZad2Q0c2lpa2hFZUxjMFQwbEMv?=
 =?utf-8?B?UENKNWtZdHluaktIVHFzc2toNlR6ZUtlZ1B5SmtPUGtlcHBIZ0c5ZWJ4akRS?=
 =?utf-8?B?d1E1aXVCemluZjNZdG91SG1MSkxmdXZ1cnlSNVFoMFY2UlM2cGNHdlY4V1JR?=
 =?utf-8?B?ZG9pMXhmSUdRYW11TEY5RnBxblFMVUppNURmL3BMZE9LNkNJTHQ1NTZSQUF4?=
 =?utf-8?B?R0UzdDNyQTdiRUxQT0JJSFEySVd1bklkWXVTL21oK00wUVJhS0RLRC9FbVJy?=
 =?utf-8?B?TmU1dGdJMVY5S1JadnJjV0wvVC9qcnJtNkg2WmlobE1KeGV4Si9TelQ5L01E?=
 =?utf-8?B?WDFTZkFwbUdMRkxIN1JJcm5SYzBKZGp0cU01MjV1a2Z0Ukl5aUl4NG9zUkp3?=
 =?utf-8?B?cFBzZVUwV1lnOExrREEzQkNZRzJtT1liYitjelNoaDFWMENrMGZqNmNiUWNv?=
 =?utf-8?B?dEVTQ085Mk1uYjVpMEZiK01DK2kvaTFTVm9XMlBhL2lDckZtalRja3hQQnRJ?=
 =?utf-8?B?WFZtb29xOERtNUN0cis0cUJwNXlJRTUwWWtlMFpBYlhzbkVPZkViWXljOStk?=
 =?utf-8?B?a2JuT0hkUUdxUnA0bGFjTmcxY0VSVnZyZm8vbWhUcU1WSUdEYTQzZEdCMUZ2?=
 =?utf-8?B?QWV3WTdLakVWekRic01kUjVhc1BtbXRRRUozVWNEQUF1Q1pnWW4yVndoclZR?=
 =?utf-8?B?U0JkYXZaYWZsTGJ4NnVHN3BKRXhISlArRXJXNWVrSDQzbkxRQjZZZUNnMnk0?=
 =?utf-8?B?bmVKU053WmIxck9ON0FVL255N0pqYVc4U2k2TlY2K1FxTDB1WVpuV1o2NkJ0?=
 =?utf-8?B?TjZXeHBrNzIrMEVyUjdSNkx1YUY0YnZuN1FBcHFIMHp4bFdpUUFrRWt4bTVW?=
 =?utf-8?B?cmVJaDVlcWlQYXBQV2JZVjJxZHUvcENMUy81ZGNBQnRxS2ZpeUdKTlkvS3Mx?=
 =?utf-8?B?TjhhUzdMQnVhSVVoSklYelNGRk80MUpqTEFZdEdqQzhwUmdCWVBJNTVjRmxl?=
 =?utf-8?B?bmV5bnZWYWVtUU5CWmtRSVhzbGxXSm56SGFhN04vZFJtU3ZTN2NMTFRpWU8w?=
 =?utf-8?B?djFZVE93c2ZmQlhITFo1ckJGRVBEQVJLdWdtTXJpOVBmUndYRG9hZE55RVYw?=
 =?utf-8?B?ZmV6SDBTVkJxVThLelZINC9MSmlHQ3dqZVZyZGEvMjYrRGFsVVVsQ2RzUU5y?=
 =?utf-8?B?KzA2L2F4TU4vc2tOa2R5aEN2STVwbU04cmZhaXlscFo3aW02MFl6cHJJckd3?=
 =?utf-8?B?V1hBdVdzWlVxOGpIblEzU0xFOXZVQ2lQN2IxL3RkOU81UjJnV0R5SVk1b1M0?=
 =?utf-8?B?ZHBpcEh1SEt4NEpVeGdueWtYc2lqOW8xdFlVY3hvRWRnZ3Z3RXBzN3hPZTlr?=
 =?utf-8?B?OHd3Nm9Oc3RtUmxEYU5xZ0xSSU0zN0w1eW1rMWZId3J4S2lmY00zVDRXdk5V?=
 =?utf-8?B?ZW1QSWFqY1RTUWJJeFFNMmJ6TGIrWGtxeWNBcHgxNkVVenNraTFDbS8rcFdT?=
 =?utf-8?B?VVhabWhid1l6LzdUbDQyZmRSeFd1Rzh4ZG52c21aMElld1V1WnlkeU5QZ2xz?=
 =?utf-8?B?QmNpVDNaQTRCaDZlZ3BGTlNDNVd2Ung4UTVGdW50S2RwV0kzdFM2emh3RzM3?=
 =?utf-8?Q?3JVOPJreq6iG7bPM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FE34F4D7451B5C4DA17474527D702F9E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: QQ5GrXY84Ow1aV5cX+wXfYS+u9eVxJeKi6D8ewRfjgYUOtYmA7TECRqmdJ4XszxIhJFT+bRNKNgTWP9naNny6VYWkBTiAGhhlyzshpxgfvK5PKxdoeL/XS0rckeFmpyBHJFaiZ5s96DugpqcQsW3D2Q/CKlNVLJ0FdjxxZ3kIjUV6/03ECNbRZmQkvHshEbmHl/DWJw50RuNWlWZK3pe5U6HJcf8Haf3xy2mETmzAdxWnG39+27wuGzWlJM+/IyOAU/1SBrGZjyixpaMUiBess0rlHMQ1HwnaCYAvwQBZFgoXJYWVEbOcMQwxW1S9zGSBVY7RI9R5BJtJlFPrePRdQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB6776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffe11eb0-b4d2-4fc3-1a81-08dedd49f340
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2026 23:38:01.6483
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XqXox2tI7N2j3mm3pRY/qx+NSlq2L7vXX3hhpkiOY/XU1Dw7YctA8SXV9WZ4bAdmZ1Mesx7m+TakL4Lmay2REldL5uzB1neQMIL1Wnt1Kxo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFF1A08ABF9
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTA3LTA4IGF0IDE1OjI4IC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiA+IEknbGwganVzdCBhZGQgdGhhdCB0aGlzIGRlc2lnbiBkZWNpc2lvbiBjb21lcyBm
cm9tIHRoZSBmYWN0IHRoYXQgd2UncmUNCj4gPiBsb29raW5nIGF0IGRpZmZlcmVudCBraW5kcyBv
ZiBmdXR1cmUgYXR0ZXN0YXRpb24gc3R1ZmYuIFNvbWUgb2YgaXQgaXMNCj4gPiBxdWl0ZSBjb21w
bGV4IChsaWtlIHBvc3QtcXVhbnR1bSBjcnlwdG8pLiBTb21lIG9mIGl0IG1heSBldmVuIHJlcXVp
cmUNCj4gPiBtb3JlIGNvbXBsaWNhdGVkIGludGVyYWN0aW9ucyB3aXRoIHRoZSBTM00uIEhpZGlu
ZyB0aGVzZSBkZXRhaWxzIGFsbG93cw0KPiA+IGFsbCB0aGlzIGNyeXB0byBzdHVmZiB0byBsb29r
IGxpa2UganVzdCBhbm90aGVyIFREWCBtb2R1bGUgcmVsZWFzZS4NCj4gDQo+IElNTywgdGhhdCdz
IG5vdCBhIGdvb2QgdGhpbmcuwqAgQnVyeWluZyBtb3JlIGNvZGUgYW5kIG1vcmUgY29tcGxleGl0
eSBpbiB3aGF0DQo+IGlzIHN1cHBvc2VkIHRvIGJlIGEgbWluaW1hbCBUQ0IgZG9lc24ndCBzZWVt
IGxpa2UgYSAid2luIi7CoCBJIGNhbiBjZXJ0YWlubHkNCj4gYXBwcmVjaWF0ZSB0aGF0IGludGVy
YWN0aW5nIHdpdGggdGhlIFMzTSBtaWNyb2NvbnRyb2xsZXIgaXNuJ3Qgc29tZXRoaW5nIHdlDQo+
IHdhbnQgaW4gS1ZNLCBidXQgdGhhdCdzIHdoeSBkcml2ZXJzLyBleGlzdHMuDQoNClRoaXMgaXMg
YW4gaW50ZXJlc3RpbmcgdGFrZSBhbmQgbWFrZXMgbWUgdGhpbmsgZXZlbiBtb3JlIHRoYXQgd2Ug
bmVlZCB0byBiZQ0Kc29jaWFsaXppbmcgdGhlIFREWCBhcmNoIHN0dWZmIGEgbG90IG1vcmUuDQoN
Cj4gDQo+ID4gVGhlIGhvc3Qga2VybmVsIHNob3VsZG4ndCBiZSBidXJkZW5lZCB3aXRoIGF0dGVz
dGF0aW9uIGludHJpY2FjaWVzLCANCj4gDQo+IE9oLCBidXQgdGhlIGtlcm5lbCBoYXMgdG8gYmUs
IGF0IGxlYXN0IHRvIHRoZSBwb2ludCB3aGVyZSB0aGUga2VybmVsIGhhcw0KPiBlbm91Z2ggaW5m
b3JtYXRpb24gdG8gZ3VhcmFudGVlIGJhY2t3YXJkcyBjb21wYXRpYmlsaXR5LCBlbnVtZXJhdGUg
Y2hvaWNlcywNCj4gZXRjLsKgIElmIHlvdSdyZSBzYXlpbmcgdGhhdCB0aGUgVERYIG1vZHVsZSB3
aWxsIGFsd2F5cyBnZW5lcmF0ZSByZXBvcnRzIHRoYXQNCj4gYXJlIGNvbXBhdGlibGUgYWNyb3Nz
IFREWCBNb2R1bGUgdXBkYXRlcywgdGhlbiB3ZSBwcm9iYWJseSBkb24ndCBoYXZlIGFueXRoaW5n
DQo+IHRvIHdvcnJ5IGFib3V0LCBidXQgaXQgc2VlbXMgdW5saWtlbHkgZXZlcnl0aGluZyBjYW4g
SnVzdCBXb3JrIHdoaWxlIGFsc28NCj4gdXBkYXRpbmcgdGhlIGNvcmUgY3J5cHRvIGFsZ29yaXRo
bXMgYW5kIHdoYXRub3QuDQoNClRoZXJlIGFyZSBhYnNvbHV0ZWx5IHNvbWUgQUJJIHNlbnNpdGl2
aXR5IGhlcmUgdGhhdCBuZWVkIHRvIGJlIGNvbnNpZGVyZWQsIGFuZA0KdW5mb3J0dW5hdGVseSB0
aGUgYW5hbHlzaXMgZnJvbSB0aGUgaW50ZXJuYWwgZGViYXRlcyBkaWQgbm90IG1ha2UgaW50byB0
aGUNCnB1YmxpYyBwcmVzZW50YXRpb24gb2YgdGhlIGZlYXR1cmUuIEluIGZhY3QgdGhlIHdob2xl
IERJQ0UgcGFydCBvZiB0aGlzIHNlcmllcw0KaXMgbWlzc2luZyBhIGxvdCBvZiBuZWVkZWQgY29u
dGV4dC4NCg0KSSB0aGluayBJIG1lbnRpb25lZCB0aGF0IHdlIHdhbnQgdG8gY29tZSB0byB0YWxr
IGFib3V0IG1pZ3JhdGlvbiBpbiBQVUNLLCBpdA0KbWlnaHQgaGVscCB0byBicmluZyB0aGlzIG9u
ZSBpbiB0b28uIERlc3BpdGUgYmVpbmcgc21hbGwsIGl0IGFjdHVhbGx5IHRvb2sgcXVpdGUNCmEg
Yml0IGZvciB1cyB0byB3cmFwIG91ciBoZWFkcyBhcm91bmQgaXQuIFdvdWxkIHlvdSB3YW50IHRv
IHRyeSB0aGF0PyBPciB3ZQ0KY291bGQgZmlsbCBvdXQgdGhlIGxvZ3MgYW5kIGNvdmVybGV0dGVy
IGluIHYzLiBPciB3ZSBjb3VsZCBqdXN0IHRyeSB0byBzbG93bHkNCndhbGsgdGhyb3VnaCBpdCBh
bGwgaGVyZS4gSSB3YXMgdGhpbmtpbmcgYSBjYWxsIG1heSBzaG9ydGVuIHRoZSBsb29wcy4NCg==
