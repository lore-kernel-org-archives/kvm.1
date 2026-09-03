Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB55628D8D0
	for <kvm@vger.kernel.org>; Thu,  3 Sep 2026 00:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788394592; cv=none; b=Gu+q0V1SuPeCOFohdHGV2o0krAr8cQ9BcDu6/lNeW0YIsyLzjMQXa/orF1sZgh/GbqI42VbyAOFIzJKNguk0on3qywJO2DaUfOOjWwHa0YyCDgoEJYN4QNvOONjj2r7lzlr/tZpBj9po1YnM+N0eP3YtWB32D8QCwrD0StODfpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788394592; c=relaxed/simple;
	bh=lynxvI4BWDKfkW0dl139eAVcbrc95dm3ZZJq8SSTU2Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rN9/GER8A1/nY7eBLmtIIxreQXuFwTBnPWq9LGioaJ+A2s7NcV6SR4r4gpnu6g1l5enxW3akTGO7Gp6G30YxmWZ1XBfirvGA9xh0gG/MGlqfDscEoQVPyBogOxFRD+q+Mj00waV3ycPOilXDWj998CjsGjnOvPENS51MePuHgUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OrN9QL11; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OrN9QL11"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cfc52ddc55so28400405ad.3
        for <kvm@vger.kernel.org>; Wed, 02 Sep 2026 17:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788394590; x=1788999390; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=zlSRSsSlpokdtKbgl+ElzoriroijVL7fsph+TXQV+Eg=;
        b=OrN9QL116CC8PrLGFMRw8J7rOiL815y21AzYbrqTRmh9wipyBbE3u/zTgnTyX9+Wtj
         W4cIhI62WSc4sdc7HJX6kAPMFx1IaNYyGDsMs6sQCZqXK1bXOskGDfFkXGMHQxxWYVrg
         sZT7qanMHs7mkVfwGWUgW1x5kepHNEuvCCGg7XIt3hphpooH7Id66Zlm/9svmbcc6pL1
         qatbgx7vNebFSm9wG+J5NIxKyjtlXWCMj32UgmxSbQ1UOpBI2roRRf1znUhv/GxCksJI
         bTPqWT4DlQCWiPhpfQbufSpEYjbi/Ah4CGVYcOpaXj0bzFJV9mQEMAykzUj7A/WYf5c5
         eHxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788394590; x=1788999390;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zlSRSsSlpokdtKbgl+ElzoriroijVL7fsph+TXQV+Eg=;
        b=Oh6mDFszuHzmZmzvlTsoXHlK+MBg6rZLjd37A/CmREWQK6qXhHUORTbbHelhikWTP6
         zLuvJffQHIlgOKBPSRasaKv/TPlJOS4DWDCL4osyFn2iadfQMhsLMfLqdFvgB1kruggo
         9e8ZIKQlUI0aZM55ba4oGk5OT1y5gmaTRZcziFJ5zizmDiJ5EBq4qIpIqmxdkJFKkI4e
         ljeeZerMuVbcc+fkHXmTf56AhEdRV3nRUCTRS6mzHcedkixWFwai/o7YOmb008JIhD5r
         IKxtoYqr+WKKr/A2vP/JBKw9fTV/lpQl/epoeF4Wtglu4DS08dCQp9nMahSM6c6cXv4i
         hNUw==
X-Gm-Message-State: AFuF++nunWXCkkzJTJnzDoJlWZqWgwj7XMYGe0MurW91IGq6AdxG1IeU
	2IkXTgCMILVcVYH+Lk67J7yNGs0F8Bky9yvXuYIPbLeIGv74x+taplLULCYzZXQzFO+PzWrA/kO
	6UnK8Bg==
X-Received: from pgfd10-n1.prod.google.com ([2002:a05:6a02:654a:10b0:cc1:be9e:35ee])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3c04:b0:398:d6e8:f84e
 with SMTP id 98e67ed59e1d1-39aedf5571fmr14120881a91.9.1788394590039; Wed, 02
 Sep 2026 17:16:30 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  2 Sep 2026 17:16:21 -0700
In-Reply-To: <20260903001625.2792367-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260903001625.2792367-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.970.g62bdec98f9-goog
Message-ID: <20260903001625.2792367-4-seanjc@google.com>
Subject: [PATCH 3/7] KVM: selftests: use BITS_PER_TYPE() for NUMA masks
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Shivank Garg <shivankg@amd.com>
Content-Type: text/plain; charset="UTF-8"

From: Shivank Garg <shivankg@amd.com>

Replace the open-coded sizeof() * 8 calculations in do_migrations() with
BITS_PER_TYPE().

No functional change intended.

Signed-off-by: Shivank Garg <shivankg@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/x86/xapic_ipi_test.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86/xapic_ipi_test.c b/tools/testing/selftests/kvm/x86/xapic_ipi_test.c
index 6be11c1c725c..9d1dfad4efa6 100644
--- a/tools/testing/selftests/kvm/x86/xapic_ipi_test.c
+++ b/tools/testing/selftests/kvm/x86/xapic_ipi_test.c
@@ -233,7 +233,7 @@ void do_migrations(struct test_data_page *data, int run_secs, int delay_usecs,
 {
 	long pages_not_moved;
 	unsigned long nodemask = 0;
-	unsigned long nodemasks[sizeof(nodemask) * 8];
+	unsigned long nodemasks[BITS_PER_TYPE(nodemask)];
 	int nodes = 0;
 	time_t start_time, last_update, now;
 	time_t interval_secs = 1;
@@ -253,13 +253,13 @@ void do_migrations(struct test_data_page *data, int run_secs, int delay_usecs,
 
 	fprintf(stderr, "Numa nodes found amongst first %lu possible nodes "
 		"(each 1-bit indicates node is present): %#lx\n",
-		sizeof(nodemask) * 8, nodemask);
+		BITS_PER_TYPE(nodemask), nodemask);
 
 	/* Init array of masks containing a single-bit in each, one for each
 	 * available node. migrate_pages called below requires specifying nodes
 	 * as bit masks.
 	 */
-	for (i = 0, bit = 1; i < sizeof(nodemask) * 8; i++, bit <<= 1) {
+	for (i = 0, bit = 1; i < BITS_PER_TYPE(nodemask); i++, bit <<= 1) {
 		if (nodemask & bit) {
 			nodemasks[nodes] = nodemask & bit;
 			nodes++;
-- 
2.55.0.970.g62bdec98f9-goog

