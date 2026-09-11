Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010024.outbound.protection.outlook.com [52.101.61.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D49371885;
	Fri, 11 Sep 2026 17:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789146288; cv=fail; b=h6YSAizZT1gG9HIP0mYMVhRd3f6au2q5e8uj6rd9FqMhhn8228sj+NSsVkoBPXAMddzH2FFTgiXNUzepBNiq3fjQZABRNHEyWNK9delomv/FUpsj3/oI/bt0W1tDzWbyJ+rPdq3IOBi0LdSha5JbDOonK7tzyF/c358eIRITzCY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789146288; c=relaxed/simple;
	bh=qAmxoerrqYcyq92GGYu2xXwDKPCl4+JcKNKizfEMEHU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=gZwJS1SxZIPVpZevhHwaQVL0MKFrS/dF1e+KLgOOELQk7jOMcvA6+Ig15IVB59OleItue47rCdLrki56dFwzBEmTVw5ijCcTh8nH5NRwFKQy8kTU8gxsH1Xn1FXWkVGQAs7LhseTlsgeDPfYvzsY+QPYH1xK0LC+lP848uex7GE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rA3oxoPf; arc=fail smtp.client-ip=52.101.61.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rA3oxoPf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t6oi0PZRP1maD+Y2CxZ7wSXwsmLka87p82WdCBUtpopJCtnCTZs48cgjWzHaEFHBgIieOjdI1ZMF2aBPKelXLHN4L90fIi2+vJtO4BWgRFhkpZqmk0nbihqvi8HHcB1+aptjxG9GUFEuB28KGIok2W82I+t+dUhGHXRDm7uaurdhumQmGXoTRMP+AJhaeUlXF9E4HiAKOKelDQxkaw37wOXfs0wxUbxlHus0XEpzsubaNKwirsLzEmfDOKXMon2xlt8xLoHewzpOu+Z7JJTg/M4TogRxpcItKmL5LpBWI42ya9wVgPHDoKfDhDroPT4E8a/3F/nv4Wwr7Nnz7/wV9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HD1baymJOvJj9f55VZGilpM8UmMsYC890hvcCdZafW0=;
 b=HgeKcGDJiwinTuSL09eDFW7hQW43V78gp7AkD6qbBAyV55Ps4GPFFPZTtiuKn5OQ0cqjz8mr7kaqsI+W1N+egV7t2RqQsx+U1meUpug69eNETsrvwMkO5a2OcIlvYetnoz34XrY5j6T/zNO99Cg8lo5m7++bqCYf2oLd2lZwNK2HkSNBhHxVs+a3jOwov/S5xCkDHwz14h//JdgE1+AK4GKrwavEXv/5AB33PeXrTRaWcedjX6r+/P020HmOYfg/+5jWQwa1LQybT4fJMOr+3R3YBp+S+fnNS6KrbSGm5+Iya9bQG+5Nqr8rC80wJmCJZYAy0D6wqFteZjesHNUfWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HD1baymJOvJj9f55VZGilpM8UmMsYC890hvcCdZafW0=;
 b=rA3oxoPfeF+qaee2QqPJKDSfKccjhpAAicM7krnKErVCKxVQoMdF2mXDXK94T/nv8qOsfRHgQ+JVCg1UqI/XIWiQoK80whDGnNbOWfTWSvj4lYbVI7AJ9vUtL2//L4mOXGfR+uzD4tnhVNEdxX/q5GfVHFcbDy+mkQcT9dJWoA6mirXNzR4te4b+VlKdPuhVAU7QDFKSZcoeQjE+V+xnYDsQHK8fKEJoA/moZREAkH+17th11wjdnk/NcV9Se+NA+nNYPx3Pqbc3RzpYr8wUEJXThAJwrfn2IOBsKjO+lKqGvsJFE1np1pHiBdELyTx3VqJhRhAUkPoMYRuyj9EB7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9411.namprd12.prod.outlook.com (2603:10b6:408:215::20)
 by SA1PR12MB8723.namprd12.prod.outlook.com (2603:10b6:806:385::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 17:04:40 +0000
Received: from LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15]) by LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15%6]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 17:04:40 +0000
From: Alex Williamson <alex.williamson@nvidia.com>
To: Alex Williamson <alex@shazbot.org>,
	kvm <kvm@vger.kernel.org>
Cc: Alex Williamson <alex.williamson@nvidia.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Yi Liu <yi.l.liu@intel.com>,
	David Matlack <dmatlack@google.com>
Subject: [PATCH v2 0/4] vfio: Fix cdev second-open and harden selftests
Date: Fri, 11 Sep 2026 11:04:23 -0600
Message-ID: <20260911170429.1642480-1-alex.williamson@nvidia.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR16CA0026.namprd16.prod.outlook.com
 (2603:10b6:610:50::36) To LV3PR12MB9411.namprd12.prod.outlook.com
 (2603:10b6:408:215::20)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9411:EE_|SA1PR12MB8723:EE_
X-MS-Office365-Filtering-Correlation-Id: f51921ef-4038-472b-643e-08df1026c41f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|6133799003|18002099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	JZT6YCH1u5KJhDL8e2kWjx22ZadRr4yVRy7RGZ9f4oEMdQzsP5HLCIBTTolseArUXO0crl+Eldi5c846OHd9yyLlNb/O2KzWFUlTjASrhEI4QpEMAUdqC804otVr6uBWWAxUO8arbbfbbUGukvP5dSnZgNfoRUPKnGspO8ofYLzw4rL1eRKbLH3sIc7PsBIOD4gAkXzqOgkIIdzWjFOvdQMswVczjug3TgOqJsfc+U7skQ3AVr6SJPudovHE58lO/02RU/LdaUSazbVJoBEzdcnBALRPd6GfVmIG+bTZa1J5ls0QwN5J9S2Q02UiCpScllCl8opUbXgbdRQHDIj16vRcjby+vWGTlSZV0bsxv0S+Jssans6kIigxpDZ3T8snksm4PUTeDbOxogg5339tTurS9WK+tYn4vCsJSO4q1x8Z0VpiLsa2J17pFbj/G3WPWJ+Mmri6Sob9Q/rJMRPb6a8dovu6lhTxsTVnc/0DJlVDVlczdIWneyWLx3ZwWO4DRL64NX0xiaJ0asHqSopEBlzM8QHMv2jxu4O3R5ifn220hyIGL3Czo+LSsOklzQGTmvTfodvG4baZpEWgbsvLFXrIzjqnVN9HNY+GabfNr89S0zkrO/yD/HxizhSK+hjd8D114KiHUVLBI+KL6JmsMNF0poBBaYVmd6vYCqvEmqg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9411.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(6133799003)(18002099003)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rC19elas0sjLvnZIa5y65ZhcYWCwhB0ICZfdtGjp1nQaQNfowSDRXyZX0Xl3?=
 =?us-ascii?Q?P7a9ds1vNTweXx3d89xozeBK4Fx9+CKyjPRywzf7g3jwE8uQPGe9ZYokBUkV?=
 =?us-ascii?Q?erbVXliod6WZ1GoC4EXD+DlqL9Vb9qwREDp7DdNU7kOKMdJFuaUnoJwqekBf?=
 =?us-ascii?Q?WQW8c4iZkCyKcZHvLZpAhb2XZ8Fo912wokgPMdQahd4Ptf3jYisp80F+sxcT?=
 =?us-ascii?Q?qx7XdSnDwaEZRQRM5jghroM6R6q5xsA4VQXvgQcyZA8/RqbG8Cm0H9ltYZix?=
 =?us-ascii?Q?RGAJunM3t3i3e8cHq1GPogOfZDJQkbwLC+OaArEibYA1AxGSn7vxiY8P7pYa?=
 =?us-ascii?Q?EUDhKqylAu1xaDUc1x2BxY4qjvOxFMgVZwtjFZQACaPSnBvIcx8zBn1DXpUG?=
 =?us-ascii?Q?BV/5gcCStMX1xCHZdmZt6quVolBtgsNwSZSTgLxknr1sAuEoK01NkXzIzZeh?=
 =?us-ascii?Q?Mrc6bQkAUAcE2JKsbeZgNRHmjH3yy+8DBMv8nq5nGSxdaWi/kkNgJc+dR0C3?=
 =?us-ascii?Q?Iqsp1lgYxy8eopCi1/KHwYDzATlHICNQU8QlvbbXcI+ILHpIzceyW50V7WMy?=
 =?us-ascii?Q?AZDyOBlh13Ni2CeDDwXD6PjJejaNERXSwAkbQmxkYzfE3tBZHurQzF8Ik74F?=
 =?us-ascii?Q?YzYUvxHvQ0jfGfrzBew7L8ZDE8XaurntWIgZWmE7IJUTZhWf1q2rUwiAhJU+?=
 =?us-ascii?Q?D7eKvkkWvfXOpadg+pkITBzsDAepCZL+i47ke1V98aQKob5EsXlI1UbDaCfQ?=
 =?us-ascii?Q?WCP/wbzxaRg+1okZhksztiEAuNxYc0zF4VgSu//8XWwTmaUFHazMLXVCFFI9?=
 =?us-ascii?Q?Xkxl/QXxwUA9vnsBTOBLn0DIvEeqlJDwSSAeizVlQh/4UcpnbZOMXgjujQbx?=
 =?us-ascii?Q?GXNLp5Gc751t0zhr0dz+jgxEGAWCLbNMpLte+5MKeFVm9lRAI2hX+rd85x5Q?=
 =?us-ascii?Q?vXAdw+BL8bbhSQMeX78Xkht6ZWTV53QnRK2RDxvZFf2AIk8lwdCRkbvQUw1s?=
 =?us-ascii?Q?qNTysx3cknB3toBO6Fy4ZUCioTg4wtMhlNNxzv1zxGTdVkpfQYkLV0S1fWI6?=
 =?us-ascii?Q?ClUncVnMREpeYYRrBjkM0lhXYTiVNDCaZejh3hfSgqNku9c93/VYmoFh++hp?=
 =?us-ascii?Q?q6GflHwoPs2pG1PqXFZh9c7aDgjdRrzFSxEAv+r36ZKFqt9kyve3c9fhh4Zz?=
 =?us-ascii?Q?5e86LINYfr1hSpRRLJ5IZiXMUmj8k8+gzkHmfUdOMirmhe67TbJ8PjUIpc5G?=
 =?us-ascii?Q?9R1wdj36SVuxHb8uijGUqiq3dH07bihQbfbnp+G8cciMoFiMJT9qQUDCzA8n?=
 =?us-ascii?Q?pTLEYJwmSo90xgvSkb2tu78foU5pzUyyqvY5WKTyQ91Etxsz4nHQUFEf4cMU?=
 =?us-ascii?Q?+ro9bfDQxqUXxbrr+ymK2DHQuajQhq3vV/GkhzozdNnf+NtRPFfK0v2Jx5sD?=
 =?us-ascii?Q?JFpwuN8BcH8m1uug51NBursKpXarJLa9MBIMgaYWJVrbhRVK51ufqTMNCEFh?=
 =?us-ascii?Q?NW+/zUV4d5OqJDfof3Cn1AnLvpm+rpucBU/t470Y1Wffo8DfKBXA86rLIpDv?=
 =?us-ascii?Q?VeT7FOyB6TcE1beHaU8d3ehcuJpteMoFSfSz9RwGwDewkxpaW3DGG5fZzZbn?=
 =?us-ascii?Q?u6ZuZGZdMVbzibz33jC0pM82ogFKCCc6Rm4lHmXFySdMHkueRbmTC8N8Nj/9?=
 =?us-ascii?Q?+ZMsolsBmQDnPOwWVYFJEDsvNtuwTFhoybTN0jfHkdAp8e3zeLpA5ByDzlcv?=
 =?us-ascii?Q?m+BMpNR/Ig=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f51921ef-4038-472b-643e-08df1026c41f
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9411.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 17:04:39.9591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9kQ/x1u6r+jU+sgfqvUqkI6x1V71aZqKyiN4nAnBjqMtmg2qDpUPUK2dXrARrjhQ7T3/rJPllDeP4bck5AU0fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8723

v2:
 - Re-try on -EBUSY reworked to harness issue and posted separately[1],
   dropped here.
 - vfio selftests subjects updated for consistency, Reviewed-bys
   incorporated, Assisted-bys updated to current standards.
 - Added the selftest suggested by David, but split it into two tests,
   one that validates vf_token is not clobbered regardless of the 2nd
   bind errno, and another that enforces the -EBUSY expected errno.
   This allows us to observe that an old kernel fails both and avoids
   conflating the uAPI expectation vs the underlying data clobber.

[1]https://lore.kernel.org/all/20260910230254.1198094-1-alex.williamson@nvidia.com/

v1:

In porting some testing infrastructure to a different system I found
the igb selftest failing in mix_and_match and generating a cascade
failure through the remaining tests.  The difference in the new system
is the firmware error handling.  When the igb device gets wedged due
to bad DMA in mix_and_match, we need to FLR the device.  The igb holds
transaction pending asserted for the full duration of
pci_wait_for_pending().  Meanwhile, firmware based error handling is
triggering SMIs and stealing time, such that the 700ms total delay
in pci_wait_for_pending() turns into several seconds.  With 10 cases
in mix_and_match generating bad DMAs, the transaction pending delays
alone push us close to the 30s per-test timeout.  The worst case I
observed for the total test was ~45s.  Increasing the mix_and_match
timeout to 90s provides plenty of headroom to get a passing test and
avoid the cascade failure.

When the process is killed via timeout, the release occurs through a
scheduled fput(), which is also delayed by the SMI storm.  Each
subsequent test then sees a non-zero open_count (for the group open
in legacy mode or on the iommufd bind in the cdev mode), resulting in
the cascade failure.  Group mode already uses -EBUSY when the group
fd open count is elevated, which allows selftests to interpret the
failure as potentially transient and implement a bounded retry.  The
cdev path instead returns -EINVAL for this case.  -EBUSY seems
justified here and allows userspace to have compatible retry flows
for group open and cdev bind operations.

A local sashiko review then found two existing issues.  First, in
analyzing the exit flow from the iommufd bind, we can see that the
vf_token and kvm pointers are clobbered by the second process before
the open count test.  The open_count test in vfio_df_open() is only
for the cdev path (!df->group) and is called under the dev_set lock,
so we really only need to relocate the test to
vfio_df_ioctl_bind_iommufd() prior to vf_token/kvm manipulation.

The second existing issue is that when executed via the kselftest
runner, all tests have a 45s timeout, which is the cumulative time
across each sub-test of the execution.  The pci_driver test already
fails this with ioatdma, nv_falcon, and obviously with physical igb.
Running in parallel across both ports of an igb on the system prone
to SMI overhead, the worst case I saw was 450s.  Therefore, we not
only need to extend the mix_and_match timeout to 90s to handle the
extra transaction pending delay, we need to extend the default
timeout to allow the full pci-driver test to complete when executed
via the runner.  600s is picked here as a "sufficient" margin.

Please review and comment.  Thanks,

Alex

Alex Williamson (4):
  vfio: Reject a second cdev open before mutating shared device state
  vfio: selftests: Verify a failed second open preserves the vf_token
  vfio: selftests: Extend mix_and_match timeout to 90s
  vfio: selftests: Extend timeout for runner executions

 drivers/vfio/device_cdev.c                    | 12 ++++
 drivers/vfio/vfio_main.c                      |  7 ---
 tools/testing/selftests/vfio/.gitignore       |  1 +
 tools/testing/selftests/vfio/settings         |  5 ++
 .../selftests/vfio/vfio_pci_driver_test.c     |  2 +-
 .../selftests/vfio/vfio_pci_sriov_uapi_test.c | 57 +++++++++++++++++++
 6 files changed, 76 insertions(+), 8 deletions(-)
 create mode 100644 tools/testing/selftests/vfio/settings


base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
-- 
2.53.0

