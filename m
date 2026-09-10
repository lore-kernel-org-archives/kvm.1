Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012001.outbound.protection.outlook.com [40.107.209.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145DF49E122;
	Thu, 10 Sep 2026 22:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789080639; cv=fail; b=DShaAg+8rtTPl9NiJTaRQb6yMCVuwGM3YwDmXP1djZbFnSdFq+9b53C7hbZkHiqLLr3PUborGaGe7KohLJgXHsDxQaHAwtNYGMls+2xz5kOwh6B5fnsUv0galgRmWhIl5xJvHt/2MzU6VVVF8MoYxDCHQMst/Dx0hbldlGu1eGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789080639; c=relaxed/simple;
	bh=0E80x3L9bqd1Je3f6dDWG3bk4X+pC8eH+Q0jXyh18lM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Uh14dqMyt64uIecC+jSHU4cxxUpuE4DxTCLrQk47jK2XazbNEks+kLw847MT1XVcgPTYG55We1HzazLw3k1tmzeDxwEUGf0TGo52I+RqMqhCTAnDzn0qFjzbyXTuZeBVBjyNQ3O/tAYDNdyVQPxyB9KuXE2tx1c8+gbBYPtFXts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=R2w17/6S; arc=fail smtp.client-ip=40.107.209.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="R2w17/6S"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p6eLhMyijS8LwqWTHbiLohwCiG7474BWYCdiZ6E9Fb/gQTnIrvYKyuVPzOpLuv9lkJGH3fjQ4woJ4ObkE40izdr1faWa2HUFm0r/TncM6RRAAnSLL7qEVwhncdUxler042bal5ebJMD3qvzOE02skwXQ6GXjMo7WYqS2nfp5ZosM2bMM1qev49rB3UYhbZzCU1fdQ2UJnI2mf4L2ajUozi8XU1K6KI/APgin+Fl1iAor7UYt+mLrUyzgNC92o0LCpllsxjAK+IPPxYJyjmylRbS6D9YHLOJKTgUzPnSQcU//lKUn1/hUhwXyiXxWZzbiuEEPxvBHvt54vq7zcujCiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hRrrFu33y23h3eWeQu0e27HPy/KK9gjN2Ne0gediGZU=;
 b=tsbIYFtwaEW0l57OIzvzVeZzcZ86wfGj19+g7wOOy9D/az6hgXHYvK0M7Oa+5N+VOGAZ8ANfIAFlA7zboBjV7lStDuHD/iyOt+a+4gwtieyItZ5bqGZE0UqC784C3A7AbD1f7+xxW0XNC67LIpIZuEuI+LZgG/4iYS8cI0jtHG1N9c9xo1W43Gsy+k1by+lB/mEfVPyHkxk8WJzNFh+5N0hTR4iXlY1hXjEN6eU5HHq8wsicPoD3A4C1HZKi7a+QPpbXElbyC0KdmIdk0lXgZAyluCKDFrXBLm2eZKU/+KIjoed9Huh5uyJToC+Dv6lqQUHamHXpdyLpW+UREydHcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hRrrFu33y23h3eWeQu0e27HPy/KK9gjN2Ne0gediGZU=;
 b=R2w17/6SfoqxyiwyOdSRK9/j9Zx23QHm3ktqs0aenR92lcj5/mg2Ehc+sRIHSsny7h+zsocPsJulU0RHZQNL9CRTxQeLvWMhHJoPNMZsAkzF0RKWbWm7tmiuYOGRgTyrE1F5cf4iil63/LgIeExoRmyVbdtJMUpnj0IpDNfOU3BZNpUpWrMxW/jp532XJ3HWMa3wXlLmCMyIQtW+H4UI0wOPZvS28q0wuqxvsbn/50tcidgG0iaQwiwWqgKsLn/UHQQ0plSPTv4XWyjFs7LUCgnezO7bIE7+PVgZhXoPGRlt4k+cnvm45jJBNEcOfakukAUrPzT3us/C10+9WwM4SA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9411.namprd12.prod.outlook.com (2603:10b6:408:215::20)
 by SN7PR12MB7955.namprd12.prod.outlook.com (2603:10b6:806:34d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 22:50:33 +0000
Received: from LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15]) by LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15%6]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 22:50:33 +0000
Date: Thu, 10 Sep 2026 16:50:30 -0600
From: Alex Williamson <alex.williamson@nvidia.com>
To: David Matlack <dmatlack@google.com>
Cc: Alex Williamson <alex@shazbot.org>, kvm <kvm@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, Jason Gunthorpe
 <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, Yi Liu
 <yi.l.liu@intel.com>
Subject: Re: [PATCH 2/4] selftests/vfio: Wait out transient -EBUSY on
 open/bind
Message-ID: <20260910165030.3d5f2c06@nvidia.com>
In-Reply-To: <aqHSZY2IhWfK-jhl@google.com>
References: <20260901215358.2421359-1-alex.williamson@nvidia.com>
	<20260901215358.2421359-3-alex.williamson@nvidia.com>
	<aqHSZY2IhWfK-jhl@google.com>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR02CA0023.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::25) To LV3PR12MB9411.namprd12.prod.outlook.com
 (2603:10b6:408:215::20)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9411:EE_|SN7PR12MB7955:EE_
X-MS-Office365-Filtering-Correlation-Id: e03cc1f8-10c3-478d-567a-08df0f8deb97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|6133799003|10067099003|4143699003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	hduImsMaiQd/5u3WSYGVO+qwIuZrmk2k9CASLzwGjJ84q09ZhRe8FmUdYyJak7CWhJiVjPCki1BaQc0oJDTVxLTWj7HynDLulx4HwRiRglCpukaDwA+GIUU6+KABMhdy6cfgm+p21Doz7l4B9U64h3X6GlumRp+LhZG7L1byP3Qcjipz/BSnlQKqF2m50Cqy73hnOD4IE5ivVqq5x9QseefQeZg53o7q7UVlGiObxmA3kWmxzgQIlHJuGbr096Yc66ZpV9odDxTEjhItQAjuWQRj+24NUJh9Vltw6kVFdsNGD/PDv9e24Dx8iAzqZ9C/LnFrr/wqdSSBvm2dVCuULg67cbI1nrvEEkhtpntLTI/aAq5bTCgecfuYmJoRmwHZDBbvb3yxi5e/TYRlIlwlY4Qqt2boi/CS8+1ZmPOpBmoD0Fvju68GQNZ2vswjmArrFK3GLuNQzhL0apumYACQ3h/UQAMmbPg/mpKfWFom2D1EeZ99hW0BGliIqRWIq9PvIA3Hx+kuxnE2Fu3Vb0sqvMi4kvF2RwjQL4Lwf9C2T5tEbyNk+VQrzt31mo7IO9IPtR512051qnfHp4+9vC/twOURp2fpv8brpH0Kpcjc/GePJUm2fOkYpVGeXeb1Wx0ve3SMEH1lXvGYd9VBC7DYFR8E3WTltce51dVqF0H9UVE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9411.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(6133799003)(10067099003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rITBQYbUEgdkDC05LbhZlpPXnBjIjSmXDlqSa7KlliOnI4Sioh+YEu1TRHta?=
 =?us-ascii?Q?o5LslNkSPNV0a2ArtFeZ/s2VmrufHeuC4b2ahAXNit4HqWDjn1EBgRe0gFbF?=
 =?us-ascii?Q?rMFkcVWYxNeLJPij54NmPESiWhNam4qgCeLEkaH+PRd7Y+GLDi3f3iwe5FK6?=
 =?us-ascii?Q?BExYaqwvpufUyw50siqtjboKB9Ga0goXBc24F5NvNUglppSgKWOV/WkH7ypj?=
 =?us-ascii?Q?fLkI9Ty4lnCcdVBeoybrsAAk9H3vEuUqGyBe52QDKm5YopTrgGGQ8f9CtzV4?=
 =?us-ascii?Q?lPgxyNFCtQ2KciOhtgUDQFrNTYCpC28+BUW5sJpvdMEHN7gA218iJPk96jME?=
 =?us-ascii?Q?0dmlkYVGD5PeyYbPdUr/SyeQxLcekleNUmBZm7O+QcdUk7af55D5j2LtaQEl?=
 =?us-ascii?Q?zX9C8jnBzd264b9RVINgYkT33XeSB4rMmG2RQphfxVe5zYBqG7OqSKUK8Gt4?=
 =?us-ascii?Q?vG71vRJiUsE/CLeGeDhGzebEGhICMH4jIIRQvD9HxFNOIXdeGu53BpfwF3xx?=
 =?us-ascii?Q?rQibhxJYE9dcQniYHgzlBQFTDal8LxNOtlV9DuTY3DtsdG8YOlSwkXaTwibK?=
 =?us-ascii?Q?7M+QNC8IY+ISxNTdVH6TCtSsXirt42pFvXxZ79zORqev4T4JHWDkDCfCZpIJ?=
 =?us-ascii?Q?VnA4PXvh0U7Gl3ystuRXE7rhbx6TFnRZP7/Wb0rAA/Zj2bLhRqfXjg3Qa8WT?=
 =?us-ascii?Q?LOoxh+p1l9R6sQx7oG4TEyRcLImbIowiohjMCcMBjqhUqnX5J8kplz8h5e5m?=
 =?us-ascii?Q?lIbENaT6ZBEc2L+Ung2zSIQQzSMXHvtwU2yOIycmUHqe/LDJw67oECb2fMIt?=
 =?us-ascii?Q?SQcGMdOuH1DvFeajZ4IoqbgY5/8OgoeVFXPoc9olOr1sIvsch5b43HUJtRrR?=
 =?us-ascii?Q?ytMl+XzL60UiMtok8bT23XGP1DGxjiQLlcZcEImqrmh/k0cS8Is6cxxLGEva?=
 =?us-ascii?Q?5JQnXEN00nkRTaeT5ssnzrYl5y4GdiYJwxQiVef+GReI39cgadQoH5U8MkIZ?=
 =?us-ascii?Q?XJtl94MP7Kx0RVkgTBKg7jxGIimXvcfS/FWQb58nhk2AEmL5OA3EV7wrEiAI?=
 =?us-ascii?Q?97MOAwJCd/sxVvbkIb4o/Bl3mWpQXvTiVjd1rrEzLbiQ6sehpznvwhd5VzD3?=
 =?us-ascii?Q?dWP4NXM4q2cg8kBOgrSwYybWmHkxYaLnbm8M8mgN/KhhrdesDJxI8ZgiZx2l?=
 =?us-ascii?Q?QJ80tPUTw5xEJwRudkGpY4d1UerViTpy/Ecnar1JcxALl0pDB29v5B4f3STf?=
 =?us-ascii?Q?G19muozfC46e+SOJgpioW/T+aGdjudpODsO+JZCSZAqFUOF+J2dN22ppyiT1?=
 =?us-ascii?Q?hUrbh/S04AAbkd/kkyXfjrcOXAw2UHMi8WbsMxHi3bLBg35BA1qMLmi8mJq3?=
 =?us-ascii?Q?tyXEeW8rVFWoWkcsMlKvz0lT7R9ab+lQWEgGn8n0BdY6j5ffD2au8r3XCbGk?=
 =?us-ascii?Q?7JU8oN+Jo9ohymuL+9ZLHkM1ir+ozuVBxYDaGk7ckN0q70P/wlwXK+UKsaNc?=
 =?us-ascii?Q?oLmn1/4eZLXqdo5N78DF/xuZNwS32f+10xElv76PSTC/zzP4xNABmmdUseUL?=
 =?us-ascii?Q?XrwXdbg4y5ppAyemQhAmn/I0O8wYkWaIAqsks9fNRwcl7XQdJ9Lgk8kIoT7Y?=
 =?us-ascii?Q?Vq3yaYYKstP7bo9/5U0X+8Uoj74szMt8JJWRFwslWkCL0Pt8QGZDuoCEwLf/?=
 =?us-ascii?Q?mWrmgZPa1tuZVbtnb5QbUoUfxjkHnwj4ZldMj+wxwmXgcXHN8E3DKWsqCCkI?=
 =?us-ascii?Q?84vGsu8XQA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e03cc1f8-10c3-478d-567a-08df0f8deb97
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9411.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 22:50:32.9513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XWU/WP+XV6NSidAv7mH+fjOtHVueZ97mhPS0b+kIIBEFXEbaInyHice0I190lenpjSHKI2RcozXJAkJtbueHBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7955

On Wed, 9 Sep 2026 21:40:53 +0000
David Matlack <dmatlack@google.com> wrote:

> On 2026-09-01 03:53 PM, Alex Williamson wrote:
> > If a test is killed, for example due to timeout, fput can be delayed,
> > allowing the subsequent test to be started while the failing test still
> > holds the device open count elevated.  This results in a cascade of
> > failures as each subsequent test fails on open, blocked by the single
> > user requirement at the group or device cdev file.
> > 
> > We can make the test framework more robust, and allow better
> > identification of specific failing scenarios, by waiting-out transient
> > -EBUSY failures on group open and cdev bind.
> > 
> > The 20s retry window is heuristically determined in testing on a system
> > where scheduling can be significantly delayed due to SMI handling of
> > platform errors generated from the mix-and-match test.
> > 
> > The SR-IOV uAPI and IOMMUFD setup tests retain their non-retry bind
> > paths as these are not expected to encounter process kills due to
> > underlying platform error handling variability.
> > 
> > Assisted-by: Qwen3.8-27B
> > Signed-off-by: Alex Williamson <alex.williamson@nvidia.com>  
> 
> I think we should fix this in kselftest_harness.h instead.
> 
> If the poll() times out the harness issues SIGKILL but then does not
> wait for the process to finish exiting (waitpid(..., WNOHANG). If we
> drop WNOHANG then the harness will wait for the killed process to exit
> before proceeding with the next test case.
> 
> diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
> index 1e459619fe86..150bd690ca7b 100644
> --- a/tools/testing/selftests/kselftest_harness.h
> +++ b/tools/testing/selftests/kselftest_harness.h
> @@ -1008,7 +1008,7 @@ static void __wait_for_test(struct __test_metadata *t)
>          /* signal process group */
>          kill(-(t->pid), SIGKILL);
>      }
> -    child = waitpid(t->pid, &status, WNOHANG);
> +    child = waitpid(t->pid, &status, 0);
>      if (child == -1 && errno != EINTR) {
>          t->exit_code = KSFT_FAIL;
>          fprintf(TH_LOG_STREAM,
> 

I had done something like this when debugging, but found it
insufficient.  More digging turns up why.  t->pid only runs the
TEST_F() wrapper, another child process is actually forked to run the
fixture test.  The kill(-(t->pid), SIGKILL) at the top of the diff
signals the whole process group, but dropping WNOHANG here only reaps
the wrapper process.  The grandchild process that actually holds the
vfio device files that require exclusive ownership is released
asynchronously.

Therefore we actually need to wait(2) for the wrapper process to exit
to reap the zombie, and then poll the process group with kill(, 0)
until it no longer exists, while not introducing an unbounded loop into
the harness.  Only then do we avoid the cascade failures.  And then we
don't need this retry on -EBUSY patch.

I'll send a patch for this outside of the vfio series since the cascade
failure is also resolved if we just extend the mix_and_match test to
avoid the timeout in the first place.  Thanks,

Alex
