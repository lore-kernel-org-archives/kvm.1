Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D033AFCEC
	for <kvm@vger.kernel.org>; Sun, 23 Aug 2026 19:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787514078; cv=none; b=mhrvecJjb9O/bVA1/sxQV+vNjDUkcPjjwqCucmKigSAwiyP2LA8Yy6vN3kKITHP8phVGHi+UiFzs2jlPMfx63AS3RWWEnzQ7vdeqObWmAfeC/JUE8l9dTpOXmRQqr8jQjAqj0thePtN7j6LubhjuYbuk+T/fZAWTvCr5ulqiDwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787514078; c=relaxed/simple;
	bh=7+x/sWXp759BrhYESvsKCOdad1Y/iKVS+soYyV1CIy4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=N7vg0YWKJ2Xgt16WjTUgb/je5j6SNoa6V/m1v4sdF8t78hsEhLz+vGA2/Zi8+qtwBIfiES4gqK/iDQe/YPNImTyqvbma8bdd+/abKd+UEOT1d4T40RlTWoawcFWl0pTf0RmA9lObo0xHm4g9hVe4IHbtnj0obwcOTzM4BTk+nlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u8RvJLR0; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u8RvJLR0"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-84e375d9736so2157894b3a.2
        for <kvm@vger.kernel.org>; Sun, 23 Aug 2026 12:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787514076; x=1788118876; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Iy2xP8SK9yJbNhS8FwmPsx22x8G5GrN0of+eDDc1n/E=;
        b=u8RvJLR0yxFVR6jcOjKWIW400PtBj+qi4xP+lw/Qc+HrihxEcROpsqCOS6fxq549YK
         7c/iK3pnI2f4JxPK94gvQNw7IuLL78W/SlH0pR7X3AC2FJFc3tckevDP4mq1f+VhnAwt
         1lco/wa1l/KYL8gLBrnJhaOLzN2mGjEm6hHih2VUw6pQdJIRXgy2yOTnRpNeLsFXY269
         pLy5BoSBCu893qo9MbkQ0658bCQ7d6MzW3AnB3mHjaTZyFg05Mo/a00IYBrudUPQu5Sp
         a5IbvHUQU23LX/K53nwCGAc1OpogzfS1kAExyJxfyBDxoItYhsfeHlFSjcNpcMrTBWV+
         sezg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787514076; x=1788118876;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Iy2xP8SK9yJbNhS8FwmPsx22x8G5GrN0of+eDDc1n/E=;
        b=PcYeNyY54FOpFwGIq9mdJGFoLmL077ODySC04Nn9GPCho1RSj6MKjdre/YcqEYcp5h
         nQjcFgsUHmsrz2lcBoBfcHJzjM2mXh/3Sie92Nzw+uF+JvIzxBPOvauHQC6V6nUFpWTC
         ABcLtyj6nljfzskblWGq09W2HbtfO6Pgil4suzr/R9cbB6Z0++TxKCG8BKh/v5at9dVE
         dq2kRPVMuiUv0kZkC/tR0b2lfDlqEGbBZyz1Q/LSbKEQeJ/Yd54BH+y4SV8OSeVX8he1
         KX4SSlEOD0230RalgENSKW3fD1rpzA33q2vbqTQbnY0FNHZjO91GzdomA1lF267Qbf+d
         u+VA==
X-Forwarded-Encrypted: i=1; AHgh+Rrz4uvJ6pTf1wqp3OB/RCXVt0pNcsUqvsbRQsXL3gMMlMqM7MA6IjYNMZmZL7Aq0qmbm+Y=@vger.kernel.org
X-Gm-Message-State: AFuF++lrzAfd/TfLmDK4oZgFEa0zp+fOAB7nHR1Z0Sc+KR+tqLhQ/C1J
	0lu7yTkeU3lGxBYlJYGbmC+x8mhBqwnDd5P/I0Rj+lrSdMeIjWLRyw1j8iZV1FT41iqlInTmVBR
	PK0BYMw==
X-Received: from pfve12.prod.google.com ([2002:a05:6a00:1a8c:b0:84f:d0db:d487])
 (user=wyihan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2998:b0:848:2ab3:ddeb
 with SMTP id d2e1a72fcca58-851f9fc70e9mr36741015b3a.14.1787514075918; Sun, 23
 Aug 2026 12:41:15 -0700 (PDT)
Date: Sun, 23 Aug 2026 19:40:56 +0000
In-Reply-To: <20260823-memory-failure-mf-delayed-fix-v5-0-d97a5703e45a@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260823-memory-failure-mf-delayed-fix-v5-0-d97a5703e45a@google.com>
X-Developer-Key: i=wyihan@google.com; a=ed25519; pk=cRi0fKzS5BMxlHyHY2pJv3w/1zcgfYKr6EYGYppdMYc=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787514072; l=1748;
 i=wyihan@google.com; s=20260319; h=from:subject:message-id;
 bh=7+x/sWXp759BrhYESvsKCOdad1Y/iKVS+soYyV1CIy4=; b=t6KDI83BTgefmAewaihHmX8c+a3Z2iVi2HmHLIEX8ewkBOpraGu5znzx83qmcqz9NkbqAA93K
 XHaFoPVbaLMCwjlTnZrExtl4UfWAk0GR1XY30NzM8pr0DtLo35T2mE1
X-Mailer: b4 0.14.3
Message-ID: <20260823-memory-failure-mf-delayed-fix-v5-3-d97a5703e45a@google.com>
Subject: [PATCH v5 3/5] mm: shmem: Update shmem handler to the MF_DELAYED definition
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
2.55.0.766.g2966f0265a-goog

