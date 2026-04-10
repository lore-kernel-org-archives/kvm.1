Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04633ACA5B;
	Fri, 10 Apr 2026 08:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775809593; cv=fail; b=nVkqw2LK8facEpex9cFn1vLrHBbfsPso39MUiZLSALPTsP5A6uPg6LZ2bYTw8O3WxEfr8qpW95xqWuBOsk7nfTiexIkFnGAHriQL8nxKZn65SGYTBUCq+kpyq3Ng558OM1sJ67y8ZdH+8af+9XSTX9oIlDcft+GmF8L/tcAZEjQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775809593; c=relaxed/simple;
	bh=lt20o3xPNSr/IupDQQXC7+mwo/R+jQDHVJT1m85P7Pw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=a9NotAcw29q8x/Mfbqirc42XiqD8B+6oqUAjJbBxEEZMzk3xXB02V5KpNBn5Th5WYxeSOX5IfpbBRWJiI17xxhjsc6l47zjUSAwoHYYZRdCYOf/j6wGq7MySAtUrOsGHVP4B/ZqWwKw/BVYNzhEpQu0EZiM0zOf4QxmAbvZYod4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bo2umLE8; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bo2umLE8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775809592; x=1807345592;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=lt20o3xPNSr/IupDQQXC7+mwo/R+jQDHVJT1m85P7Pw=;
  b=Bo2umLE8iUrabcW8WGTQrfzqlblYcVUpJ8lZPqOoODmwCoypPZMYLqff
   3LgEV+bKI3FXAyqc0NsYL9AiV+sfOKiXGJi9sH70Yl2XFcMppPrRVX2Z+
   ilB8Ef9qmDeYMP5f21pYYiajYUNtj5SptSwcHEWv0CwIB3xRgMDvXaZ0g
   ThvQv8eosHaxuJrX/HxlsqaMza4SALAebNdIXwfzE5lWRROALzF9epMWR
   Cu48G//KbAhseNZJsVQr8FHhLguOPu7MzmdTLSCV9eB06aTbMOXj8Ok9Z
   lZXvQGp2hqig5oq0RhoFFhTcqWuEIvJK50bOniKY7sdOMI1kKfvboJzKc
   w==;
X-CSE-ConnectionGUID: yR4ymIkIQJS7FWlMt7aSFA==
X-CSE-MsgGUID: c6fZp90aREOSs/rlMB6AIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11754"; a="76946993"
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; 
   d="scan'208";a="76946993"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 01:26:31 -0700
X-CSE-ConnectionGUID: mjgmu5UaQxy3RfduNn+uoA==
X-CSE-MsgGUID: Z6Tk0LBkS6mtC6lzkTq/bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; 
   d="scan'208";a="224285234"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 01:26:31 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 10 Apr 2026 01:26:30 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 10 Apr 2026 01:26:30 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.31) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 10 Apr 2026 01:26:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BYmJbGlSSyo4bkasbasTMMmy5JKKBuNC4/+19MnjJO5w7kQsYPE10ScmZrZP+LgNJhyOFExVaHbab2A4a/dRSUKjQuBq6MbgxRvd6Km4wyMa8ROHEJdWtpA+UEav2yiRaYd9pIrVY1SIojsD1hmXVRiHZNfSTS96f2biq5/xkgTUWGWZXt9RtL7yxH2ED4AN0l9UspGuzYBwO5Did7fvsqRZ9ez60kcUgwTO3UQp9wI0fTeq3iTaccQYnK9Dy6tnOpAIl66RkfzBVONrdaF30hNVL7sFHgXBy6YLCH7ktpA6zhrWnzj3lJeBnA+g08J83MucXVlVz+eQQakWdjsrwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HieMiiejz6H1B44qwklOCi8s0WRCOe2V2z51PaADUSo=;
 b=RLP4RgucPa7haHG3V1WOu2+6BPb2SRDMHwjn30KPCmu6kWN20o2D36pPDek0WpkmF+pJULfNZQQwyQBrfzgrGKgdBg0rBM4PAlpxjuRhjxNI0I9holNW3mTS3K9V/KapKIlXHoob2eqFXRQfcxlXRlKZV47iEbgPCaLORVBK2sECdU6cpCWciEdO6oq6slrMCZo0HAl8dZUHX92kTCijDXUE7TVXUA5DuYE1u6h9CA9BScpFj7+NbW8uKyhliJtGQ9Kdy83Mw0O7BsmbSdgOqJuKWa4bPKQugcBoigY3FaIyTSSSjQxD/LllcCvP3atBsS4yIapqhoUgjKcinOe2Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7457.namprd11.prod.outlook.com (2603:10b6:8:140::18)
 by SN7PR11MB6850.namprd11.prod.outlook.com (2603:10b6:806:2a2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Fri, 10 Apr
 2026 08:26:28 +0000
Received: from DS0PR11MB7457.namprd11.prod.outlook.com
 ([fe80::4ea:83b3:a90:5436]) by DS0PR11MB7457.namprd11.prod.outlook.com
 ([fe80::4ea:83b3:a90:5436%3]) with mapi id 15.20.9769.041; Fri, 10 Apr 2026
 08:26:28 +0000
Date: Fri, 10 Apr 2026 15:46:48 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Sean Christopherson <seanjc@google.com>
CC: Paolo Bonzini <pbonzini@redhat.com>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Jethro Beekman <jethro@fortanix.com>,
	Alexander Potapenko <glider@google.com>, Carlos =?iso-8859-1?Q?L=F3pez?=
	<clopez@suse.de>
Subject: Re: [PATCH 12/21] KVM: SEV: WARN on unhandled VM type when
 initializing VM
Message-ID: <adiq6GTAhbVubEg/@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260310234829.2608037-1-seanjc@google.com>
 <20260310234829.2608037-13-seanjc@google.com>
 <adc1IrD8uqWdaOKv@yzhao56-desk.sh.intel.com>
 <adf0fHP8sSk6j9G4@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <adf0fHP8sSk6j9G4@google.com>
X-ClientProxiedBy: TP0P295CA0019.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:5::13) To DS0PR11MB7457.namprd11.prod.outlook.com
 (2603:10b6:8:140::18)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7457:EE_|SN7PR11MB6850:EE_
X-MS-Office365-Filtering-Correlation-Id: ca08484f-1486-426c-75d2-08de96dadc5d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: 0vKh4sX5ZE/rUY9DWMwGxQclrw5rpGfyRbOZ957589TZ3VFm8HN760Ax5S7fY1EqG956QoFn4FERGh104ZPj2aPmOp638r6oiwvQH5mdT6OGnP70lVpbTKHM4drHSCWVFfUhxcQSw6lIUQItaDS6eQBDVzTct+BKtElwj9ee3tJ31/D/cXnSaXLJtcPh02d5uMqrOZF2ioG21lsu5mMraZZma7cYAhLzWkDWfwA0u2dltifRNLPnpSzH1Q8GLmZoKGs2+oDVv3VbxDb3NYYY9qCal7mwV3472707Xovy4i616dnOPS1HYfxiX8oPA45DQovfWJo0CRPjvATCCtn2EUxBTyYLH+nWYmeLJunn+pDtYH6dAzb6vpmay81hOyheQznJxPJ2EVvWHB9ZVKnWMK6SgAaRbqkt5R1FhsKYOTk0xI1OLxSnSfNrf4fSH00/qyd9D9jSxvQF2mg1xBNSuP+ib74oV8wqVthW12XvrdMlK3xzn+d0+q1vqaoVe93bzBetX/0tSxixFV9/WRI5oVJSFDxzqF9N9SgdlRbprYSusDSnP6StPOCx5uoudJxGYDTUcrVtqcyxIooCtlXGWQyEAcdaU4Zy7t24+trCr4a8ykXxv9FTtoAW28BTLhD4tVr4H/wfe7D4LmbLjSpvs7XzqrFRKg3FMp1p7KpQJjJSxKSQj8mUKp/GFygDPaUV14tywFDW8XX+048Axw/SiajSEgimFtiJk7rA76Taqcg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7457.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+j7hUfVC7ojBKbTfdRs/GJnf73PVesZBlmsdBrKDN6DdwQNr40gXoF+ZCDX1?=
 =?us-ascii?Q?YnWc2QEPTYnvyCrxc4E7B+4O8bS9fqaHCTWoSsnodtJnaN+uI+lSo9z4Xu1u?=
 =?us-ascii?Q?/emiMN2qK6BW4r0yYjGC/QdzjAn+bkNpQUPoZqs+2J/8XM328E2h0QlBc2FR?=
 =?us-ascii?Q?oe7Utn48BEg4rt30EE0exf7byqLrxgej/45lhi2MGZ573k72Gv1iIqE+pTKq?=
 =?us-ascii?Q?2PfnP/+yuk1Wl86nlts7wSEfBVcnihpeHRVwRZC0Y6Pph/kYJKZS+EtEz9cy?=
 =?us-ascii?Q?PIh6OhDMBXVYzBbyMdz8W8JE7g+60lfyzxuT606DqBf0FfPYnUukwR+d3ZuX?=
 =?us-ascii?Q?9sgAWUdWSRNl3ltYs3J/ThFlUviwgouewPY7U3V2gzrtH7GV9BMfq7ak0Czb?=
 =?us-ascii?Q?zGR8EYonCpcWBg9G/8j15FDwluqoby39mpUXxIWHXtDJFEiTQBAT7QhYTPJW?=
 =?us-ascii?Q?Q2rsiVwKwaxFb5ze90IPSoUHm5OOdky1m+t1OxCBN+qxAz3Zq4ALBJy6gR25?=
 =?us-ascii?Q?PxpCN4xM3SbmrWLhPdbdMaQN0gZdcuQhrOKxpiZvTAuBqAA5hB9gHMXYcOzj?=
 =?us-ascii?Q?vSJC+neAl/fV/SqBYWNz+wzxekamqYwE6YkAoEsR3rvjX8bw3E1KURegHiF1?=
 =?us-ascii?Q?db5Uwln2UjD1nEIuZy7Y5ic4ZAE7QXtnOdQac+3HDdaaDYmpOdUSVko6F2Vb?=
 =?us-ascii?Q?WObfN2nL6yd232TvybdY7bEnFbUOOr+LTUjz+3/bh29GsDe+ETHy3heZVsn5?=
 =?us-ascii?Q?69SNGfPRgrFkJ2W3F08CIZ12TxALErCeqkcezFwprLk1EmKVTCosZ8TTd+jg?=
 =?us-ascii?Q?1M94QL/fWbwMxpXqPcguhkeUt2h1TG2yas1xhb3UdxQOwl4BM0uAA+yioQhW?=
 =?us-ascii?Q?oXi1MhgHmjyqQLYhJmWMSyuT6OFdJSGfOhZF5mLoPSRF03Tc9awvrnIBYnbv?=
 =?us-ascii?Q?hbhfD3+KNCZxqZ8G1cj2bOzpAF663ZzFOT9C6Vw4ULyQfCrW7pxsiWAXzxpu?=
 =?us-ascii?Q?aSpJ0xp/dwyPW0BIKnqHvQYOuZwYW4Orv+feLaDiOl+5TW7PzG4dh4ZnoXCa?=
 =?us-ascii?Q?B1ekrgTw8uBdAaknXxg32Vp83kGMbxEMfQ2ozWCgYHNezYTg2nUfXZjCHBfY?=
 =?us-ascii?Q?RhRohduoW1+r5OQN3Uaj4WN6vKBcAVM+JG76M6NPYGEE8uHAh6YjipV1Wrto?=
 =?us-ascii?Q?kcRddMgxkwmXjOUbU0MHb98fhUsIgKfJXAmtksC+Jddv50ou4MI2hlz9X/tY?=
 =?us-ascii?Q?1APvuAxjXE5rzmpbcc7su/iWvFvRdV827oU7YRRBpe4vJ28KSumw8e/xOJJ+?=
 =?us-ascii?Q?PNaTY3T8CmK/I0kXfp7uOytMY8xu2Kts1/NxoJZ+8Ae9Blgq5/9NZ46mtjnz?=
 =?us-ascii?Q?8GsWr8Ry8pqtttF2Hx7KY/GgtcgR1MrsG0ZLJagdcBbSM71Z6H6cg6VqPK8w?=
 =?us-ascii?Q?g+93hiO4Il9GoWz7tmpfDu7MATGVjr5/z1Uu1sTtrrC+PRgUnXWY/fFU2Ean?=
 =?us-ascii?Q?YgUS47fKrEhYPgJ3+xqhOqKYhpFvm9+q/MfRO9LlnfQ0xHh0GFzfnAiN4Aj2?=
 =?us-ascii?Q?G2rkHvELu1uqF9eiYZZgjSvN0CQXPWC/s8lqHPZP4y/RPrbL30Dmcvayvx7z?=
 =?us-ascii?Q?KcgBddO8BwoCMGZWWITFqoQNCW7yPLOX9AWFS6e7AlntXs33r9vmwuHzMpun?=
 =?us-ascii?Q?N4cl40vDwGS0TnsBq3y4SAamgdxH9dbNnTODnIo3Bi6t368VDxvQf5EfI8bk?=
 =?us-ascii?Q?DlPq1Oii/A=3D=3D?=
X-Exchange-RoutingPolicyChecked: oQwOOIvzm5U/GU6/6Zj0E60zT63PmeVseMqIQoyRytqCusD28jeWc2ED3QuGvaeoFbfINzTVrfQ3nA0SKEqMZjXdizq+2VW6IpVMYp0KdEH/D+rk1t7KIpVIohZxbeeI1CsEjdrb/+wuPI/Y4Td0G5ax/1Vc1aN7n9QPoZ7j2uOUcJ1nOW7UhsJknYv2ExmcTdVa/2xUNq9Y04VdvWQWN2fxkAIwgSYdmJ0pMoNf/8s1JQIn4AZdy7qgOb/00on+ZG022Jo/E1iehHYAHC3fo2HptMGiQu4KB9TZaMnNGWrlD+hw0dxMVogNyFDBwhWstRestFRJtnCFVaV6QNN/fg==
X-MS-Exchange-CrossTenant-Network-Message-Id: ca08484f-1486-426c-75d2-08de96dadc5d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7457.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 08:26:28.0101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: svNMtoPkzKMRL3Vo03rBuYHpNim5LnxmxEkQ5ljoRvWQa0HZwm4aLMMjCvTeVTV6E3UidSHANC6EzdS6uAxtFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6850
X-OriginatorOrg: intel.com

On Thu, Apr 09, 2026 at 11:48:28AM -0700, Sean Christopherson wrote:
> On Thu, Apr 09, 2026, Yan Zhao wrote:
> > On Tue, Mar 10, 2026 at 04:48:20PM -0700, Sean Christopherson wrote:
> > > +	default:
> > > +		WARN_ONCE(1, "Unsupported VM type %lu", kvm->arch.vm_type);
> > After pulling the latest kvm-x86/next, I encountered this compilation warning:
> > "arch/x86/kvm/svm/sev.c:2954:30: error: format %lu expects argument of type long
> > unsigned int, but argument 2 has type int [-Werror=format=]",
> > 
> > So,
> > 
> > diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> > index 75d0c03d69bc..ca09c06d1e80 100644
> > --- a/arch/x86/kvm/svm/sev.c
> > +++ b/arch/x86/kvm/svm/sev.c
> > @@ -2951,7 +2951,7 @@ void sev_vm_init(struct kvm *kvm)
> >                 to_kvm_sev_info(kvm)->need_init = true;
> >                 break;
> >         default:
> > -               WARN_ONCE(1, "Unsupported VM type %lu", kvm->arch.vm_type);
> > +               WARN_ONCE(1, "Unsupported VM type %u", kvm->arch.vm_type);
> >                 break;
> >         }
> >  }
> 
> I'll squash the above.
> 
> How did you find this?  E.g. did you cherry pick the commits into a different
I just pulled the tag kvm-x86-next-2026.04.04, and compiled it with
"CONFIG_KVM_WERROR=y && CONFIG_BUG=n".

> tree or something?  AFAICT, thanks to commit 11bb4944f014 ("x86/bug: Implement
> WARN_ONCE()"), WARN() and WARN_ONCE() currently don't have any validation of
> the format.  I posted a patch to address that gap[*], but it's driving me crazy
> that I can't reproduce the issue without explicitly removing the definition of
> HAVE_ARCH_BUG_FORMAT_ARGS. :-)
I think it's because CONFIG_GENERIC_BUG relies on CONFIG_BUG, so when
CONFIG_BUG=n, CONFIG_GENERIC_BUG=n and HAVE_ARCH_BUG_FORMAT_ARGS is undefined.

So, in my env, the WARN_ONCE() defined in include/asm-generic/bug.h under
!CONFIG_BUG was used, which is:

#ifndef WARN
#define WARN(condition, format...) ({                                   \
        int __ret_warn_on = !!(condition);                              \
        no_printk(format);                                              \
        unlikely(__ret_warn_on);                                        \
})
#endif

#define WARN_ONCE(condition, format...) WARN(condition, format)

If I turn CONFIG_BUG=y, then WARN_ONCE() defined in arch/x86/include/asm/bug.h
under HAVE_ARCH_BUG_FORMAT_ARGS is effective, and then I also need [*] to
trigger the reported error :)

> [*] https://lore.kernel.org/all/20260409182941.1912856-1-seanjc@google.com
