Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FF2457E56;
	Thu, 10 Sep 2026 21:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789075788; cv=fail; b=njdc7Z0sdiaESv7n1/kqau6ZIKQyvksYuvILacWAVpNul1Aq6eWu3kV55tKSN9KFijXLfPBVpr3x+3yAXMYINS+nEbU+qBHJweWTg5mK7XAQ2MrWderqgr0lRpiNc781jAIpvYhS8ngQSl9ufajiK9XrJU+tj8CNHLeHZLABVtY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789075788; c=relaxed/simple;
	bh=WwVWnBnU7yddWm096gdFp+QG3G8Z8VGtRWbdO7sPT9k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HZUde7twTFXEB9BsOPlQxzAo2p05aCaq+JFmnfd5+LcbSpDKfVAtxvFJ/K/u3sl0hS4FuL2ROnPj1+jlMU/M08GkAaEraX5ahngmTZ+Azsb2BFfc7zkyn/vjYXXkpJ9aUmI+dekN6Taxb8eey8rr9Wx6i0h0x1+9dSSw8ITZHX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZNdiqIlF; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZNdiqIlF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789075786; x=1820611786;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=WwVWnBnU7yddWm096gdFp+QG3G8Z8VGtRWbdO7sPT9k=;
  b=ZNdiqIlFH8fSWZRPn/nYMCg4ASLht3t5OoIEvL8A2K5CEQvvTjiRaZ6w
   7DWy81OZZKUlQzR6ZNAJGFBfg9aKWoPA2pkCdVDWJUm/y38wzjezoNhcm
   tfJiw+Ge43NxwfWCRgAk6NIqc5H/xMwUoPcoBMVq1lZWgI1KkmvjJn00I
   bJcuh4kv27dR8zyz49rPxSzpaFQKYuLWLqXvVBlLVO/eQHmF/0ZEQ0lMB
   shGMsZb3i+s2Cm71DW1rn2GcvcLUSoNxiYI3iLZWJyfHWrubNAO9dI0ku
   Eh4NalOlks9KvxJ2DJNZGCdQkEygS7NTQ/It+eR9sOcGQWW5IPlZmm2Ej
   Q==;
X-CSE-ConnectionGUID: S01PZoUJSrSLA2SqQf19Gg==
X-CSE-MsgGUID: b8LQcY1wRcKopTOIM1gJwg==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="89749769"
X-IronPort-AV: E=Sophos;i="6.27,96,1787036400"; 
   d="scan'208";a="89749769"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2026 14:29:46 -0700
X-CSE-ConnectionGUID: n3cUOAxlQxyMZb8zDI2sgg==
X-CSE-MsgGUID: dl7IS6NyTQqmIz9vW8eOkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,96,1787036400"; 
   d="scan'208";a="275898711"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2026 14:29:46 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 10 Sep 2026 14:29:45 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 10 Sep 2026 14:29:45 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.16) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 10 Sep 2026 14:29:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ojbcQbVjYBd3M/0r12QLYyTkVUXPpYmU10EN0NWVKP7d1F/lSUdYCjZ1AleI7ksLPrVndp7GVxLTktm1fKbICetD8s6CQBqDtHUhpCe1yN93lFKnHl91GcyKCxnZP+6ZBSFWDGQZtzxp/jKoAmdCA6W0Pr9GuyWBPRwMOhVvK6mZxUIK9o8j9lZhW01aC2zXondN9A6pi/Vhr6X/4cL7M7K3rmoYnZdDN6pNfdNmS0POvmmziQR9Bp5R3GaELoJSs4WkcmO67wTiy3E6t7V2ATk0YIJWWL7o9l+2zHw2BTwyu2AY65oH2MZHmVsPueMB+27DfOG/HpVsxf0jyNczAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WwVWnBnU7yddWm096gdFp+QG3G8Z8VGtRWbdO7sPT9k=;
 b=Qzmx32X77HWHqwUsLhUBVkVuadWGucqiZGW/R5xuZ01mjoHSeeb2nSbwQiFnIZbrkYRutV5Q99a1Ba7tN9G0yrfVFjWOZqmOekOjPWdh0ksEOa2Jp5ukEbTr4gLIa+Cw07KddVyojpSBzf08dMPjRFb3udMbZc/JBujnLjBSmmB8Xk1A233v4G66g7hdhQP4uAzDnpOql2c+KgGalsCv4v17yDDX3PonrPpQjGQ0HYBSFHaKj8ifLu4NXbOYmN8Pz4xP/2pYRAPzGs4hw9iuO6oq4WDm7ZRxfZZ8cuObBddNbtzXe3fO0UhgES42qqhU+R5Z8NpEiSxakjgFkPwiQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by PH0PR11MB4951.namprd11.prod.outlook.com (2603:10b6:510:43::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 21:29:43 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 21:29:43 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Li, Xiaoyao" <xiaoyao.li@intel.com>, "seanjc@google.com"
	<seanjc@google.com>, "binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>
CC: "Gao, Chao" <chao.gao@intel.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "kas@kernel.org" <kas@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "nik.borisov@suse.com" <nik.borisov@suse.com>,
	"andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>
Subject: Re: [PATCH v3 1/4] KVM: TDX: Track configurable CPUID bits allowed by
 KVM
Thread-Topic: [PATCH v3 1/4] KVM: TDX: Track configurable CPUID bits allowed
 by KVM
Thread-Index: AQHdNdIg5EuCH7XFUE6a3Q+aSzpVqra50omAgACnLQCAAPSngIAAE6YAgAD+CICACMIfgIABRb2AgABhxwCAAA2YgIAAODeAgAE72YA=
Date: Thu, 10 Sep 2026 21:29:43 +0000
Message-ID: <18b2e611bf1d166dde6e27a68719fa5053151af6.camel@intel.com>
References: <20260827031837.2863609-1-binbin.wu@linux.intel.com>
	 <20260827031837.2863609-2-binbin.wu@linux.intel.com>
	 <55488b92-66a8-45e5-ad0f-8fed63ce1187@intel.com>
	 <a30741f8-b99b-4f36-80a5-4688c2578d99@linux.intel.com>
	 <6b565572-b316-4e86-906d-f150c896fe21@intel.com>
	 <84891108-55be-48c1-9993-c730a5334d5b@linux.intel.com>
	 <cfe57e67-49ce-47d7-b20b-a29e23fe16d4@intel.com>
	 <d8012e9acbe3c733b082c87fdbe9f229a8f7750c.camel@intel.com>
	 <9abeed40-bcdc-48d9-8cbb-cb87154bb9f6@intel.com>
	 <aqHdwkOFVR4XoS2M@google.com>
	 <c967dc3eb6b128055e415bae45d1c14a52dc4acd.camel@intel.com>
	 <ac43e7f1-2ee3-41a4-85ff-edab7a7caa35@linux.intel.com>
In-Reply-To: <ac43e7f1-2ee3-41a4-85ff-edab7a7caa35@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|PH0PR11MB4951:EE_
x-ms-office365-filtering-correlation-id: 079ffbff-9427-4dda-4759-08df0f82a12b
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|56012099006|6133799003|4143699003|10067099003|11063799006|38070700021|18002099003|22082099003;
x-microsoft-antispam-message-info: OwxwXKGsZHwTy75c01gncV4UJ7eZ1ww9gV9CHmn9rHyZWusldrtLtawmK3rQtntjdfCqEdG23RgWKWvrEXIr2LszubnZY5R8J0edwima0veGH1Esy3Bt16w7mLjtHD525DahF5d+VuXkW2fMyB/4b3SzYCmSo8hRM19UmO7741lbcDpUO8S74b1WhkIbd/53c35jhx3dUw3Q0i3hiKG+1vZFAwAfmmeWKSiKvJC6LqPbaB1q4oMk76ZkLQF0UkZhvtgYVV/lhYjgSdHxvGZhJRXt6ookCD9aB0PuUxsNsf+vmXmy0LQR4eM/rw3S46PgKB2hxP02QJCZ98+qtswhOO0Sw8YrQ/o6iycuG2ZD4zFYyh2bmx/PLq2tLsYUu9DBCQEgqNxBhJdpGfL+Zpw/+bZuVDQD6BplMqYWbdpepBqq69NvYgxG+wbMz3G4DVr45ES66VlarD2BSy/xZQ47MKwuhZ4jCCRa57WwLJ/zG8vVY0OhQ3fRii2SI6F1fnTJbkkuv3kkYTm7QROnm6S2rkOg5vEZZ4tsI1bkzoAxJbF9hlpDWtvGhPFC2BHbHKlZkDw44iPmjJ/E69Lxf6cv9pSF9n9PkcrPefZiJa1qSmSDZnxx8BKUIyluyem4vMurMZmcxqtaT5iMAxfB7aWNLY2cvkRlAM0bTWbMEUyTA1cVD0QR2hYki0ySSDl9QJeJy/SJEjN59Zx93oITxWvek+aYGEXsC1BjpEZZoRcD/es=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(56012099006)(6133799003)(4143699003)(10067099003)(11063799006)(38070700021)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WlhsVU5id3RLaTl2TnBHSHBsVHQydmNKY2ZJd1BZdTV0LzRWSkRKS0ZqOWlD?=
 =?utf-8?B?dEVBMWxzRDk1clV1ZlRmTzkxOHJsUS9KaC9ZeGdkNXdaeDdmekFaQXNYTTd0?=
 =?utf-8?B?WFcxeWppb2NSQzhkdEF0M0NSc3JYZ09lTlcvZm52SGFxV3hVWHdCS2h2OGRB?=
 =?utf-8?B?U0NIN0ZDK3RxUjdJYzRPWnoyUUNMYit6MEQ5RDNGY1R1ZnBmYkZaejNrT3VP?=
 =?utf-8?B?cUNOejMvdENFS2piL2hVbUVZNDhnWGRmZ0Q2R3kzaFN3TGphZHRoakJEYWxS?=
 =?utf-8?B?eU1MT2pKdS9pMk1SU2lCNThMVWpSQVhrdFUzU1FJVExhcUtCUjZ4eDlJTUpS?=
 =?utf-8?B?VmV6RkQ2RFc2RTl1OFVXZHJVUDl1VjFUUXNMSXBxbkRCbWVVbVNZb1RXSEU3?=
 =?utf-8?B?UnNhNC9iNUhxdjZNNUNDaHRyWEdBaUVUWEttdXVJdXNGb0JUR29KT2FKVS9m?=
 =?utf-8?B?SkJJUnB4V1VJVVB6UlBHN2l0eGZJdHI1VjV0WkJFODNQVTBhR3I5eno3YUsv?=
 =?utf-8?B?QWVZbzBCME5QaGw1ZDFQR3pqTTZsRU5TK2hYM3BRSm9UQ0w0ZE9zamhsdFRT?=
 =?utf-8?B?eDhwRVVOa0VVYndlTkhha3c1TG4xdy9OR1NUMDI0b2ROMXlJZVNiNkg3RVpX?=
 =?utf-8?B?d3U2dC8zS1dWays5WE1mb2VDQncxUmUwR0JnWjlkNFNGUVJDNDRiUWx6NzZp?=
 =?utf-8?B?b0FKejNRUmNMbHErZDVGVFhhQ2lpVUx1OG5PNlVMSEd2Q2NFM3F6MFRlblZD?=
 =?utf-8?B?cWVLdzFKUloyR21kT2tKTmtXQU9sL2VxdFJiaGgwT3lUc05GUUw2QnprYk03?=
 =?utf-8?B?Umw5UjNudTRzbjBHWGRKZE1mQlpFZERqR0IxdzhjQnQxSDdUdUR6aW9xbzF2?=
 =?utf-8?B?YWppUkRwa20wZHdkK3dXeGoyVmlXMFFFYW9HMXJXRytyRWpOUEZzaXdvZk1Q?=
 =?utf-8?B?RnpaL1d6a3kyZ1FRUkVmNG10WTJrRHdIellsQlhFTkVKSXlyQUU1djdmdzlk?=
 =?utf-8?B?dXBQd040Wm1leVNCalVwczByVzYzVFJKbEIzWjM4emszRDk2QXJFdVVQZW1D?=
 =?utf-8?B?bGtaYmw2VkxaakRFR0s1ZzJ6ZHc0aTFUcXhvamYrMkN4WlZ4RHN2YmlPUzFK?=
 =?utf-8?B?aEh6dkNFZzEvRlh5NWw2UURnUkFXUlUveHpKTVFzeTJDOXhGUENkN1BWQTJo?=
 =?utf-8?B?eExDVVRXczdtdWc5UGlSYzFFa2NhUXo0V1ZGQlk3NVRKWFpRc1I4QVhrMzQw?=
 =?utf-8?B?eHJEYTNadVRqV1NvaE9wTU5BZitRM1BaVkNFMGpCUDdEMnVNL2FubVExbExN?=
 =?utf-8?B?T0xUcm5yRUFiTWE5aEI2UDRpWHQ0VitVUUNnbDR5cldYemMwNzBMUzZSb0lJ?=
 =?utf-8?B?bHVaSGpoeUZSbDNtU0xZalloYmdLQVg2TFlRODVHQzRzMERHRE1kQS9PK0JC?=
 =?utf-8?B?Wis0bzlrSkx3azZOQzFodG5tTEZrWjUyWVBtbDdLRmFxMml1L0U0WnhPRmNq?=
 =?utf-8?B?dXZIcGtVRkppZmw2K0J4NjRyOVgwdnNFNzV4TGRCNytxVUZhYmlEa0k3Qm1h?=
 =?utf-8?B?eHZWZGRnODhOMjVzcWg0cEw5VTVHbUErNkhUeXVDWWQwSkxQLzNrSVNaTDNU?=
 =?utf-8?B?K2xsWXpWZDYrZWp6MWNsZ0lQc1FSYmRBbk5xT3NwdWdIMDhUVzRJeG5ENTM3?=
 =?utf-8?B?d09DZTFBZTU0ZWpIcGgyNDcwOWlyMzRzRzZNY3RXSzVjSS9wRTk3VU1nTFpD?=
 =?utf-8?B?bUFxTHpSdXdrWTZXVEViMXBrQk9PWGtuN29qcEViMEZzMTJpd3FWYlVScXEr?=
 =?utf-8?B?WUZmSE9OUWs4c2FwcVN1UW94dmh3Z0VSd2JPU09xY0RMaUE1YVdWZ3dUZ0ts?=
 =?utf-8?B?OVhnR3hiZUNYZ05Pay8wdUQ1MWl6UVF1dFZabGVnU2RFYXNjb2RTY2RFSlND?=
 =?utf-8?B?ZjczZldmMlczVXJHeS90c3hRVnZlL0UvbXV6TFh0cUVmc2tuZzRuK2QxY1Uz?=
 =?utf-8?B?M0pCRnZ3S0ovNkFSYU1nZExpWlRtaTN2Mk44MG52TkRZVmc5QW1yYnJXZjd1?=
 =?utf-8?B?Z1p1d3grZzQ2MHUxZGJUNW1LM3poMDZMZHFmTXgzU0tyTlQ4R2RtWmlMdW1N?=
 =?utf-8?B?UFJiRGd0b1BRS2J5K29LdS9ZUUdibnlkdTB4QWNxTWoyYXFJcnBqZGNIVGRQ?=
 =?utf-8?B?ZVdtZVlqMitLUDJZQ2xzdTExc1RhZ3hlOTJJcEoxRUNkSkRsU01McDlRQlpB?=
 =?utf-8?B?RjFjUWsxbGt1M3NJUGFQcFJ6SllQWFFzYkZENDNXMnI0ekZ3c0RrOXJmeUZE?=
 =?utf-8?B?MG1YRDByQzM4ZTZXVjRHSVNXSFVUZDAvc0R0N3B5WmdMZHFTOG1CU0lmMlVz?=
 =?utf-8?Q?XAW98OCvz5/I7iok=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4185FA69219D724C9E03203AB6111245@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: v1wAG6VtO1HyV0we0h71oOUj2iSKps9ZvtQVMz++jYsQUTvBts4+PivtO8Wc1xj9Dnt6rICVR8rI/M7qLprEPPX7OGNrmJWSqJa0czSfIDK3FHc58iiMaizY7fYt/I0BE1aRaVEwc2uosZTQzFyb0ZfwL/2PFZvtBfvQ5v2zZEZcFLdR4sy6gnNTZODFkbQvoAmXhd0mJ93vXifAJfrD5yAwY347Qf8aceeiPwMfJ12C7HXELkF+QUGPigoJ4qKTmwRI8GQv7K7RrqPavHWdYxYH3txlWzZd1sZiWVdOTGcQAu1WwJk6gwI4ZHZPOXBc9Cf29ubs/6/H7rUKmecGlg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 079ffbff-9427-4dda-4759-08df0f82a12b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2026 21:29:43.3153
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y+FAOAkouAj6E05NWZbMcJA+xspDt2F0lr9gHrIXQ1WCSOJ5juWDLU5IPVpvH3Phb0/JI3EFHDRjRQTQlyPDMdXi+2o47FhIlTQvM9P6NM8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4951
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI2LTA5LTEwIGF0IDEwOjM5ICswODAwLCBCaW5iaW4gV3Ugd3JvdGU6DQo+ID4g
SSB0aGluayB0aGlzIGFjdHVhbGx5IHN1cmZhY2VzIGFub3RoZXIgcHJvYmxlbSB3aXRoIFRELWZp
cnN0IGVuYWJsaW5nLg0KPiA+IEtWTV9URFhfQ0FQQUJJTElUSUVTIG9ubHkgcmV0dXJucyB0aGUg
ZGlyZWN0bHkgY29uZmlndXJhYmxlIGJpdHMuIFRoZW4NCj4gPiByZWNhbGwsIEtWTV9URFhfR0VU
X0NQVUlEIHJldHVybnMgdGhlIGFjdHVhbCBURFggbW9kdWxlJ3MgdmlldyBvZiBDUFVJRCBiaXRz
DQo+ID4gdG8gdXNlcnNwYWNlLiBUaGVuIHVzZXJzcGFjZSBjYWxscyBLVk1fU0VUX0NQVUlEIHRv
IGFjdHVhbGx5IHB1dCB0aGVtIG9uDQo+ID4gS1ZNJ3MgdmNwdSBzbyB0aGV5IGNhbiBtYXRjaCBi
ZXR3ZWVuIFFlbXUsIEtWTSBhbmQgVERYDQo+IA0KPiBUaGF0IGJyaW5ncyB1cCBhIHBvaW50Li4N
Cj4gDQo+IFRvZGF5LCB2Y3B1LT5hcmNoLmNwdV9jYXBzW10gaXMgY2FwcGVkIGJ5IGt2bV9jcHVf
Y2Fwc1tdIChwbHVzIGEgZmV3IHNwZWNpYWwNCj4gY2FzZXMpLsKgIEFzIG1lbnRpb25lZCBpbiB0
aGUgY292ZXIgbGV0dGVyLCB0aGlzIHBhdGNoIHNlcmllcyBkb2Vzbid0IGVuZm9yY2UNCj4gY29u
c2lzdGVuY3kgYmV0d2VlbiBLVk0ncyB2aWV3IGFuZCB0aGUgZ3Vlc3QncyB2aWV3IG9mIHZDUFUg
Y2FwYWJpbGl0aWVzDQo+IGJlY2F1c2UgS1ZNIGRvZXNuJ3QgY3VycmVudGx5IHVzZSBpdHMgb3du
IHZpZXcgdG8gbWFrZSBkZWNpc2lvbnMgZm9yIFREcyAoZS5nLg0KPiBzYXZpbmcvcmVzdG9yaW5n
IGZlYXR1cmUtcmVsYXRlZCBNU1JzKS4NCg0KTm90IHN1cmUgaWYgSSdtIG1pc3NpbmcgeW91ciBw
b2ludCBoZXJlLiBJIGRvbid0IHRoaW5rIHdlIGV2ZXIgd2FudCB0byBoYXZlIEtWTQ0KZW5mb3Jj
ZSBjb25zaXN0ZW5jeSBiZXR3ZWVuIEtWTSdzIHZpZXcgYW5kIGd1ZXN0cy4gV2UganVzdCBuZWVk
IHRvIHByb3ZpZGUNCmVub3VnaCBpbmZvIHRvIHVzZXJzcGFjZSBzdWNoIHRoYXQgaXQgY2FuIG1h
a2UgdGhlbSBjb25zaXN0ZW50Lg0KDQo+IA0KPiBIb3dldmVyLCBpZiBLVk0gc3RhcnRzIG1ha2lu
ZyBkZWNpc2lvbnMgZm9yIFREWCBiYXNlZCBvbiB2Y3B1LQ0KPiA+YXJjaC5jcHVfY2Fwc1tdLCBp
bnRlcnNlY3RpbmcgdXNlcnNwYWNlIGlucHV0IHdpdGgga3ZtX2NwdV9jYXBzW10gd2lsbCBub3QN
Cj4gd29yayBmb3IgVERYLsKgDQoNCnZjcHUtPmFyY2guY3B1X2NhcHMgYXJlIGFjdHVhbGx5IGFs
cmVhZHkgY29uc3VsdGVkIGZvciBURFguIEkgcmVtZW1iZXIgc2VlaW5nIGENCmJ1bmNoIG9mIHRo
ZSB0aGUgZ3Vlc3QgY3B1aWQgZmVhdHVyZSBjaGVja3MgZHVyaW5nIHRoZSBiYXNlIGVuYWJsaW5n
LCBwcm9iYWJseQ0Kd29ya2luZyBvbiB0aGlzIHByb2JsZW0uIExldCBtZSB3aGF0IHdlIGhhdmUg
dG9kYXkuDQoNCkZyb20gYSBMaW51eCBndWVzdCBib290LCBndWVzdF9jcHVfY2FwX2hhcygpIHJl
dHVybnMgdHJ1ZSBmb3I6DQp4c2F2ZQ0Kc21lcA0Kc21hcA0KZnNnc2Jhc2UNCnBrdQ0KbGE1Nw0K
dW1pcA0Kdm14DQpwY2lkDQpsYW0NCnVua25vd24NCmlidA0KeDJhcGljDQoNClNpbmNlIHdlIHNo
YXJlIGNvZGUgd2l0aCBub3JtYWwgVk1zIChhbmQgbWFuYWdlIHNoYXJlZCBFUFQgaW4gS1ZNKSwg
c29tZSBjaGVja3MNCmFyZSBnb2luZyB0byBoYXBwZW4uIElmIHRoZXJlIGlzIHNvbWUgbmV3IGZl
YXR1cmUgZm9vIHdlIGVuYWJsZSBmb3IgVERYLiBBbmQNCmxhdGVyIEtWTSBhZGRzIG5ldyBsb2dp
YyBhcm91bmQgdmNwdS0+YXJjaC5jcHVfY2FwcyBmb3IgaXQsIHRoZW4gdGhlcmUgaXMgYQ0Kc21h
bGwgcmlzayBvZiBiZWluZyBwaW5uZWQgZG93biB3aGVuIHdlIHdhbnQgdG8gYWRkIG5ldyBndWVz
dF9jcHVfY2FwX2hhcygpDQpsb2dpYyBmb3Igbm9ybWFsIFZNcy4gU2luY2Ugd2UgYWxyZWFkeSBh
cmUgaGl0dGluZyB0aGVzZSBjaGVja3MgZm9yIFREWCwgdGhlDQpnZW5lcmFsIGNhc2UgaXMgbm90
IHRoZW9yZXRpY2FsLg0KDQo+ICBJIHRoaW5rIHRoaXMgaXMgcHJvYmFibHkgbmVlZGVkIGluIHRo
ZSBmdXR1cmU/wqAgSWYgc28sIGFsbG93aW5nIGZlYXR1cmVzDQo+IG91dHNpZGUgb2Yga3ZtX2Nw
dV9jYXBzW10gZm9yIFREWCBtZWFucw0KDQpZZWEsIEkgdGhpbmsgYWxsb3dpbmcgVERYIGZlYXR1
cmVzIG91dHNpZGUgb2Yga3ZtX2NwdV9jYXBzIGlzIGZvciBzcGVjaWFsIGNhc2VzLg0KQW5kIGZp
bHRlcmluZyBsaWtlIHlvdSBoYXZlIGlzIGdvb2QuDQoNCj4gIHdlIHdpbGwgbmVlZCBURFgtc3Bl
Y2lmaWMgaGFuZGxpbmcgdG8gY29uc3RydWN0IEtWTSdzIHZpZXcgb2YgdkNQVQ0KPiBjYXBhYmls
aXRpZXMuwqAgVGhhdCBsaWtlbHkgaW1wbGllcyB0cmFja2luZyBhbGwga25vd24vc3VwcG9ydGVk
IFREWCBmZWF0dXJlcywNCj4gd2hpY2ggaXMgZG9hYmxlLCBidXQgaXQgd2lsbCBtYWtlIHRoZSBh
bGxvdyBsaXN0IGJpZ2dlci4NCg0KSW4gdGhpcyB0aHJlYWQgd2UgaGF2ZSBiZWVuIHRhbGtpbmcg
YWJvdXQgd2hhdCAibm9ybWFsIFZNcyIgc3VwcG9ydCwgYnV0IGluIHRoZQ0KY29kZSBhbmQgdUFQ
SSBpdCByZWFsbHkgaXMgYWJvdXQgd2hhdCBLVk0gc3VwcG9ydHMuIElmIHdlIGxldCBURFggdXNl
IGEgZmVhdHVyZQ0KdGhhdCAqS1ZNKiBkb2Vzbid0IHN1cHBvcnQsIGl0IGlzIHRoZSByaXNreSB6
b25lLg0KDQpJIHNheSB3ZSBwdW50IG9uIHRoaXMuIExldCdzIHJlbWVtYmVyIGl0J3MgZGljZXkg
YW5kIGlmIHdlIGZpbmQgVERYIGZlYXR1cmUNCmVuYWJsaW5nIGlzIGJlaW5nIGJsb2NrZWQgYWxs
IHRoZSB0aW1lIGJ5IG5vcm1hbCBWTSBlbmFibGluZywgd2UgY2FuIHdvcmsgb24gYQ0Kc29sdXRp
b24uIERvZXMgYW55b25lIHNlZSBhbnkgYmlnIHJpc2sgb2YgdGhpcyBiZWluZyBoYXJkZXIgbGF0
ZXIgdGhhbiBpdCBpcw0KdG9kYXk/DQoNCkkgcHJlZmVyIHRvIGF0IGxlYXN0IHN0YXJ0IGZpbHRl
cmluZyBBU0FQLg0K
