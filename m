Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC5E4E2F20
	for <kvm@vger.kernel.org>; Thu, 17 Sep 2026 20:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789677915; cv=none; b=kwj8LxcoB6z90G0dz8gCCHxbHdNdYy7xo8gaR2+oIrHYsptzbfxehyJthzHmmORRg2Zra/i2zmvSmAVHavfj0h7qVkmaxKLixgf3nanv+h0KoR1nOxofOllGRXmzQWi52X6Ad+BUWi9BSn4znT4KTRGbQdqFRHEohBxk3YXi3bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789677915; c=relaxed/simple;
	bh=3xlog7W6+Eb7uaognsijeu++wSjtW/1ijfNh02cWLeM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FaUA/xNpUGoX4JpQKxTQxCpXUj9hDZ96CEJPJslHDR4xSfhT0DLderQFQ4DSrUYhEYAvO0G7/yU4Ez3YdnbbFAyyEGifwmyy4/fTGnVqlAM9nwTKYEt72g+YDop0HoUQl8jBRYNZFsRD5xB8W/ekSnJ5Ss2JMSXxKoXZzHwx2CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JE7QEk4z; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JE7QEk4z"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2d6fed0652bso680435ad.2
        for <kvm@vger.kernel.org>; Thu, 17 Sep 2026 13:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789677911; x=1790282711; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FWbGWX7ba0RN8OdLexXyHstVRWEHpkbx670qUQ+b2/Y=;
        b=JE7QEk4zla80z7nZu5Lig/XRDsoHFMgTYXiSaQ4cfYP1lWLNvBWykXGfE9OfORJwy3
         jiXlspyrADOUbdXAghDHD9WpQQOOgBGUhdKxWTXE7YMa5Jy7LuK5b52SKbrs7dMS4sIO
         X73RXqVr4vyBzi9mLYJB8mqK908Lzdq0kmbjw7FX+5DYLiOrHP1u/3IKziGrbmpFcfd/
         mzQsv+TWp3Llf+U5zES/INyQxq238PG7vwYlzMPYxxR8n96zRpo8heLDxtCKPHBoI6pu
         Ua1f8I+K57ead1hG2FuiHPOOqXJcvhnJ6uTz9kB1GS+70AqWecVbe7S81bR2+4kJz2tN
         ddww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789677911; x=1790282711;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FWbGWX7ba0RN8OdLexXyHstVRWEHpkbx670qUQ+b2/Y=;
        b=uMeP9ky6b6LB/iNyUUjhXnAVlC+3f0d0IDNAutCRRZtS8PbbT9XxlWjBPTdNcnx8OZ
         x4ijElbTTL4MzQsQQHc8T25yB5BC6IyRvnyI8RXt+B1yNvHyysbFsSEK5frlIx1Us+Eg
         r6fK9KLaLy5KcUaZERcFitVwfVqoJ/aDZ6ok3YBrQ/eAtJBil3jipAhhHE2pgINaEe7i
         OtGd+rBkaE/Si+cPNlGNxOpX+8oghYpKYsO5buwziC1OxLdcNvF9N4kZSuHji8za6bs5
         3E1E/JFK38SGSU0JjbAvk6RZEoTyeqXUStfmKU+NLVrKfv0SfboWiXcBgPTSnOcwHbWy
         Othw==
X-Forwarded-Encrypted: i=1; AKwUvBysc351i0BCTRoMCNYcYX8L463JUqaS12SOjXWpsOKH7ydfcIQ25xiPIgeBOOvQgG3c/T8=@vger.kernel.org
X-Gm-Message-State: AFuF++ntLHR7caKInq8lCQ6J5tPfX4LZrZLW92sMj6QsOnxGVKfvEpuP
	JypsVKlyLhVexfEGIZ8TwGS3kPlmmgS0AzWswveBi2R/6OEPAzyu/4nIhE1PhcF/Ljae+Dj5KUD
	q6bQt3A==
X-Received: from plml16.prod.google.com ([2002:a17:903:1850:b0:2db:78a3:f716])
 (user=wyihan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:32c6:b0:2dd:ad74:ac29
 with SMTP id d9443c01a7336-2ddb1bae2b9mr6705575ad.27.1789677910414; Thu, 17
 Sep 2026 13:45:10 -0700 (PDT)
Date: Thu, 17 Sep 2026 20:43:49 +0000
In-Reply-To: <20260917-memory-failure-mf-delayed-fix-v6-0-4b00856b5364@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260917-memory-failure-mf-delayed-fix-v6-0-4b00856b5364@google.com>
X-Developer-Key: i=wyihan@google.com; a=ed25519; pk=cRi0fKzS5BMxlHyHY2pJv3w/1zcgfYKr6EYGYppdMYc=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789677906; l=1749;
 i=wyihan@google.com; s=20260319; h=from:subject:message-id;
 bh=3xlog7W6+Eb7uaognsijeu++wSjtW/1ijfNh02cWLeM=; b=mnhxUqOuObNj+R5apFx/dutD/hRRG/ythFNvIOI5goZLBTNWbCm8BcyPLsM2Vszxyyckiwnet
 SZYrzREtHi+DHtWpEun46A6CGi7NLx95gjCXlHx8OcmRZ0VdUKFkwcO
X-Mailer: b4 0.14.3
Message-ID: <20260917-memory-failure-mf-delayed-fix-v6-3-4b00856b5364@google.com>
Subject: [PATCH v6 3/5] mm: shmem: Update shmem handler to the MF_DELAYED definition
From: Lisa Wang <wyihan@google.com>
To: Miaohe Lin <linmiaohe@huawei.com>, Naoya Horiguchi <nao.horiguchi@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, David Hildenbrand <david@kernel.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Andi Kleen <andi@firstfloor.org>, 
	Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>, Rik van Riel <riel@redhat.com>, 
	Yu Zhang <yu.c.zhang@linux.intel.com>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>
Cc: rientjes@google.com, seanjc@google.com, ackerleytng@google.com, 
	vannapurve@google.com, michael.roth@amd.com, jiaqiyan@google.com, 
	tabba@google.com, dave.hansen@linux.intel.com, Lisa Wang <wyihan@google.com>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>
Content-Type: text/plain; charset="utf-8"

To align with the definition of MF_DELAYED, update
shmem_error_remove_folio() to return MF_DELAYED.

shmem handles memory failures but defers the actual file truncation. The
function's return value should therefore be MF_DELAYED to accurately
reflect the state.

Currently, this logical error does not cause a bug, because:

- For shmem folios, folio->private is not set.
- As a result, filemap_release_folio() is a no-op and returns true.
- This, in turn, causes truncate_error_folio() to incorrectly return
  MF_RECOVERED.
- The caller then treats MF_RECOVERED as a success condition, masking the
  issue.

The previous patch relays MF_DELAYED to the caller of
truncate_error_folio() before any logging, so returning MF_DELAYED from
shmem_error_remove_folio() will retain the original behavior of not
adding any logs.

The return value of truncate_error_folio() is consumed in action_result(),
which treats MF_DELAYED the same way as MF_RECOVERED, hence action_result()
also returns the same thing after this change.

Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Acked-by: Miaohe Lin <linmiaohe@huawei.com>
Reviewed-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Lisa Wang <wyihan@google.com>
---
 mm/shmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 774f4b18ff5c..d6f94786e709 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -5136,7 +5136,7 @@ static void __init shmem_destroy_inodecache(void)
 static int shmem_error_remove_folio(struct address_space *mapping,
 				   struct folio *folio)
 {
-	return 0;
+	return MF_DELAYED;
 }
 
 static const struct address_space_operations shmem_aops = {

-- 
2.55.0.1082.g2b9226bbc0-goog

