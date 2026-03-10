Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013062.outbound.protection.outlook.com [40.93.201.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3283CAE65
	for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 16:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773160878; cv=fail; b=euFnN16rE3RdcAtNi3NNTin85kAhnibCjXaAOu+UkAGUpU1hmgYE6r0onqVzaDGmla1lQgiEomPKzCPxOWoOQcIZOvWBbXYssCaneBgIUWyBzUjK14tOrHbcggZzRa5TVo4swyQ98/IEkctTWcYRbZuEF6zdZRcx6S54VebUurk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773160878; c=relaxed/simple;
	bh=1B0rSAHArVkBCSzz5JjIePJ2hfQzYIcsZ8yj628qXzg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C40+BcN4ujxuB4xCwSeduzvfHFR1ZFerAzKQtGS44sdxXNfBQcCvGXclTHTz/GuLH+8gxwPxCvWUq+XqaLD/l5FnnnH5YpvM2ckXrGzFEkB7Or7kSIVAPk+lgl+fSpT6116Wp+6VoEri3A+q5rsa8KZSLb8kyqgzRprJy7jh4RQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GR+TyM7X; arc=fail smtp.client-ip=40.93.201.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GR+TyM7X"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D5A4ghYRNfJ038VRY6ssIXz5agSHcim8/hfYk/0DdziYTg0cT9ARUKa+KXK8d+IGcD5RSaLBlSMqHOVvKby7VEeFdqIn6JSj2u1mBc2kxpPRNLx7DkoE4wakTCtmyj8DD4RDKYarmQzS7S5z47BI+RQI/ggXA4kRhaosaSmjXLrP2o01MYNk4lFHgm+SRrl138WPARAtX9YHje9lmn4mFOKZSRAUPS+br1xuwUqLHo57DkpuaBx0KOBfMnVnZFqlVm30lrg9pt9htkAHNJ5Yvmsrk0nnaihd+m9vr90gBkMepZMgK46gFzRXOzrqOjEUUE8P3zgywkHPbQLB1ma5UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+uae2Ht68ld1/ve+IOsef6jRxahrPcFF9JthsAVAwf8=;
 b=wL8pNHbwqWnfzj2AS4tqrGNKOiK7rSybLDOCkk13wKNFcsc5y3LPmWUpz8NttvnaEaCM7aIo/GOTgiBPmhPPCWl5dAhwr8sCRtQcvtijP0LMN6A/ExnvGnyD565KMhim+HBRwyqXokdFsDxQOLo4P/TMpWEgb44SlfDT5YnSPho1yEVDqJunL8//MkU7xJQ7i7+1rK6Xcd1F/xmLSDMuZowR1ndbVzbJQsXOR7vMTIN5iKfBYfkuziqJbY+v/HKaGgwXz7K2k7f17kNJn/1jktSeQig0Oo7WIu+gVWJVKLck6fepqo9Kcza8NPZMXtbcPsfU7V2G4fjSEeq7mLiENQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+uae2Ht68ld1/ve+IOsef6jRxahrPcFF9JthsAVAwf8=;
 b=GR+TyM7XHe++ADhXVipnT7B2TkYba7R9Y9OdPawFCbfbxMwXNbuSnun5VpzIRO+R1zB36+dfTQenMLBHG1RR77HzpNLNu50U81J/Xm4qGHC7773j8RkmuHDNHcqMEwDcmjq2AyIANhtRVsEqdiSz7yKvy1DRwLZ/AkKsVHHOw4YCkyMu2O092nBAZ1OOrG1Ucw0roNQzFJ/f/c5G1jhTtIn9P2Slplf/oQP1/QRu/91NEl73XWH4u6IbDh7k3QHkYmAx31+Lfi3gumhsmbfdJGdwHzDsh3e+4M4Plizu69lZ2Py5Y20WnirxGoFsLrexgx2r3Z5ZsHGJKXIz7dU8bQ==
Received: from PH3PEPF000040A5.namprd05.prod.outlook.com (2603:10b6:518:1::54)
 by PH7PR12MB8124.namprd12.prod.outlook.com (2603:10b6:510:2ba::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 16:41:09 +0000
Received: from SJ1PEPF000023D5.namprd21.prod.outlook.com
 (2a01:111:f403:c902::13) by PH3PEPF000040A5.outlook.office365.com
 (2603:1036:903:49::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Tue,
 10 Mar 2026 16:41:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF000023D5.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.1 via Frontend Transport; Tue, 10 Mar 2026 16:41:09 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 10 Mar
 2026 09:40:54 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 10 Mar 2026 09:40:54 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 10 Mar 2026 09:40:51 -0700
From: Yishai Hadas <yishaih@nvidia.com>
To: <alex@shazbot.org>, <jgg@nvidia.com>
CC: <kvm@vger.kernel.org>, <kevin.tian@intel.com>,
	<joao.m.martins@oracle.com>, <leonro@nvidia.com>, <yishaih@nvidia.com>,
	<maorg@nvidia.com>, <avihaih@nvidia.com>, <clg@redhat.com>,
	<peterx@redhat.com>, <liulongfang@huawei.com>, <giovanni.cabiddu@intel.com>,
	<kwankhede@nvidia.com>
Subject: [PATCH V1 vfio 1/6] vfio: Define uAPI for re-init initial bytes during the PRE_COPY phase
Date: Tue, 10 Mar 2026 18:40:01 +0200
Message-ID: <20260310164006.4020-2-yishaih@nvidia.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20260310164006.4020-1-yishaih@nvidia.com>
References: <20260310164006.4020-1-yishaih@nvidia.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D5:EE_|PH7PR12MB8124:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b3303ce-1e6b-4f38-79ae-08de7ec3d555
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	bjJ54UVODLO91MvG8J0/++tPPgsJGfZExvho3I4hX9EECtDjX9gc7UOBbU1V5lhg4Iqnsv1j2Aw9XVMWluVE4/KAmcRMcnOKscoFWF8+sX5HUY0kuayktmEFxi1eYxIbGpX/dworBNgRi4ixwiEwDfn+lgMNEdxLBVTn474TQClp7b+zGiWLQC9JIDkoE2MlwVlcNwKIdfqVgHaqVlVmyUl1XXCNjUdXpLZsp1WcVfL8gp3ZMEyRbfQaq8qq7YJ9P8mgChqUrJ4tAI3CTC6nSb9AO6gJo3dKEd2gRiu4yKNy3trJeGgGDomm7b71m/4hjd/fEwFgLgNSytDvV0TewUARJko4OnXJoC/pRKnJ4v3234lepOUMneOwu4j+WTsLAunZ9N690ajrny1cxLFtvB3N/zSRBulpGZZFWrRiouEbg+Hblo18CvRrExyfyx8WDvIqs2LLg3/hM+wtaQLYSgsgHfcyFI6c9JDXMnXpJJ3z0jXdjGnOcOeiBVwm90pKvJUjPEk6HtoFnHMipPCFS4rzC5IreMbxEInnJuSkKTMm9ZRcCsEcOZHA8+IIHnuI4V2YO4KEzihTLIXWntV88Ur9KI316LCAppoDuN0sfjlPJEc3YuJXHIPtYZ+Y3aUt4NWYCL9tXACGnbTC4LZCIukXbDL70xJbeBI6BQKmFUgsfG6iNli/Wp7KMzjfEGofUSUZX84PlORmYgawzjlgQC+n+PHilpX063rvtxwWr8Z9LQz8V0wXeSzQsIwI80J3Socn8TQUETmQi/9XPssTyw==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	PzmKH6xT3Od6hk39T+VbA6Fl6Y6a3whnsCKKv2l8bUN6STD2XOPyjq6C4kh5vRUmfY2gJvuGpO6DJcA/7byBI4PQvccQi0JxfeC3mEJAewn11G4GMIcOhA5/nbR4WpjoQ/HWYBAU+bNe1pmAIIUhqrycW/w1j6EmWMTvjb97uZOBULY5OV9aJOWgY9ehp6cPJMqOU1uUJNUG3Zrxk11/UI84+3Y/v48qev6p4qvux0xa0eB1FLQkG9Xz/hk77dqAKe4yEJBg7CLS5mIJ5QkUsSbFV9p1mhXASVrsyRKgWbqgjsAwN0k2uymghS2lp5lyT43qcDbze70L1I/PRSwaZD15sakVe7GZ17bvOHdR4ayNEjivekTW7PfTk001beuTKGjrxsn50Yo481LpQzqHQe6yYTRbNJp4LM7Km0sbRunyA+bCLZ7kyLVxpzVrKBsl
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 16:41:09.5722
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b3303ce-1e6b-4f38-79ae-08de7ec3d555
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D5.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8124

As currently defined, initial_bytes is monotonically decreasing and
precedes dirty_bytes when reading from the saving file descriptor.
The transition from initial_bytes to dirty_bytes is unidirectional and
irreversible.

The initial_bytes are considered as critical data that is highly
recommended to be transferred to the target as part of PRE_COPY, without
this data, the PRE_COPY phase would be ineffective.

We come to solve the case when a new chunk of critical data is
introduced during the PRE_COPY phase and the driver would like to report
an entirely new value for the initial_bytes.

For that, we extend the VFIO_MIG_GET_PRECOPY_INFO ioctl with an output
flag named VFIO_PRECOPY_INFO_REINIT to allow drivers reporting a new
initial_bytes value during the PRE_COPY phase.

Currently, existing VFIO_MIG_GET_PRECOPY_INFO implementations don't
assign info.flags before copy_to_user(), this effectively echoes
userspace-provided flags back as output, preventing the field from being
used to report new reliable data from the drivers.

Reliable use of the new VFIO_PRECOPY_INFO_REINIT flag requires userspace
to explicitly opt in by enabling the
VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2 device feature.

When the caller opts in, the driver may report an entirely new
value for initial_bytes. It may be larger, it may be smaller, it may
include the previous unread initial_bytes, it may discard the previous
unread initial_bytes, up to the driver logic and state.
The presence of the VFIO_PRECOPY_INFO_REINIT output flag set by the
driver indicates that new initial data is present on the stream.

Once the caller sees this flag, the initial_bytes value should be
re-evaluated relative to the readiness state for transition to
STOP_COPY.

Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
---
 include/uapi/linux/vfio.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index bb7b89330d35..90e51e84539d 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -1266,6 +1266,17 @@ enum vfio_device_mig_state {
  * The initial_bytes field indicates the amount of initial precopy
  * data available from the device. This field should have a non-zero initial
  * value and decrease as migration data is read from the device.
+ * The presence of the VFIO_PRECOPY_INFO_REINIT output flag indicates
+ * that new initial data is present on the stream.
+ * In that case initial_bytes may report a non-zero value irrespective of
+ * any previously reported values, which progresses towards zero as precopy
+ * data is read from the data stream. dirty_bytes is also reset
+ * to zero and represents the state change of the device relative to the new
+ * initial_bytes.
+ * VFIO_PRECOPY_INFO_REINIT can be reported only after userspace opts in to
+ * VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2. Without this opt-in, the flags field
+ * of struct vfio_precopy_info is reserved for bug-compatibility reasons.
+ *
  * It is recommended to leave PRE_COPY for STOP_COPY only after this field
  * reaches zero. Leaving PRE_COPY earlier might make things slower.
  *
@@ -1301,6 +1312,7 @@ enum vfio_device_mig_state {
 struct vfio_precopy_info {
 	__u32 argsz;
 	__u32 flags;
+#define VFIO_PRECOPY_INFO_REINIT (1 << 0) /* output - new initial data is present */
 	__aligned_u64 initial_bytes;
 	__aligned_u64 dirty_bytes;
 };
@@ -1510,6 +1522,16 @@ struct vfio_device_feature_dma_buf {
 	struct vfio_region_dma_range dma_ranges[] __counted_by(nr_ranges);
 };
 
+/*
+ * Enables the migration precopy_info_v2 behaviour.
+ *
+ * VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2.
+ *
+ * On SET, enables the v2 pre_copy_info behaviour, where the
+ * vfio_precopy_info.flags is a valid output field.
+ */
+#define VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2  12
+
 /* -------- API for Type1 VFIO IOMMU -------- */
 
 /**
-- 
2.18.1

