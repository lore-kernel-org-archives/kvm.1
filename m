Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013027.outbound.protection.outlook.com [40.93.201.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C4630ACEE;
	Sun, 23 Aug 2026 13:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787492216; cv=fail; b=Vvkevu8R6z/uGVoIplibXlzkHW+tW7NpmWvmgfj7w3aO5GH54WqNx8oyxfliH9uCVWpwPm01aM19G8ZM8Bb9lQ0u6Z4SobcDkW0LVG/Sdx3anGLpJpVlmYBij2UigRa/XgnavDIt53jn0APw7oq38XEW+yOJNRe1XEx8N1l5jXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787492216; c=relaxed/simple;
	bh=C/bRSXHWkdib9RhhVNRyaAqGBZbOWSXovudW8KDGKrs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=g0W34u6hdy3viicCyeXq+DxBQLTMyHEneC1M+3rxfrjsblnCA9sjM1r5j3TijCmwJKXiaRkvEdEd0LTO7wwKumwNtsOr3MzKG5uqVIWSJyVX2skXImlTHdhrbE222kHIDVoVw1cjFlYCkff6Ciy0tLKgzyNuSbkH9YBHZK16QS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5spSQHuT; arc=fail smtp.client-ip=40.93.201.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5spSQHuT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xmbLaU26C9zjEqdcmYShY6GuCsBAEEjTZVw9iSfb0Fimbm9XdBmxQifAuRy4aD+ElGYq8vzyb64UAzNDYzelVunzLlLI+bXDexr7zFgu1wj1G9JKCgOeTPNhOLXBOSk4ZdV9wu5mvXCM/iBD4t79wG7vNz4Oitp2l2jrTdi/gcH43/Lv7j5EzuX7g+vq1Io7FI8uOPJg0eMTVSFPbar+CuosAP9MR/yuhIkHhALHLPlDmZWnq1sKFlDKRMT8zgQeQruds6Eevf/8YvIyNsCN9VArD3IQW9bmt8POoeliU2qeIrKbpyxDxIGDJYOzKk8cUm2K3HtnHbXj0qAhBScqxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HZGhphsAYQROsl3tcYHexJQpw8g7wXb4S2sUNFniCTM=;
 b=hqYVZXiG9SUqtLVqKfXu9v9AQDHutt7tx4YTTaSKwU+jbB73XlSaMW35ZJcexNRafK2IJzWyu7ymxkSRtvYVAo2Swwo+rmMV4ibuf/x9fZIPrk/1PLpQgQqJ38SRJNuwrxMnsonU7bLYffKdk0tJsRUEcyQ57liCAYK9Dnr/yHHhtbS/gFyikDtpN+r6j6HiHT2A/TYh/SylXqqdb8Sd7nGAN5mrxY34KYLhxLXdvOnUh9Me4DuwyRcAavGzMYjsnJxWC24k4YL0bzjL7enKvNadKa/d/DYifAXpFVeJFWMdf7LHZSWjRcnr5dQ/oZyK4B8MQDSpndQrVOavOS4Csg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HZGhphsAYQROsl3tcYHexJQpw8g7wXb4S2sUNFniCTM=;
 b=5spSQHuTHUVpzML2jTIGFmL2af6UkOcIKcotABm+GxDZWvkKFgxDByCM9wL3PF9B1bppilzFdbtZ0u82x3FcHaGizf0lWHaRsSn1trghl8a/zWqn+jVR/+XhmOcZjl6acc7gw11pYlc+Rzl/GsO4Gfk/Z9x28uKKc1ptyJl0NMg=
Received: from SJ0PR13CA0190.namprd13.prod.outlook.com (2603:10b6:a03:2c3::15)
 by DS0PR12MB6535.namprd12.prod.outlook.com (2603:10b6:8:c0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Sun, 23 Aug
 2026 13:36:49 +0000
Received: from BY1PEPF000264B2.namprd02.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::53) by SJ0PR13CA0190.outlook.office365.com
 (2603:10b6:a03:2c3::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.6 via Frontend Transport; Sun, 23
 Aug 2026 13:36:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF000264B2.mail.protection.outlook.com (10.167.242.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Sun, 23 Aug 2026 13:36:49 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sun, 23 Aug
 2026 08:36:45 -0500
From: Shivank Garg <shivankg@amd.com>
Date: Sun, 23 Aug 2026 13:36:29 +0000
Subject: [PATCH 1/5] KVM: guest_memfd: take the invalidate lock when
 unbinding a dying file
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260823-shivank-gmem-fix-split-v1-1-512a29fb8e86@amd.com>
References: <20260823-shivank-gmem-fix-split-v1-0-512a29fb8e86@amd.com>
In-Reply-To: <20260823-shivank-gmem-fix-split-v1-0-512a29fb8e86@amd.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson
	<seanjc@google.com>, Shuah Khan <shuah@kernel.org>, Jim Mattson
	<jmattson@google.com>, Peter Shier <pshier@google.com>, Ricardo Koller
	<ricarkol@google.com>, David Hildenbrand <david@kernel.org>, Ackerley Tng
	<ackerleytng@google.com>
CC: <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, Shivank Garg <shivankg@amd.com>, Sashiko
	<sashiko-bot@kernel.org>
X-Mailer: b4 0.15-dev-47d62
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787492201; l=3934;
 i=shivankg@amd.com; s=20260518; h=from:subject:message-id;
 bh=C/bRSXHWkdib9RhhVNRyaAqGBZbOWSXovudW8KDGKrs=;
 b=8+mTiwwSm5HqJ6Q8nOiNnGlMgdTOj+1F4OjgNQcFJit+oNKhbqURdFPqES0aLY+Nxx4Hevk66
 wO3DdHsZs/GDmfB+W5sTyC06qWa631Hfm4/+1zDQWyA8CtnLVm9snu1
X-Developer-Key: i=shivankg@amd.com; a=ed25519;
 pk=2l2QGTeXuGkZTtfmx0nPQU8iFZfjYmX/ymMojitevx4=
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF000264B2:EE_|DS0PR12MB6535:EE_
X-MS-Office365-Filtering-Correlation-Id: d0255fdf-2537-48b5-ad74-08df011b9565
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|1800799024|36860700016|376014|7416014|56012099006|10067099003|22082099003|5023799004|11063799006|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	u5AEfElAzOmDMSh0DeQOvjBlS2QH7WjaVoBEOZGH3r722HeM41jDzfhPxZlZEn7MK/XbbdVdYGs6bQUBw47E1U3qQJovtM+3Xn446t9tY9Gwf/62Ur/nbMwOOtFJRVlUSe5It54J1Bzt4vBe4zZ4Hfujh68j15UGJl6l2cNzi9eHH05mombsE9Yv0wvY3iY5KVOpE+WKCx/vOrjZXYxSRhQ+NkMIxEvYbI0jy8fEqECP7ebDDXS7LHESkpTDuivki7JQ+NA1ukh7L4PVN/GL/2JK90rwK5tx0WWlILL5ZeV75Kjrwc92HyRdnIcqAVSrwJ/YtiYYiyZp6rAvEWbLckiR9Vv48snB3zQTuoXmtXdjQWLh0IWfPXFN+pfE/fgJmgKUUoPmmTeSzNUn3J4T/9d/8JO0jAeCoDEH5biXp30tjfStw/yMneT/2HYqoDDdyVQxBg9vNozWSFlbdbmxaxk6+lJLawK6SiXz230JPy++6iY0fzCOItDwVN0abF7aE9/O02LMOknrVYpkN/OVgmP/GSmULtqtx+1zkPonRe1YW7M01ne++n5kcIaIYdMW7KDVL56B20cH6oynK5PjtheSK+X6sxQ5GSnZCAqniWG1bFpSo9eXgKbQ708GXBcHVQ2d9XiVCHMWcg+asj/MzwBq6rJDjkEdzVjy3sOACF4y1nhDtfWcvp9Zej0eYc37rpiQJPso6bMSLyiMLHVgiw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(1800799024)(36860700016)(376014)(7416014)(56012099006)(10067099003)(22082099003)(5023799004)(11063799006)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ZM+22WflXF/gEEjef9nOw8E8MrDY1cIMxBmKVg1Qq/Lo60bVPc+PYYNeoQKxeln+EzRaHCdkp3D7RN3S/mbtrio1X2wd+A17CHyuCiV9cDxTuWidCX87FIYHEo7jFnUUmD4Lgl2qr9yTnATVMO4HdonZ1KQH7lYdpE8xEDZiSoGJ1/vEJKgBW8wDsM2NdvxvCefnJBxCwXOAx46ncLGeyyZMHC0+11CcnYMRh47jz5LKLYNYrtVKAlaw5FmHyz66FGqs8Apgtdb8FwPo7qFKGYLwh5LVsSZEnMgARKHQWcqkwAE79/LpdHDgXS8vpez73aFEx2yhXbz1kIsitfZ5xeP915wElga7NqOpmnilYmVy3FQ0TLM7ZMdbGHfjpYUH8nHk4Yd/mHbOs4PhQuT5VWW1qcJPpwRGCCGBXwhRqsPtvlJLx1KgGavCv7b6Bv9r
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2026 13:36:49.1469
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0255fdf-2537-48b5-ad74-08df011b9565
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF000264B2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6535

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
kvm_gmem_release() cannot nullify the slot->gmem.file, until
kvm_gmem_unbind() finishes.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260728092027.225CF1F000E9@smtp.kernel.org
Fixes: ae431059e75d ("KVM: guest_memfd: Remove bindings on memslot deletion when gmem is dying")
Signed-off-by: Shivank Garg <shivankg@amd.com>
---
 virt/kvm/guest_memfd.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index f0e5da490866..f848120af84b 100644
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

