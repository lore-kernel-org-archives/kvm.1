Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8313148AE
	for <kvm@vger.kernel.org>; Wed, 25 Feb 2026 07:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772004048; cv=none; b=IGjaYvafRe7T3flwPc30s41iYLxH1iXjfcFsPEKWt7kpmSaUD9ldPy6zMeQ4JHCQ7yc23k2FW+xzeow+FXS7uPFPTsz58cB8IpXo+L5b8Fj8bvxmzDjQGRrj6yXAjAE+zT/vGyf/3fmxYm92Uq+4Rrvbr7pLroJswk+5xOa2vPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772004048; c=relaxed/simple;
	bh=ZMQPV7Y8H88+MGQYlAsk4qj1ohZaV8k9fkkraEOtToU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AIbWnIkGo9rIz0QKxSNm5cmvAt/7wb5oUJKvARHMlFf+LBlQER35YWj2jogcYvsBn5/QEWKFYUz2rUu3k6Z+q/Z3RyXtt+wAkGN1ifVioz24FADb6RH3H3TqjcxI7KEbn5mIJK6i9WoK/ssb0SyR8Bu5MMJ5R6/afgMKPblTYuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=esOssuLF; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="esOssuLF"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2aae146bab0so69240395ad.0
        for <kvm@vger.kernel.org>; Tue, 24 Feb 2026 23:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772004046; x=1772608846; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RxvzdHDHaSHLdjnOnYt7Pz8oF0XFcbFcMtFEzYFn1AQ=;
        b=esOssuLFcA56b+69h2S6cCu4y9evuNJTX/UOpJs4VmtUTLfgRz7J5Di4T2ocXlyJpa
         aHmNTJ24bp0tauf8kdLZAfe7NaPLIkFzpOoIwBKJ0VvOqdjRm6gMCtKLT3EahwYnVn4w
         MkKMITpVyFmUuA+s+OaphgQq/iRgZS00rUmTvP7ZZToJpgEI0GFfl/4UPN1cF5CuRfEQ
         tS7lGSDQ8XzL684soyjjntfVtTXsBYiZxX/5iVWHxV+2lQD+DlhpeVj8mW+6J9PyuVdb
         Ew9+soXzKmOgIwZu5eq3loLlatAVZNyi895LWexOpewTFKzMqPMncyP/mquQmWerq+0J
         yS4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772004046; x=1772608846;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RxvzdHDHaSHLdjnOnYt7Pz8oF0XFcbFcMtFEzYFn1AQ=;
        b=NuXUg/Ou8lznw+ot/RmD9ztmoJrNReUwhAh6ZM+PaeLqm1ir2Vi3R5KKHFP3/D7GTx
         cfvUL3MRqb8ZCo38BuLXqFIiyy33UIbrtWadHgKna1ENqAH4ULK7oD8GnfBx2Gw+tL8W
         S6aEjlLHwLky5w3X+Tz1XgpDbPqIXDC/W0NdZ86yLDt6J8GuCiH1BpksknfohjQ4OVGN
         x1JUSTOXxkkH6UClywRsadouaUaemseCOpmcHSjZ5kAWGkY1o3rZOMxxQJXy7YUtbj8T
         SSR8AEQiWC6vdpuf2bfO34RoAotSE7rkD8RBGvL8Isv0sWgCgGpIQfZpkWJHmCmKAdZZ
         LqiQ==
X-Gm-Message-State: AOJu0Yzo7viWG9db8E/EaCJJvZKYO/h3IcOHdOaxk6an0e7ASzmK/el0
	ss+XvdfP+aX/pLvc0L2qP2IJe5k5twjQoZ81y8fOXQLUmuHvJWQDKHS2Y3D26lXMX/vQTkarvOw
	WWuH8RQ3f5+ovg+90dObg+Raffg==
X-Received: from pjbjs14.prod.google.com ([2002:a17:90b:148e:b0:358:df96:881])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:2982:b0:35d:53dc:cb61 with SMTP id adf61e73a8af0-39545ed4ecbmr13199551637.24.1772004046254;
 Tue, 24 Feb 2026 23:20:46 -0800 (PST)
Date: Wed, 25 Feb 2026 07:20:36 +0000
In-Reply-To: <20260225-gmem-st-blocks-v2-0-87d7098119a9@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260225-gmem-st-blocks-v2-0-87d7098119a9@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772004043; l=1374;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=ZMQPV7Y8H88+MGQYlAsk4qj1ohZaV8k9fkkraEOtToU=; b=UnVR/uLYP7ieBpWEAadpA6sROUIT4SgE39FHR7vRTz9HvHgkz8Qjcpq+AL3FU4w88yU1gGUOS
 sJFEPjg87ZGArJKumnOvSjc+SZz2h+qBgaWpg2xkrvCz9aXcDFKM56w
X-Mailer: b4 0.14.3
Message-ID: <20260225-gmem-st-blocks-v2-1-87d7098119a9@google.com>
Subject: [PATCH RFC v2 1/6] KVM: guest_memfd: Don't set FGP_ACCESSED when
 getting folios
From: Ackerley Tng <ackerleytng@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	seanjc@google.com, rientjes@google.com, rick.p.edgecombe@intel.com, 
	yan.y.zhao@intel.com, fvdl@google.com, jthoughton@google.com, 
	vannapurve@google.com, shivankg@amd.com, michael.roth@amd.com, 
	pratyush@kernel.org, pasha.tatashin@soleen.com, kalyazin@amazon.com, 
	tabba@google.com
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-doc@vger.kernel.org, Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="utf-8"

guest_memfd folios don't care about accessed flags since the memory is
unevictable and there is no storage to write back to, hence, cleanup the
allocation path by not setting FGP_ACCESSED.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: David Hildenbrand (arm) <david@kernel.org>
---
 virt/kvm/guest_memfd.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 923c51a3a5256..2df27b6443115 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -126,14 +126,13 @@ static struct folio *kvm_gmem_get_folio(struct inode *inode, pgoff_t index)
 	 * Fast-path: See if folio is already present in mapping to avoid
 	 * policy_lookup.
 	 */
-	folio = __filemap_get_folio(inode->i_mapping, index,
-				    FGP_LOCK | FGP_ACCESSED, 0);
+	folio = filemap_lock_folio(inode->i_mapping, index);
 	if (!IS_ERR(folio))
 		return folio;
 
 	policy = mpol_shared_policy_lookup(&GMEM_I(inode)->policy, index);
 	folio = __filemap_get_folio_mpol(inode->i_mapping, index,
-					 FGP_LOCK | FGP_ACCESSED | FGP_CREAT,
+					 FGP_LOCK | FGP_CREAT,
 					 mapping_gfp_mask(inode->i_mapping), policy);
 	mpol_cond_put(policy);
 

-- 
2.53.0.414.gf7e9f6c205-goog

