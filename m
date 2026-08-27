Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC6D27CCE0;
	Thu, 27 Aug 2026 03:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787799793; cv=fail; b=aiLBdAjAQjWVUh+Met/j9PLoExEbH8wZrJ0oRzhHutKFGNAHotiOfjU+HVegtQ8//ywIFDbdLN1vEoplTTPKrLelTn165rR0csSX4lxvaW2MFwNo1rAOyO0hQBr4+5/x0s9cpWvQ6uC3YdHsr5iKA1mc7xyihaRxu2eHAjYCpXI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787799793; c=relaxed/simple;
	bh=uO32IPCKJXXqHI2dY0U89lwl1FoYFTsIibnb7hECiJ0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pEghnJt7Q4LspHlbYknhPAa8rW8frmWj5222gaKbx0Q2Ll/XQ/RqR5NN1IIBjKEXbz6RWkezyHNKoAv4fzNIyJdP+IgJFO5FsG3FXTdgNL2xpioN+ptXA7wGzUQsVQFDs6Ug2ygi8ssvN5544PgL2Z2TfeVRHbIdBSO4VxiO3yg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mZnpyXWQ; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mZnpyXWQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787799791; x=1819335791;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=uO32IPCKJXXqHI2dY0U89lwl1FoYFTsIibnb7hECiJ0=;
  b=mZnpyXWQBrSvprBxagMJ/SUJSWVXfPUytlFnuRE8gtMjDIDp46cqnI2T
   Wob18iW8eRs7QnaqigvI02v7exDTPa9nuaePMIhvTEIozlcesFvB8bAI+
   ZKU/jWot038pm0qwq8xLQ+6OPfOa+LE9RYQeWzE6toopbOwXlegt+kkwc
   HxfeGK8bOY4hF5HvDjIF8cSsr7TabNRLtGB5AytVWd6pDaBTNjKO32Z2L
   ulwt3ZTcPv/qh8CVR8uxQVPhSyTI9TJku1BqTkuxdVCgLyiM8xvyylxCD
   j4TWaZBdTy6ljMYjmh2Qvu5wfqxBkf83h29kmooRKwGncuLkcXplqp8ra
   w==;
X-CSE-ConnectionGUID: auTfYUORSam9+kXuR0kZLw==
X-CSE-MsgGUID: bnGDK/t9Ray7pyn+KgYywQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11887"; a="92110220"
X-IronPort-AV: E=Sophos;i="6.25,245,1779174000"; 
   d="scan'208";a="92110220"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 20:03:11 -0700
X-CSE-ConnectionGUID: KckVZ6X/TB2bVKX61FEX5g==
X-CSE-MsgGUID: 1rc2iS50Qg++LHLKFxJGbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,245,1779174000"; 
   d="scan'208";a="264485664"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 20:03:11 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 26 Aug 2026 20:03:10 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 26 Aug 2026 20:03:10 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.38) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 26 Aug 2026 20:03:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mz85MNRIVMX+29rB98yLOAziFAZdpeZOKZmjdZmPSwAwH59c8s+Ps9myIZPiux5F4eX4fVATwKckR1Uc+7IamXYZcMdfQCMoJAWYOy2TmHH+mO+dkVuvF74LSJD38r5vmp6VJ6Kd1nSPOc/OGdT137MeF4wNcGA+nFzeJARxCxKEz5WYuLnfJV3j4YURlZveuIPKtD2MAWCkP80HgvhiX5PPFpcaK/dJCDoZ8trzt6A3YU4taDeL7EllzkohLIkAO+FeW6k12PONV27IBC/KLvWmYS1LetNTqpG1eCutP1AZpo6kOUfT0IShavzG9qepVI45vgU4loJAedJfcFzFiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WmktmXC1XoVv1U3K5AuqYKHb7KXgkZpyQDWerDg2ocQ=;
 b=mrKd4X2YAHxwf6CL8++LNHUZwmBhpsP7MqVRWpmiNJrS4JfOujQp2oXm9jKNvAjGllK/dbyyrTNpVc8MjfefL8APtVDpBY8Cco5qKr4itP+mffq629c4Ius9UD5Xb6nCxPHTM08MdTq3Bxo4SkEhKawcSMDMi19jxdBCe191gqildr/SVYo5PP6C5wv+e+dofTiosNRmmREsvgYcqeFBKE82RUX/v3g01JWOiOsHjusAPOckBcp4H2FPFzNwnnUGr8LOtFifzhmgtKx2jNq88KrLjKZynI+7v3AcD041scC9PTNpZhw31HOJVMKSew5bs+Myrudu2kIaDN079FFIig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DSVPR11MB9579.namprd11.prod.outlook.com (2603:10b6:8:383::17)
 by MW3PR11MB4540.namprd11.prod.outlook.com (2603:10b6:303:56::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Thu, 27 Aug
 2026 03:03:05 +0000
Received: from DSVPR11MB9579.namprd11.prod.outlook.com
 ([fe80::ab5f:5d0f:fb90:9d]) by DSVPR11MB9579.namprd11.prod.outlook.com
 ([fe80::ab5f:5d0f:fb90:9d%3]) with mapi id 15.21.0360.006; Thu, 27 Aug 2026
 03:03:05 +0000
Date: Thu, 27 Aug 2026 11:02:41 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC: "Hansen, Dave" <dave.hansen@intel.com>, "seanjc@google.com"
	<seanjc@google.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, "Huang, Kai"
	<kai.huang@intel.com>, "Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "kas@kernel.org"
	<kas@kernel.org>, "binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"ackerleytng@google.com" <ackerleytng@google.com>, "sagis@google.com"
	<sagis@google.com>, "Annapurve, Vishal" <vannapurve@google.com>,
	"bp@alien8.de" <bp@alien8.de>, "tglx@kernel.org" <tglx@kernel.org>,
	"yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>
Subject: Re: [PATCH] x86/virt/tdx: Warn on !4K level in tdh_mem_page_aug()
Message-ID: <ao+o0dfTlj1neBiu@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260825025533.25663-1-yan.y.zhao@intel.com>
 <ao2ZH8dmkPfBDnGv@google.com>
 <ao6UVdWNbhQaAFsm@yzhao56-desk.sh.intel.com>
 <1e77b1f6-0491-464b-b79f-ca756a73e7ea@intel.com>
 <26df3b906110c060d996ae8e79c4c1857f16f187.camel@intel.com>
 <14ff9d8dc8fe6999fa8a4100ea9fc833fd7a9c3d.camel@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <14ff9d8dc8fe6999fa8a4100ea9fc833fd7a9c3d.camel@intel.com>
X-ClientProxiedBy: KU0P306CA0017.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:16::11) To DSVPR11MB9579.namprd11.prod.outlook.com
 (2603:10b6:8:383::17)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DSVPR11MB9579:EE_|MW3PR11MB4540:EE_
X-MS-Office365-Filtering-Correlation-Id: 3335f61d-ff84-47cb-96a3-08df03e7b6b6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014|23010399003|22082099003|18002099003|56012099006|5023799004|4143699003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: XRacVDBf05S3znndi9g+HrurYOpUz4dLW9Y9B1t/OmDBWrQcgn/80dvdzBfEvobMfwpiOW9MXKP1/INvN0zEMCGL8XMUNP4Kys0KtloWBZFjr7qlXViDu8v858BsU3olzhb01Hua8uhbAEN4l+w9F53lEDRhLQWtvAVlfO40TMZVgTQdJQ22Zno+sgdePw9DgW7O6E9dI+0mvmQYFB8kS1wz6HlIMAPbsLfhXkeBigx8ziUel9RGQ+0iMKgCHO4GHDKgRwlNP1ljqt3ZfDTxBXLFvgP7NZ0Y095Il5z3NMLIgi3HB7DUR1tuamUnYSOBHpnW+2QRsTBPZJ/9JNahY42hUCGnWq2R6k1l2x8o4qBfgzBGcB9BMe1GYEkDbJ1N7Xm4QEOa9FG7blqneA58HM0YYIsdw54UGbS0QXnd4ZJqn8nwkmKP9iKYhs5V1H4GNRX7TrivxWmAJZgym5LHjw/zo5X49jpvnUIAgaqydmXyyxFrWAG2KuSLxh6Y8LQeab8E7Ob0hJiXARLg3nKbaJcL5udCCEKePsSgTaMuANv+8hAjSxmG2j+huCuGyArDRyiORIf2eMARd4h9J7IJW+Xi0uigFix2m6QVLc4r56Ukc+gdHXLtfQKDH3gyfGF7RqbYa3Mphh7BSKLCVvxw8FGJ71EB7LukGQjQ5uiy5OU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DSVPR11MB9579.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(23010399003)(22082099003)(18002099003)(56012099006)(5023799004)(4143699003)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?b5qknbGolJUX4F5B++vwFQ6owNYvuYQxnT8ufbm837KhX2egxxE2zZ0E1wBp?=
 =?us-ascii?Q?1pOqud0wqW4XZynbYbxwEilTTRRW0JzNJRsrdFYEQTrasz0NC0Dok5/bMgC6?=
 =?us-ascii?Q?iqK9ccqPvOagJB9/b+XyHdrIrAbeS9eWcKviKk1AbIRhiATAW9J/Hzt45EZk?=
 =?us-ascii?Q?CwTpHwut/1ftMu2qWq9YzaH13W8kIVICFdHaoujKqfDW/3vmLZWYxkZCOZjn?=
 =?us-ascii?Q?U3HeZtkYXE0qJUxMZu+U+2V+eFlWrWMxo2Ojvt3uqm0X546dzyqRsw7taJs5?=
 =?us-ascii?Q?ZEzFCMsQC9BQfyo9KqZFlqtxZSVcBwWjbQer82yURVZwTmENppKC0zFmxvGo?=
 =?us-ascii?Q?ql8LwIneIxgGO1z3K1Hnf4FekYPTobzabpfSEXxfNiIq8IjmwFSgrWgBMyzy?=
 =?us-ascii?Q?s9rsYM2w8PL8YGMJ9Xgh7tJjYyuZzfDC2+RIHlhN9WhRl+tw8SnIudRoQjxR?=
 =?us-ascii?Q?ABwFYZjhDryTdU+g1l7KWnr6VX5LMvAsyG5xhjLqwO5t6cwnHSTubOmauVkM?=
 =?us-ascii?Q?0/I9i5YbIBFhA0GgIdN6SFAryJB2x5JY0HpFkVOcJRDVTW2QuKpWxm1Y84N7?=
 =?us-ascii?Q?8KSDFFJGKeafi+fOc0I23qKB/lUopJ2Qbhvd9K0+8QjRLBo1Rq72UTU5iRfk?=
 =?us-ascii?Q?KgXwWkvr/OCUDjpw7JieSJHTq0DQdcPUYfIACmevJ1Rkyq9E6KE8I1NcxUkb?=
 =?us-ascii?Q?0PZYa7XIV1QpO6/iSK481AaAMu7sGZd3KtDywdhlsHdwlbS98KGNrzZmBgf8?=
 =?us-ascii?Q?B3GVOfzDFRhFeaxXa5wkcw61GUpHEjB5KVnck6pSCaRDde7Rr7XJ/j9+GnYX?=
 =?us-ascii?Q?z3fupR8pEToVoLHczJibXUnAiA82EkfrdWHv2AeEZA2ZDwLdgOGCySLW35Sr?=
 =?us-ascii?Q?Kh5bEQLdZCHNBqiyvCwJmCUk932O7sJJ3Bl1z61KnDz8pIZGOEy2q+SKpoGG?=
 =?us-ascii?Q?gJdebumPdqv35WW21XGHuRGPGncCIUm+N0S3HTmYP0KNs7p09GImw7Z/09/g?=
 =?us-ascii?Q?vdCeFLYGzomJW9nfcWcZ0l4DgowgLvCfh12d+EX0fFP8PjH8F12oUZk9gZp3?=
 =?us-ascii?Q?TQqhky+xHdEXMv/srT/x1z+3uNeVPTcOKWMy22dXVgLSbtU0BsXhslCnWJuV?=
 =?us-ascii?Q?TvIymEB5n6hOvtixfL3TQyTwXOPZFibWqBbPcfsRmRe1oKtdUlgHEEmF499G?=
 =?us-ascii?Q?2imdsUYG0Kgs+ytbLsTOk6rKEZKzD+EItbYAL4Q82CNTQhWEOregDuKCiwBH?=
 =?us-ascii?Q?gCE94mUdRcpt8GVL5tWKGyDwf1tU7qrJ2pIBpbBbNo/VlXmKRc+86C3DAZSz?=
 =?us-ascii?Q?F6WKtjxhiDudjhbmXz/qrkfkFTYrANuG7BJ2dTRQ0r6LIEzcDy8Osb1EMCqv?=
 =?us-ascii?Q?s/I2F6NgLWFRtqIsQzsZyg4TXwv7U/mkkRZOA72pLU4fLx49OyQJ9Bb0Hzuj?=
 =?us-ascii?Q?KNzcjM37EGCnlEqQDvIugBmPhXSgoo7iHsZ0SHXJj+wrkyqaE4c70T68kZXU?=
 =?us-ascii?Q?+mhkn69/ZhqNb8PjQFw3y0gDKD8eOaKBZavJfW0aMoT6JyGsIIqgwBzMyLIO?=
 =?us-ascii?Q?0xqqA0xxcuoeBeZziG5xQhSwoPo56kADKUNKeEdAqu0qGJ2AF3h0kL6EG3Hx?=
 =?us-ascii?Q?8Zu4+Zn5RiZaZMQjytLKr+Feej6g/X1marj6gLYbQ+WOB4kFKaN8G1c/xHVq?=
 =?us-ascii?Q?x1D1u+y8dxf3qLRl4FZdMA5RMvbLuo0f5r1Az6nSKXSAITzfuhEIOoqBEqP8?=
 =?us-ascii?Q?G6v28mowOA=3D=3D?=
X-Exchange-RoutingPolicyChecked: ZiB+2/WOw2lo5mrGUa+QnlHnjclMmvkjRN3SV8fV1etnskJf0RthwCod+NYOR6beaj9RH7mEwXHg3xmHrfSwyCBihCtWggKK5M9BxD7qtkIg/cjSG62P56X8JJEp5JZY4xYmGoZqzIcbAHONM5fcTjrwlAwRCFRZ6uBjmYpsu6qYPFl9Ac9x5Gm0SRtS+xqlaB3Vofa4I56iiYgm3rR439WgchOrdililQwW9j+lSp/BCaCT26NQ5GiXq+owaQyDnhdXit0brCZQpJXRX23aNYVIBTAdZbVdZJgVeZGEyVuj0yhps97bi5GtXaS5GGR0RkeW47+DMnGlBHLxJg9C7w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3335f61d-ff84-47cb-96a3-08df03e7b6b6
X-MS-Exchange-CrossTenant-AuthSource: DSVPR11MB9579.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 03:03:04.9610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CPEMfxMFfBIuIbZxg0Awb5iteR6fNrYnFFFcHWLlDqkMAnckG9UvtrD0mVG/v8WkDK4Pt6qE1CbCTHPsjWp07g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4540
X-OriginatorOrg: intel.com

On Thu, Aug 27, 2026 at 12:23:56AM +0800, Edgecombe, Rick P wrote:
> On Wed, 2026-08-26 at 06:36 -0700, Edgecombe, Rick P wrote:
> > We are waiting for some final confirmation that the TDX module will never set
> > CLFLUSH_BEFORE_ALLOC. And that means all the clflushing is not needed. So I
> > would probably shortly (weeks) send a patch to rip out any extra flushing added
> > along with the rest of it.
> > 
> > I think another valid course of action here is to do nothing for now.
> 
> Ok, just got confirmation. So how about instead of this, we just delete the
> clflushing all together. Then the warning is not needed because the function
> works for huge pages after that, right Yan? I can send a patch.
Yes. Deleting clflushing all together works.
