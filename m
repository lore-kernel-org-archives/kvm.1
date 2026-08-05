Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012046.outbound.protection.outlook.com [52.101.43.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390823ACA4B;
	Wed,  5 Aug 2026 06:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785912107; cv=fail; b=ASFDE9boJBidRGpOwp9qG7fmUO8BUqmrD5J6dN0a1VQ0NmJBSe6e/q9ptCNaJzhVVmYZ6dt6KoGtIQkDVAY8uscBJIKOKlK8xhJbJozvWaFv1KiGdQXmGT1YPpo0ZMzVkL44Pej37BHgXfMHrkLgK9bJ+4aGbAfLmksNmF6Ta2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785912107; c=relaxed/simple;
	bh=Hx9UYtC7m81cRsUZoyk/6NCu3lSkUrBZZZ2qPIwWefg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=E5BCF6vHEiLIguaZsl8QsU2efwMGZ2t2R5HDSgEKLw+qeFLcDb8pbInApkqHAtltYOsaCaHXF1/m/BPxNimQzWcwdYtUz5zPhNMruUU4/B4R7B+5qghTeEdzKZGI8huNYHCjrP0aYX14Co7SomSEuOw7h5UGqPo28UMzyr7WaOY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XBJtJGrJ; arc=fail smtp.client-ip=52.101.43.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XBJtJGrJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XiWD5Ajtly82Hr/uavrYMdg7ZIeAoumDf1P19cDCLpJ8mcsLh3ITvt5Bh+uJvedFcwY50bV1bK/BRsDPrk3Mib40RLRs1dwQ2xofgybA0W0zJE0Wojg2wh5DU2sA7796mmL1bbkkTW3SYLk1xORFd+NSXIQlnBwK4h+qXf5RrLMA40haByAN5AEIr45qWjfjFXE26XO+3GWGcb3zuGxqzHo3T06EIPaCUSA2IBtyLOR8824LTo+M1OekPgL676bjtVbjpwTZ9xVrGG1DVnuEuvFUcMGAiHSEzJSnFly5JE5ioKzrHJ2WE1cezCJ/x9Joz62HckRTVmud0c8Aj7IavA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=afmFsNL6j/iJ9E32U8KDSQqP+r9OaJx+DK/3TeLQDQk=;
 b=U1+t3ZkRmFmZ/YRdCwlnELAekk7LMAzIayWAIHpJ9OyNp/YatjSh22gZBSk2Lv2lE3SfmaaSmlf39prXz1/GNgJKRNa7qo+W87M1BaMBLLLvypErHdddijvrufhdDNzqVaar/ihdHdzBZTQiO7xaudUBUl86ddR+CKRdNhAu7mcv0YHabGRDHXZZfSpqM9BMAskucnRbQxJD1ivFp2Mwyy3UKSXFivwtA34yLghuauJ0wkTQ9zETGWaU19R19RxmpoM5/sgYrUxvWUIM0FzEAEJ7LR7NsSDWCcg92uolBJsBAYfYAE8DDfSuPoAGu4NWBwr+vDVVqwRUXsLbFJCI+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=afmFsNL6j/iJ9E32U8KDSQqP+r9OaJx+DK/3TeLQDQk=;
 b=XBJtJGrJmA7TImRXCnBhbmvxpwNJ+dkBNirANMafIN4deCvdTSIkgJfYZUJmvnaCbrKWIBAsqvpEVlnxBitKwG4KmWnjb0Vv6CusrkHL3JljBbV4N0jR77rviyDWbH6HQ1e3vy9/zg5NONtbCemC4L2JlL54SB32nq86ld54cDY=
Received: from SJ0PR13CA0108.namprd13.prod.outlook.com (2603:10b6:a03:2c5::23)
 by DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Wed, 5 Aug
 2026 06:41:36 +0000
Received: from MWH0EPF000C6189.namprd02.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::51) by SJ0PR13CA0108.outlook.office365.com
 (2603:10b6:a03:2c5::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.5 via Frontend Transport; Wed, 5
 Aug 2026 06:41:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C6189.mail.protection.outlook.com (10.167.249.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Wed, 5 Aug 2026 06:41:35 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 5 Aug
 2026 01:41:11 -0500
From: Shivank Garg <shivankg@amd.com>
Date: Wed, 5 Aug 2026 06:40:30 +0000
Subject: [PATCH v3 1/9] KVM: guest_memfd: take the invalidate lock when
 unbinding a dying file
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260805-shivank-gmem-migrate-v3-1-00d8bdec4e1d@amd.com>
References: <20260805-shivank-gmem-migrate-v3-0-00d8bdec4e1d@amd.com>
In-Reply-To: <20260805-shivank-gmem-migrate-v3-0-00d8bdec4e1d@amd.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka
	<vbabka@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko
	<mhocko@suse.com>, Brendan Jackman <jackmanb@google.com>, Johannes Weiner
	<hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, David Hildenbrand
	<david@kernel.org>, Matthew Brost <matthew.brost@intel.com>, Joshua Hahn
	<joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, Byungchul Park
	<byungchul@sk.com>, Gregory Price <gourry@gourry.net>, Ying Huang
	<ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, Chao Peng
	<chao.p.peng@linux.intel.com>, Nikunj A Dadhania <nikunj@amd.com>, "Michael
 Roth" <michael.roth@amd.com>, Pankaj Gupta <pankaj.gupta@amd.com>, "Ackerley
 Tng" <ackerleytng@google.com>, Sean Christopherson <seanjc@google.com>,
	"Vishal Annapurve" <vannapurve@google.com>, Nikita Kalyazin
	<nikita.kalyazin@linux.dev>, Patrick Roy <patrick.roy@linux.dev>, "Pratik
 Sampat" <prsampat@amd.com>, Ashish Kalra <Ashish.Kalra@amd.com>, "Thomas
 Gleixner" <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>, "Shuah
 Khan" <skhan@linuxfoundation.org>, Peter Shier <pshier@google.com>, "Jim
 Mattson" <jmattson@google.com>, Ricardo Koller <ricarkol@google.com>, "Ira
 Weiny" <iweiny@kernel.org>, Fuad Tabba <fuad.tabba@linux.dev>
CC: <linux-fsdevel@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-doc@vger.kernel.org>, Shivank Garg
	<shivankg@amd.com>, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.15-dev-47d62
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785912059; l=3935;
 i=shivankg@amd.com; s=20260518; h=from:subject:message-id;
 bh=Hx9UYtC7m81cRsUZoyk/6NCu3lSkUrBZZZ2qPIwWefg=;
 b=Fk56lSaOnFisB+qDkjH/DtKWve4VGfa7qvMwXYHElvxiK+c3yEFe/lnluiAQ3BI/O9OE4xshE
 BylNPbHkQvdDYvJyQFLjP7CrBuVu71gnlAYfPfBdXEvUbBu8oCF9NGb
X-Developer-Key: i=shivankg@amd.com; a=ed25519;
 pk=2l2QGTeXuGkZTtfmx0nPQU8iFZfjYmX/ymMojitevx4=
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6189:EE_|DS7PR12MB5744:EE_
X-MS-Office365-Filtering-Correlation-Id: 949bbe7b-f0ba-466b-244f-08def2bc9879
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|1800799024|7416014|23010399003|56012099006|5023799004|11063799006|22082099003|18002099003|10067099003|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
	nmfj/Q49n/RA129QdZ0p6Cw+/HaDkw5UX+sRq++B6MkZQIln/09vEy9TJ+juY2rgZUZb5O1F8eigwEb9cZyAzRmVs0mN3DzgIaP5pZ7Bf5OhCVgrerx9TkMC3698tx8k81w9gyShEpRR3YN0u2y86qQfoUSRVmURckVTlfs1w9RY1rnZmRmTWAcyI54TrZ7xrSgRYMVPNWl81+kgq/HDzZLbc+XrddRgevJRCY1kZS/fzsS38GXrcVfThl2uW5Snsr+PJvzgOYEN011n+CPVpdjigosiPGfdCedGnPAkejDWC2SI7GYLc1qKYcXYSkYeT0dm63jpp5GfVlVg157Xqex/zTAG983EpvywfmGr+1ODuVmbntFbHYoUXoV6NZ/zp8Piazou8fkeJThBGShUOJpp5OU+NZxADYpO1P1LirzKZNtMUALfs1f530DjSBEUw6/nVL3ibpdf6nX9r2LJL7dtBXhwXIhhMyMVhWoZfV2H7RixLoWiE8Yf3QosJeLP9mMT7/9lBe18lAFMGVRD9w+m/JCOMIyMQowGgKdIXBeGeyx5R2gpJsfzz3PcNuo54XDYpdxd4cV2BTZi56NCsTxzAtBJWPdo8lDHqYv3g70ZuS3hfnlNLjUXnmfgFz1cWihNmWRbUQxq67rbzW4Sd50+3064snshaH18a9u0fxUfzPhrCn/O/3WlEsG8p2LXP7idcKR360h7o39Nu39AKg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(7416014)(23010399003)(56012099006)(5023799004)(11063799006)(22082099003)(18002099003)(10067099003)(13003099007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	datV/Epw51BdEE8tvFA3DYlsVLX1Hsu/dYeilTst+ZuO6wTU6ugGH/lvMp5Qd8ddWVf1i6Xtf3ac0CdJ+ARRrMKm50o3J/t5e0KL2QcvoJ47j5fA1mvM9wMvdE1gG6wINEXyYtVScBposg095kIjtP/kavd+ugfDKdnPEach7Qb6pCr6ITgot78eCUaK/aQhfJsxq+73C+qMeEv8dt9eHpA1+9L97OTZI/glAQ5oCYE7B82Sk3pikeM+KDFGnMQqLPYhziUf6dJarTyyfpbzUS+398QMCm7CdMnFvnPTGdkhAksR0kkwDS7bsRQyDYUhHxeLpuIi09EFvK2lo027WA60uccmxJvtE22SfJD48M5mMxaQjB1IMFU/uNF7gnvKzHjebxymjve1zIUWIfYkfMA36tUlSmJWxJw4JGlzvpAEpUTwlDX3rMf3+uFSINn7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 06:41:35.7700
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 949bbe7b-f0ba-466b-244f-08def2bc9879
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C6189.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5744

kvm_gmem_unbind() skips mapping->invalidate_lock when the guest_memfd
file is already dying. All other paths that modify f->bindings hold
that lock.

kvm_gmem_invalidate_{start,end}() checks f->bindings independently to
decide whether to begin or end KVM MMU invalidations. So, the bindings
must remain stable between the two calls. If a binding is removed in that
window, start increments mmu_invalidate_in_progress but end does not
decrement it. Example, unbind race with memory failure:

  CPU 0: memory failure               CPU 1: memslot delete
  ----------------------------------  ---------------------------
                                      (guest_memfd file is dying)
  kvm_gmem_error_folio()
    kvm_gmem_invalidate_start()
      finds binding
      mmu_invalidate_in_progress++
                                      kvm_gmem_unbind()
                                        get_file_active() fails
                                        store NULL in bindings
    kvm_gmem_invalidate_end()
      no binding found
      counter stays elevated

mmu_invalidate_retry() then returns 1 forever, so guest page faults
retry without ever installing a mapping and the guest hangs.

Take the invalidate lock in the dying-file path too. This prevents unbind
from removing a binding and leaking mmu_invalidate_in_progress. This is
safe because any caller that reaches this path holds slots_lock, so
kvm_gmem_release() cannot nullify the slots->gmem.file, until
kvm_gmem_unbind() finishes.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260728092027.225CF1F000E9@smtp.kernel.org
Fixes: ae431059e75d ("KVM: guest_memfd: Remove bindings on memslot deletion when gmem is dying")
Signed-off-by: Shivank Garg <shivankg@amd.com>
---
 virt/kvm/guest_memfd.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index db57c5766ab6..45cbdf4801ec 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -721,6 +721,8 @@ static void __kvm_gmem_unbind(struct kvm_memory_slot *slot, struct gmem_file *f)
 
 void kvm_gmem_unbind(struct kvm_memory_slot *slot)
 {
+	struct file *gmem_file;
+
 	/*
 	 * Nothing to do if the underlying file was _already_ closed, as
 	 * kvm_gmem_release() invalidates and nullifies all bindings.
@@ -733,21 +735,24 @@ void kvm_gmem_unbind(struct kvm_memory_slot *slot)
 	/*
 	 * However, if the file is _being_ closed, then the bindings need to be
 	 * removed as kvm_gmem_release() might not run until after the memslot
-	 * is freed.  Note, modifying the bindings is safe even though the file
-	 * is dying as kvm_gmem_release() nullifies slot->gmem.file under
+	 * is freed.  Note, dereferencing the dying file is safe as
+	 * kvm_gmem_release() nullifies slot->gmem.file under
 	 * slots_lock, and only puts its reference to KVM after destroying all
 	 * bindings.  I.e. reaching this point means kvm_gmem_release() hasn't
 	 * yet destroyed the bindings or freed the gmem_file, and can't do so
 	 * until the caller drops slots_lock.
 	 */
-	if (!file) {
-		__kvm_gmem_unbind(slot, slot->gmem.file->private_data);
-		return;
-	}
+	gmem_file = file ?: slot->gmem.file;
 
-	filemap_invalidate_lock(file->f_mapping);
-	__kvm_gmem_unbind(slot, file->private_data);
-	filemap_invalidate_unlock(file->f_mapping);
+	/*
+	 * Take the invalidate lock even for a dying file.  Otherwise,
+	 * kvm_gmem_invalidate_start() can find the binding and increment
+	 * mmu_invalidate_in_progress while kvm_gmem_invalidate_end() misses
+	 * the removed binding and skips decrement.
+	 */
+	filemap_invalidate_lock(gmem_file->f_mapping);
+	__kvm_gmem_unbind(slot, gmem_file->private_data);
+	filemap_invalidate_unlock(gmem_file->f_mapping);
 }
 
 /* Returns a locked folio on success.  */

-- 
2.43.0

