Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F0A2882AB
	for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 00:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790036019; cv=none; b=upPHPDQw9wL0CldeN3wY4hIWe+gefeAdE+UBQjpeK5x2zZ2W3I94t+rbF9FDePpfsG4bR+LsfiElQEQ485HrVjyNjKFPEOj80HuJcIiT0+/qKDnFKiIJo+ABFR0f4OnLN4DVoJGPi4mvPndXn0GAgjXxkpRl6eSc/MNWMlQFPl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790036019; c=relaxed/simple;
	bh=JdOJf+2+GAEhZwBCGYJCZV2CMdKHgYqKlljHYuL2tJQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=A6ASOsjKerX8qnpW22PFehYG5T4shL6D11UfwwW/HqfSdwSSRCtUO+HCdw+GCCIxSjfghmaGgHiCzwoVnr11Ls49VG0ZgWaq3UsPCX3tQvCKlgx4FCgTWysxqwbfJNOv0ZkNrl9tkSUViZGVD34vaJxKPshY6LQv+9sIp2AjJGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pwtTK5eE; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pwtTK5eE"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38dbf293831so8087233a91.3
        for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 17:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790036017; x=1790640817; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=jDeElCc4OjANkEErvoKCXV2KgfEdeXF0F1dMXf8gxcA=;
        b=pwtTK5eECD+wXDjObhofuOs5+YmPekgHUeZYEv50j2WcsO3nWAFP4bsnnGzX8LtLrn
         2K+aULdyg/w9cnO+xoRUuaERtXXS2S03qasbUwwYySzo1R79H0nt055SrggL43v49VpZ
         UqLR5tj2NmldmVsjSqE+dSUrc7X1SnCvD+We/J2yPp+P8q4AWqODjrsf8iwiFdiVZaud
         /jKGgzBbC7GDAGqDtzgsRbnkMnpm/wB2ftrSUWu5/UKvmSca6zGK+dEgHBJS07hKbtyZ
         F7AdtRlR4e9MwIxNUXCofCrgEzEyifz1EQP5fWvAfwlSz5dw3/kdEl1iNU5kKm5fa1Xl
         l//A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790036017; x=1790640817;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jDeElCc4OjANkEErvoKCXV2KgfEdeXF0F1dMXf8gxcA=;
        b=KaCDWmLHeNJYQekxKyZSSo+qLF44+ZAaekGycDOSyxeJjk9KeBbnxbHLomBV9TDya4
         C6CwVJ6mJh8NSR5zLuhLnqZLWGCmeocma6aDqZtXsBJ00tdKviFDttq8reHqt0v8Jlnz
         vX92OzuSZPJT0jbJUGmqW23126L/A3mfk92gOyp7mMZTnfmJ7Ow9WHuDPQWHTGvgOz7/
         BLFDe8sXoTex6AULNpG4DznX0ifvL+BhugSBiMgtw20TfHTRbCRut21oEOAr4vY0Eh+8
         C5t2/aVqBczoFCGzGluL2YthlwPAtkPK8YweqmUsNHncLm7H1R5QdsfOmpGlzEICcd7s
         nD9g==
X-Forwarded-Encrypted: i=1; AKwUvBzrONPpadrcmLQ7tBGTPLmtsaTQtuIeXCnDEeW4RJdABI8EZlkctVYUfpCUMq4e8ULA260=@vger.kernel.org
X-Gm-Message-State: AFuF++l8TLzkGmmqjonvQXcNhcbBise8Fhz6BRbnwLW6akZU9OWJtWj8
	WwD/gcllnX5bEwbZUY9YxCcE/Nk0/B/11DE4WBU2GwmT6LkA382CiGJdCRpnI6YC1hGeKlcqnsQ
	R0EpHFg==
X-Received: from pjue21.prod.google.com ([2002:a17:90a:e4d5:b0:39e:6e36:d13d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:c02:b0:39e:5c8a:33b0
 with SMTP id 98e67ed59e1d1-39e5c8a354amr11422281a91.33.1790036016788; Mon, 21
 Sep 2026 17:13:36 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 21 Sep 2026 17:13:28 -0700
In-Reply-To: <20260922001332.1121266-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260922001332.1121266-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260922001332.1121266-3-seanjc@google.com>
Subject: [PATCH v5 2/6] KVM: Use goto to handle errors during memslot preparation
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: David Hildenbrand <david@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stefan Teodorescu <fane@google.com>, Dennis Tighe <dtighe@google.com>, 
	Sashiko Bot <sashiko-bot@kernel.org>, Ackerley Tng <ackerleytng@google.com>, 
	Yan Zhao <yan.y.zhao@intel.com>
Content-Type: text/plain; charset="UTF-8"

Use a goto to unwind early memslot changes if preparing for a memslot
operation fails.  This will allow moving the creation of guest_memfd
bindings into kvm_set_memslot() without needing to copy+paste the unwind
logic.

No functional change intended.

Cc: stable@vger.kernel.org
Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>
Reviewed-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/kvm/kvm_main.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index d9da8b51614a..24cf96840827 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1941,21 +1941,8 @@ static int kvm_set_memslot(struct kvm *kvm,
 	}
 
 	r = kvm_prepare_memory_region(kvm, old, new, change);
-	if (r) {
-		/*
-		 * For DELETE/MOVE, revert the above INVALID change.  No
-		 * modifications required since the original slot was preserved
-		 * in the inactive slots.  Changing the active memslots also
-		 * release slots_arch_lock.
-		 */
-		if (change == KVM_MR_DELETE || change == KVM_MR_MOVE) {
-			kvm_activate_memslot(kvm, invalid_slot, old);
-			kfree(invalid_slot);
-		} else {
-			mutex_unlock(&kvm->slots_arch_lock);
-		}
-		return r;
-	}
+	if (r)
+		goto err;
 
 	/*
 	 * For DELETE and MOVE, the working slot is now active as the INVALID
@@ -1987,6 +1974,20 @@ static int kvm_set_memslot(struct kvm *kvm,
 	kvm_commit_memory_region(kvm, old, new, change);
 
 	return 0;
+
+err:
+	/*
+	 * For DELETE/MOVE, revert the above INVALID change.  No modifications
+	 * required since the original slot was preserved in the inactive slots.
+	 * Changing the active memslots also release slots_arch_lock.
+	 */
+	if (change == KVM_MR_DELETE || change == KVM_MR_MOVE) {
+		kvm_activate_memslot(kvm, invalid_slot, old);
+		kfree(invalid_slot);
+	} else {
+		mutex_unlock(&kvm->slots_arch_lock);
+	}
+	return r;
 }
 
 static bool kvm_check_memslot_overlap(struct kvm_memslots *slots, int id,
-- 
2.55.0.1082.g2b9226bbc0-goog

