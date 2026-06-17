Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011019.outbound.protection.outlook.com [40.93.194.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA4F3E639D;
	Wed, 17 Jun 2026 10:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781691472; cv=fail; b=HaOZoyDlyLcr+e6QthTso2teA5wU+CiEPAcrpV6FmMv5eurT2hZo/rmY98rCx9r4DtT/DjeDiVKK3KFLmEFxyD8rryATYMRVlGZa1U49+1OeRFtk61qoWRG3IEcWjEr+TJXLwRRx/6SSsaT5EJh5tMFLvOZJkgOq6yabigerJBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781691472; c=relaxed/simple;
	bh=URFKdqEIhh3a6YTTRsw1fcndzmz0XV9NgN1r8McwNg8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=a+6u/fAvHhO9IjZ66oZWJqD1pgmHhNQRx2kt+mvSrFfgrN2qq6p3tIjwj2N7fTJLzugJC+qAdWc8z45mbD6mbU+Tjm/4JZrJCH9FBgTOwiU1ZXoriqkMgYCuCj7WN7JTwAbS33E6zL5q8cjGLoAKyQE9MMe1/wOgkEnTXmH6Bos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GfoUfGtN; arc=fail smtp.client-ip=40.93.194.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GfoUfGtN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sm5cj6n7Q0W1og652BsQDyp3PsedO0nqG/mwo6DDebye6q5Pdk5pFJpCEhOZo4D+X0xgxrgJSXgYw0NG+gSv4GGfSfJ9mynvJGn04hBp6//B/D0M8TF5acllkmXotJym/OSAh0XMutzxIHYs7QoB4N9RRG18DPpHNivS3teIOHENQJ5XA/xClT6OpdYtKhR/ElgiA3lYpX3XoVw5IBGWTZmJVjWr61eJQ5rACVHog5iXP855OnxfFpbuiemZZKCa0wJFZt2VZr14X0hXjUCzTTGqW0qj86bnrb/yBD+H8UfoLit0+yKmjI7H/xTk/0wvKxeACrgv6/Ue3DBJGvK2vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GYoLKD/Hq+RQogNkKKkiCQy5Jqj66QUmx0jTEOnqpUk=;
 b=cr9/ZVMo2euOKFmdc/hVStsfWoyRFVR/zegx1eKqljiYo1QTNj0bOTr/xecgpOaHPohPot09ToSzVutbMMpqdT2HTkIcbK+1lKaZ6IUgvBvL0dc7EP+9ulSFPnjeJ7tC3IkB3bSF1x1mLEU0F77SG08D+nOBFVMaIaNIFC+dVTa7YplyrPymVOjVnH8gWt/ZLL59as6TvK3huct0u8sXAi37y6+9wCKRdpHZlD43yodhCX5+j+FYnI0cyY3jKqE8oiKVgINrWVbxDA3yTfvusrxgOt0Qzmr7Rc8TLZKDFbab8wjCuTtEBD+yl6rrKtVFk6nLZqW3vTX9joeSyGQt1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GYoLKD/Hq+RQogNkKKkiCQy5Jqj66QUmx0jTEOnqpUk=;
 b=GfoUfGtNQ9g/ycmLiIIn3n7YrxyLNJl7x1gowp+tBwFEweC5q1JfhSPLCODpXjdT6u14x3hmnChud/Jt9DRf+SxaSuM4p3VVSb+PIG4fSWSrtXkCrUJWSV8b3oT7dytqSNgdb+oBltbxcwCe5p687fGFQZLIf1h20dkUKhtBKLI=
Received: from PH7PR17CA0037.namprd17.prod.outlook.com (2603:10b6:510:323::28)
 by LV5PR12MB9755.namprd12.prod.outlook.com (2603:10b6:408:307::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Wed, 17 Jun
 2026 10:17:44 +0000
Received: from SA2PEPF000015CD.namprd03.prod.outlook.com
 (2603:10b6:510:323:cafe::44) by PH7PR17CA0037.outlook.office365.com
 (2603:10b6:510:323::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.11 via Frontend Transport; Wed,
 17 Jun 2026 10:17:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF000015CD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Wed, 17 Jun 2026 10:17:43 +0000
Received: from [10.128.112.233] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 17 Jun
 2026 05:17:32 -0500
Message-ID: <90768c5b-2268-4faf-ba0c-27245d73a0d0@amd.com>
Date: Wed, 17 Jun 2026 15:47:29 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/3] KVM: guest_memfd: folio migration for
 non-confidential VMs
To: Sean Christopherson <seanjc@google.com>, Alexandru Elisei
	<alexandru.elisei@arm.com>
CC: "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka
	<vbabka@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko
	<mhocko@suse.com>, Brendan Jackman <jackmanb@google.com>, Johannes Weiner
	<hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, David Hildenbrand
	<david@kernel.org>, Matthew Brost <matthew.brost@intel.com>, Joshua Hahn
	<joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, Byungchul Park
	<byungchul@sk.com>, Gregory Price <gourry@gourry.net>, Ying Huang
	<ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, Chao Peng
	<chao.p.peng@linux.intel.com>, Nikunj A Dadhania <nikunj@amd.com>, Ira Weiny
	<ira.weiny@intel.com>, Michael Roth <michael.roth@amd.com>, Pankaj Gupta
	<pankaj.gupta@amd.com>, Ackerley Tng <ackerleytng@google.com>, Fuad Tabba
	<tabba@google.com>, Vishal Annapurve <vannapurve@google.com>, Nikita Kalyazin
	<nikita.kalyazin@linux.dev>, Patrick Roy <patrick.roy@linux.dev>, "Pratik
 Sampat" <prsampat@amd.com>, Ashish Kalra <Ashish.Kalra@amd.com>,
	<linux-fsdevel@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
References: <20260611-shivank-gmem-migrate-v1-0-2d266bfc6f95@amd.com>
 <ai_XK__RTXMCEcCG@raptor> <ai_aczmeH2IA6JaB@raptor>
 <ajA4z_Wkb93cTW4m@google.com>
Content-Language: en-US
From: "Garg, Shivank" <shivankg@amd.com>
In-Reply-To: <ajA4z_Wkb93cTW4m@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CD:EE_|LV5PR12MB9755:EE_
X-MS-Office365-Filtering-Correlation-Id: 247f7d63-bc4f-467d-7fd4-08decc59abbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|7416014|376014|23010399003|22082099003|18002099003|6133799003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	4eNayiqcVY/u2wMyFEHSfItQDnw1id3GvmZHn/xDoItXXYrr8MMFLpmxk5ILgbkomy7CYgkPa99/tmdHmz20V5aMkCwf1neQm6yOlZkp3XYIYzU6er7PY+W9YCIX4IusCdXQhLIr+Ra1Dv1h6d20BpfGcnOw+dU1BwBJbiPu85+M4ks0AayqDX1XU7CtxJj4Hpta3n1UEtNozE0UN9oV1rUFeYi5q1SZjQeFPDrKrnDemnU4a7OaSoKTpvScQhfDUXGzAkkZ9hCXWUzUKO6Dt+cb3ECcyrGYctAE2JUJnCyrR/oTxO/7D2bO83DWkMF/H3GP438XUOfTNCHLEucezAmU/M6MXWCS72bi9C8E/Lz+ijAnqnaF2SbhztW+3zdx59BAEVXBL20cSNSnvixFxY1VTUjuuPTIEhYBDDpgPCZnMUGJttnvdSbiZN7NJKL/wUpk3XrQf9fwbOBg4DjncPVoOqnydE2KZLGupZ9I1fS06hRr9CgfmZzbNFeGczxIm0tU518vgHuw4XwEymyyd28KsbAtM7XZmfFyI+TK9Avf0nHrk3lLMLG8/msv0aZ3pCDetNqng8mowg5vTaSyme12FxCYtI1eEwL5Nj7xmGQ59UZ0cENhkBQTBOXbIMuB4uOEe/TTEVtrEskCLSp9M0FCb+KuiAHQY1HHFNSf/FX10QvUOB8+AJDZ9JREsHPauYLpr6NFzp5ur139cGlxtFHZpFqqfK8FSspSeKiOX9w=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(7416014)(376014)(23010399003)(22082099003)(18002099003)(6133799003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	2NC22HYElG55apYsrlgkl/XXTG/cKWaupwzDwXycqBkrEk10ziEzp3p06ESgg6vhpO4SpoYN+R4y7tCXEZ+ayCLqt6BFhxpit4hqcGvniEkQpYsI/L9Ecko/7jnlhYH267z6r4CvY7+r4TFA2d/anbJINsuvB/i297TvZ0knCPiy2E3rxNFAsfKFJhQrxnE/SMy4BDMFfQ3ahc51B3kNZlIt38OiH4sYTnZ67LCH0CK7iFlsT2FkeSwoUCjWtUUEMjE+fk9UED5XSjd4Xb/kc44QJ61/96r4FkeZy+PX+LcXsEeo9rd+bBZ+IOv0P7RFDNJjQp5wDmxBvGDeojZq0CzMDgVSTaE2M2L5PtK4gQV3Uhls/VVOrb+qwgddNYCaM6LKmtq4FCyKqRfDRC5mgAEFWJzxMeuRAtS6mERIGyZeVsq6hvjGYsKyUiqs4O6x
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 10:17:43.8020
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 247f7d63-bc4f-467d-7fd4-08decc59abbe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9755



On 6/15/2026 11:09 PM, Sean Christopherson wrote:
> On Mon, Jun 15, 2026, Alexandru Elisei wrote:
>> Hi,
>>
>> On Mon, Jun 15, 2026 at 11:43:14AM +0100, Alexandru Elisei wrote:
>>> Hi,
>>>
>>> On Thu, Jun 11, 2026 at 01:05:07PM +0000, Shivank Garg wrote:
>>>> guest_memfd folios are currently marked unmovable, so the kernel cannot
>>>> perform NUMA-balancing, memory compaction, etc. This is unavoidable for
>>>> confidential VMs (SEV-SNP, TDX), since memory is encrypted and copying it
>>>> needs firmware assistance. However, for non-confidential VMs (like
>>>> Firecracker), we can migrate the folios.
>>>>
>>>> This series enables folio migration for non-confidential guest_memfd and
>>>> also lays the groundwork for migrating confidential guest_memfd later.
>>>> Once firmware-assisted copying support is available, those VMs can be
>>>> made movable, the confidential folio content can be copied separately,
>>>> and the destination folio marked with FOLIO_CONTENT_COPIED so
>>>> __migrate_folio() skips the host-side folio_mc_copy().
>>>
>>> I always thought that one of the nice things about using guest_memfd as a
>>> memory backend, as opposed to host userspace mappings, is that the host
>>> cannot unmap VM memory because of KSM, automatic NUMA balancing, hugepage
>>> collapse, compaction, etc, acting on the host userspace mapping of the
>>> VM memory, and outside of the VMM's or KVM's control.
> 
> +1000.  It's not just "nice to have", it's a core design principle of guest_memfd.
> 
>>> I think it would be useful to preserve this behaviour, even in the absence
>>> of confidential VMs (i.e, guest_memfd file descriptor created with
>>> GUEST_MEMFD_FLAG_MMAP).
>>
>> Just to be clear, I was thinking that it might be useful for both
>> behaviours to exist (migratable and non-migratable) for non-confidential
>> VMs, and allow KVM or userspace to decide which they prefer for a
>> guest_memfd.
> 
> For the purposes of this discussion, we should separate the physical act of
> migrating pages from the features that trigger migration.  As I said in last week's
> guest-memfd call, I am a-ok with supporting page migration as a mechanism, but I
> am dead set against supporting NUMA balancing, KSM, LRU-based swap/reclaim, and
> anything else that goes against the goal of guest-first memory.
> 
> If userspace wants mm/ functionality, then use anon, memfd, hugetlb, shmem, etc.
> 
> Shivank, what's the immediate motivation for this series?

Hi Sean,
This makes sense!

Tbh, my main motivation was to start a dialogue on this, since the
implementation+testing itself was easy.

Compaction and memory failure handling were the cases I initially
had in mind. And as David noted, ZONE_MOVABLE/CMA, compaction, memory
offlining, virtio-mem cases would be useful too.

I fully agree that NUMA balancing, LRU/reclaim and etc. features
should stay out, and keeping the migration as mechanism only for
guest_memfd.

Thanks,
Shivank
