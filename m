Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7F339DBF8;
	Mon, 30 Mar 2026 07:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774854488; cv=fail; b=m/ckrkjhuUFuOG80/6na5dcuZFNe2rj++zTsJEhZsJCAnHwp1s3ZVVZXX9bfkHyAgrXxxNJoaN2OVg9kQ5ED9nO0eN7TotcJ1e2zsTHQDNNB4R81b9W98Dz4pfPvOp+Z1QmDZNmCk3Dz0ckps35DohCjyZ+a0aWwiBIFS46G9A4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774854488; c=relaxed/simple;
	bh=AIa0LOy+UYnVT6AgwH84+mTe6w0xRv5iY/A3txr5dU8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HJrXOpUQW2KBJ1ivA/AcHhgai1RXDEKO+WO6PYLBBQ2WKkY5eZzxEZnb66EYBP+94E4pMtsLIJl/sUQZT3yBzCiD8YeMzFN9XTVqcfBpP7rTHhmTyy68dOeLqg/iHlh2hFygiRgsXcFb+uOotAeAVdydqoyJVjCIIa39llesu1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CyV3F2Ko; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CyV3F2Ko"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774854487; x=1806390487;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=AIa0LOy+UYnVT6AgwH84+mTe6w0xRv5iY/A3txr5dU8=;
  b=CyV3F2Ko3QC2PxKzh7GJkbmLByMjPD8iL5IFccNwKGCGMaPpor41LSV5
   cOBL4eWP0UUZcCtf4LuAtrkjtqPcwYu7up6ZXPfkslS1Y4TcQ+apjLI9w
   6ntGR8QvMlJQmRoHSW85sIE/V0mOpD5Lj7e7aB1Q3zOnIUY3p2LA0gXKx
   QjOjxzNIW/W03INrCWZNc9ouys0EFYYAVHW+9I19GVJe4zgO4V77yF2FW
   U9Nf2Uoa5HOilqZQ7mHGLmOnHmgI7WGzqdg/wFL8PJQa/J4F23BDGzAn2
   EtKsANZnaZGfNuls52c4c8Bcy1o0gVK25wEO2eBJPntNMqiyxN3WN41Se
   w==;
X-CSE-ConnectionGUID: fN/QJF/OT4eh2Mt2ar3XPQ==
X-CSE-MsgGUID: fwD8nshGTOm09rI27PIpzw==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="76031090"
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; 
   d="scan'208";a="76031090"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 00:08:03 -0700
X-CSE-ConnectionGUID: B+6rKvUES2e16rD71eDYlg==
X-CSE-MsgGUID: 7GfEU6keS+urVCT09k8Hyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; 
   d="scan'208";a="230438267"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 00:08:03 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 30 Mar 2026 00:08:02 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 30 Mar 2026 00:08:02 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.44) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 30 Mar 2026 00:08:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CAqr/bbN8sZHiSxsyUs+hvL7DL80Y/UaqplU5QNdMxkUy8QRf8YhQqelZ+crMQd+e849TeXMS1tKoI87X/ag0ttH9+7rdwMCdWdn9Lr+A5SJRF2O242h5fpNP4UPvaQyNCA4vHD0qSr/b/s/QdpvwdIlKghY3Igs7Qp3EHTekA4rnWN7dHnzFkd97rDgxfFBu4NxvbWWdINhR/0Ci5VMf88MmR1bSNDYR2EiVZP8sgkwtRWp02pxx3WuRo7ejJcC/8OJqb8ENGMpMcGBzOvQ/KeyfOzpICQD7he/XgAoGnMSuAypOKnZqEIdmHcSDDY5zrkPQN51Y9wiR2nJEbtqtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JjMW2DEacJMNmHGtlqGgYE95Fh4h3r1OChZ9jq1mAeg=;
 b=enQ2R/J6hfIIWIyOSAcwqWuspGaogH/Ybf+1dYcuIfq0s0PQbMK8USqHSOz9eEUWMtu1fLHchjnF+l66AwboIlB5Qwe9TW1yKx9w6kdm1QGwUzDXlWNADWwbMtDsciVJIFuzLFkKmAoXGkpP4iAS0D25v5lCE3Z2QcRb0YLJa5Sw4H0Etri4pHRD9drSr8LTYvujv7/n8CK8cqj/2paS5KQ06oQ7LP7y1dcF7/lq2RPH8mEBsrbajlDddp7ApHmvYuWY5EJnTTGuzvFJEcPwjL0YHfBqlDe8LKTRJSNGkU5h0wY828l8VtQamJzH7GeGZqyc12PNnkRiucQcmUDqLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7472.namprd11.prod.outlook.com (2603:10b6:510:28c::12)
 by SA2PR11MB5193.namprd11.prod.outlook.com (2603:10b6:806:fa::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 07:07:59 +0000
Received: from PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475]) by PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475%5]) with mapi id 15.20.9769.014; Mon, 30 Mar 2026
 07:07:59 +0000
Date: Mon, 30 Mar 2026 14:28:27 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Rick Edgecombe <rick.p.edgecombe@intel.com>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <kai.huang@intel.com>,
	<kvm@vger.kernel.org>, <kas@kernel.org>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, <dave.hansen@intel.com>
Subject: Re: [PATCH 08/17] KVM: TDX: Drop kvm_x86_ops.link_external_spt(),
 use .set_external_spte() for all
Message-ID: <acoYCwIdBjCiishm@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260327201421.2824383-1-rick.p.edgecombe@intel.com>
 <20260327201421.2824383-9-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260327201421.2824383-9-rick.p.edgecombe@intel.com>
X-ClientProxiedBy: TP0P295CA0008.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:2::20) To PH0PR11MB7472.namprd11.prod.outlook.com
 (2603:10b6:510:28c::12)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7472:EE_|SA2PR11MB5193:EE_
X-MS-Office365-Filtering-Correlation-Id: 55556601-6cae-4ebc-736f-08de8e2b1302
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 3x3Sn46EpKmwxDjj8ZV3VwVZisxSjJSh5WZDRbeIR9G5/IWraxpEE3RqkVYeD/HeizFUg3gPmio9eTj4HT3kyhLBF4uBuqYn5WpwvtTl8KJnAtELEURMSYdwQCw1fJ6UKqEMZoU8bL0xi/wIglyVUZrc31NS3rpbdJ82RRDtPo2bsye1+Y+V1wX4xSyeQiJFUyH20RGrhIhrV8CY2gRSQfnbMEo9Amqfq59Cjj8AJKdfanL4DnSCaq9+DBL8BYHBZGmE/9vH+m30gfaEKd5+CLo5KIQQNo0aRawRDPC/KhTo6t/kiuAL3p84Afr3NMjQHlapi5c3A/0QkGi0qszryTqe35HWj4k0fp5uq7wzkj5+zU8n+FVw7QRP/w6XrOUd3mtmdnBF+fDWNiINNNL0n18eOKQRYv4p4NTW6YrEiFqGGHUdS1dPwyHbHnkhnb5qJKL0aOGDsORbM7x2dEy24yGLrTAWENsf4VGD+gh9+erEg79r6i73yY42YT1LSSc41c+zf82hRaNIsYJg05LiHwfH7mDjtxue7+B8DtfMTMl6i5AS2/dtDINZiErXS/CIQnpkIeSqhpLW0lUrNjpMOseKRe51+tEgzTItoBT8KaaJOGFlOxMNffNPytLhet4/eykYCtVyTL8e0g3yZw7TSX+OjNbg0wt7tfIAL2QF+I6r4NnY3TiyBC/BtM8j5UJy6TpP7mv2EPlsQqQa49Z79M8xrfIXy/6lf8YKZ4lv9js=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7472.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hE0hoMw75KFKphz9NnWo0JJgkusMbYlG/+NJJA2UgZJnSNPjfzk0tCQfTQav?=
 =?us-ascii?Q?OSxM6JUyENPQix9b3H2XU1CKyO1WRIKHssUfC1b6yDEQEnIeMO+kRt9Fh59j?=
 =?us-ascii?Q?AjDHdKRtvF60Q2gyQ5Q84bQT/fwTQ2ZIVnQX2YQ08iBQvKwXj8b1A8tbt+8r?=
 =?us-ascii?Q?H4wSnxPJoy+IKFj6rwx1ZqHRkiV5b9ZjAB1YAbUyp248ombdoyJVV0jX1WiR?=
 =?us-ascii?Q?D4lIxRion3o6iC0c3qy4IyaM4GhZr+eUWERRLrogojTkgfnJFThxAKCa1y7R?=
 =?us-ascii?Q?9V5VngsiovBHSZk777Jv+hM3EU6j4jD/cWVKM1f60CHrMeRZgmIKQzkKoP3n?=
 =?us-ascii?Q?U7/62rIT1XHZgvJckiecIy6VnnXiMWZpOjzuoWNv7+T4ybAuH0/mFwq7kLMF?=
 =?us-ascii?Q?RchmW+Q5AVmKzhRXMAYs1iRlzXaMndBUnY/AenGmIcltoiav5Rl9Y7vtj6p5?=
 =?us-ascii?Q?2qxz/dq2F7E58jjF+rnMO9vo5CtyLKx8mM/rE8WcftKSjFIxdOlRnGBqrn4r?=
 =?us-ascii?Q?wXpPAXKI3KJbHfmFQc5swtGINbSoWzQbFAy+ZJSPXHDpyuOgRgjFaZubVx8k?=
 =?us-ascii?Q?5zPdrs40RLhCrwXv3zraC282yuDKIQOipS22q6zZpg2gp1SpeUTzhxywVFWK?=
 =?us-ascii?Q?u2/Hn03G3lDcwEymP+p0ZW06nd9DfLA0o4NmFYquzLgh7qAeyQ6f8AhxrXCQ?=
 =?us-ascii?Q?s218Ho7M521Blt4+2dLfmD/FAUQbocTFxMYkadWObBafjsDq0DSpVqiMBpGM?=
 =?us-ascii?Q?yCP/N0Sc6TkbIx9bm8Th1ZqjQwvW3qlJCjCyh4gnhPDj88puhmIaqfzIExCx?=
 =?us-ascii?Q?ZLLgYWOtD1tZxrVLri05v3TCUgmR2qqrhekiYCmS8fdPi1jeqe3+bO1kFQuw?=
 =?us-ascii?Q?yAm6X8xCjOk/I2XSe9QCSnK3B0i8k9XE8mOdBej9NtHuoerX7Tg39+3dOGT7?=
 =?us-ascii?Q?RBhcHH1D2yqOZtIb6pyBbKOwcgEdPyYvPcGrS2t05p//GfcS9/YAkfCrXe5t?=
 =?us-ascii?Q?9h7SHm2HtMjsMuwd8SAULzfzlztSl17+N4gPP5qxNUPkkCM/uI9qoIlGLn+j?=
 =?us-ascii?Q?Yszhi35xdrVlrCej0bwAKSxd+cKWsHZJl+iDYqz0D+wcMgZNpGlIQ2fGDQqI?=
 =?us-ascii?Q?B7fbe4RTjFdUTPvKaFf0TvIebxIiul/O9VxnDs4fWTAQaP2ffWdXhsYAihvR?=
 =?us-ascii?Q?h2TQdHvDwheGn+FNq/HVtYw3S4RwM/X350F/rh69VtYZ6ZlG8vt6xBOGmY7M?=
 =?us-ascii?Q?rhNpH6fOjOawmYoRF0Y/Vf2vbuIdmSiIuh/6efV8hPbPMYCDsj1lIs+9Z+mD?=
 =?us-ascii?Q?7xjmYWyl4tT/htv/dZu5OYG4WxzJ3RxpwzHNihS+BqZlcP5oZu1V20bJR2Vi?=
 =?us-ascii?Q?kNQsEaR0I6lQOs0v0oLbkj6SZDyducvnkGeb3wusq2FFM5k1td5/ybVn31/s?=
 =?us-ascii?Q?oXJQ401z+ppUcVC6rx6pretU3WsU3GLkgxhcZylp3fQwTDKl+XGy8+zY8JH7?=
 =?us-ascii?Q?61hXBz6gT9iCQjLE1TZcTcPBkbnRjOvWPYMDC/t+3igATiehymzGaldGVK/x?=
 =?us-ascii?Q?8fQzwwb/nU/mxgtNUPrMY5RAzXI7Nej5LnxcM0lrvYnJzMoj5GQhZNA9mPmE?=
 =?us-ascii?Q?gpDm3Bik7cogQuVUGw39zlbDv/qUVqgWz63mDiKZHvymOpBmBSsRK0uoEunw?=
 =?us-ascii?Q?gpKHYEn6UQLGY7wyyF5EnSmRw/nwsssKP4DEARKis1907+RZvjsbPRaM04ms?=
 =?us-ascii?Q?HptawLTuzQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: oIY8IJG7zDsFB+df+HJAaN5xnZOn5+rcFTa5aALFNUWArI3B3AuB/Ubn4mxQLLNpltF4O71uMKB8wsBlrWP2qv/79GDqkYtrUg9qpqmiskIqBE1+/qpB4zWzPAdUNtApcaPdthyqPbr/wE5NwAMkyg3pMwlB6o+7qt4vNpkxB964kfuCwRyGpRqCXMWn6A7F3sr/YChMw/lsaehq9GF7GNMXWzh8B+s3QyEPDfwQ7lA4MgnFdW9LwPnOA5QRyNHKGCzwakqS2L17TEsOfmtnYuh3p3UkgN3CYo3+ieRvu+dDBxAMWPVenZIto0vM17wVNQhwlATUP2SPWPPQFGdHLw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 55556601-6cae-4ebc-736f-08de8e2b1302
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7472.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 07:07:58.8965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q2JaqPK3em3adPhZJJ2IxnPCn34B7a4zCf8kMP+5zTdnO5RJmTH5eeEYjQH0OTS7tb0LGdL/fp6CrsS7i2uWLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5193
X-OriginatorOrg: intel.com

On Fri, Mar 27, 2026 at 01:14:12PM -0700, Rick Edgecombe wrote:
> From: Sean Christopherson <seanjc@google.com>
> 
> Drop the dedicated .link_external_spt() for linking non-leaf S-EPT pages,
> and instead funnel everything through .set_external_spte().  Using separate
> hooks doesn't help prevent TDP MMU details from bleeding into TDX, and vice
> versa; to the contrary, dedicated callbacks will result in _more_ pollution
> when hugepage support is added, e.g. will require the TDP MMU to know
> details about the splitting rules for TDX that aren't all that relevant to
> the TDP MMU.
> 
> Ideally, KVM would provide a single pair of hooks to set S-EPT entries,
> one hook for setting SPTEs under write-lock and another for settings SPTEs
> under read-lock (e.g. to ensure the entire operation is "atomic", to allow
> for failure, etc.).  Sadly, TDX's requirement that all child S-EPT entries
> are removed before the parent makes that impractical: the TDP MMU
> deliberately prunes non-leaf SPTEs and _then_ processes its children, thus
> making it quite important for the TDP MMU to differentiate between zapping
> leaf and non-leaf S-EPT entries.
> 
> However, that's the _only_ case that's truly special, and even that case
> could be shoehorned into a single hook; it's just wouldn't be a net
"it's" --> "it".

> positive.
