Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5910C3D9DAF
	for <kvm@vger.kernel.org>; Wed,  8 Apr 2026 17:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775669176; cv=none; b=cC33LI+Cq4tgs28mxqPXLpk1+8NJCXCd7rsmoyigUzbpzt1bx97C8g/VC5hzD4Hg5I2qkE12LkWk+XNLX5cwvIKQ9bQeKA7Rw7KpnOvy+PZtZagxR/rJJEbkQEPCpKsFWXYSXoTF3tKegkiPlUHvdjNiV54uSo/V7q5Ycg812kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775669176; c=relaxed/simple;
	bh=sG0P7RhWvhPfeqHAnDvFiL/wdpauzKoG7D3X6bRIOBg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mDf1wlqUdUe4oOK5FYnB08EXVgzUX4LiMwG5blsGzybVElsuT3S5MqhcFvM+M18i5FLT61vfHQeeutcSnnYFPgLY7Hpfwa5vD3oQozz2is/e67NUd/3Izj0i7yruI8SKm0cGG00c/Np7i5E5BugdpwrcWIEfRn42DEMLKx6BJHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hL/HvRbb; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hL/HvRbb"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82c649dc145so5447b3a.3
        for <kvm@vger.kernel.org>; Wed, 08 Apr 2026 10:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775669175; x=1776273975; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HKfhxJtawehvSEWMDkPfY/SsNOZhfVJKas8DUTzpFWA=;
        b=hL/HvRbbr3VWYLQYgOb1k3af9d4hnNSo07gxM5r3cq9+2RXGiqPxSd3Yei3ZmMa+d8
         /SDTU1e8/dpeDwhxXLZU2fetnfxt0Gt5XCj6uuqYlh0jriAKOgBAMT+JaiI0ynl4EEd+
         Ggen7nfonys6NfIZ9y8mCHeOQ2lnmpC/j2wu6Gg0axtE1J4de5gL0KF844NCR78lKvmg
         T58YjOz/HHBbJFar2DvPnn9PdXbE55vMlYvqOCDKX+zAOp2ZM6SipKieDS6yYvaGIMx+
         PzAMms3d1YhvJQB37vvgse260BmwwYWzTFq8GAWbSYoIFp4hwajYqy0W7E9B69n2V3AF
         J1JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775669175; x=1776273975;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HKfhxJtawehvSEWMDkPfY/SsNOZhfVJKas8DUTzpFWA=;
        b=eFNw63/1IixzQ0ijjzyml+3X5KptcP7kyOiuSBvQOx7rQs9K5wQOeIuAQgztDCS5/1
         OeZuEI5E2o5ESoFABWq5pO8VlFavgUAWf21yXGXLid3I+K6l1OlF7In3hN/H3MEXfnnC
         b4ytlUU3dOUfv4heYKdRV/SyeZ5EOb4nEiDdvG6DDEeuI49P/hXXrH0eXeyk1BKH8MUt
         wy26AaIWv7r56nRSB8NoeN53V59gS1ccH1Ip0HP1XCC+LimdbSIR25zyfgGpb6GurOaQ
         W+O9WrkC/Rwdru63lYg4eS7aCHH1GlmHNHnAVDZ3oBlzVO1zrposW8Hh1XVbLkI7Cq2z
         E4jw==
X-Forwarded-Encrypted: i=1; AJvYcCUlnYFZyEraZEzN9T/WTjZOg8AUHdirVRUf4NKRBCWQ0wt+N30hwBl9mENdn+lw50XiQ28=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyucw9JGgciGYHq15yLn6K1qS0LNyimCwUZ3pTfzL6haEnmMUDO
	OcSS6w76EIxa5LoU+7LwjOk4F4bIj4MIyVEFFfea47rZP0LI02GYJ7FeP7/7MlbrwAWK8hLfkfs
	ORSPVSA==
X-Received: from pfbay5.prod.google.com ([2002:a05:6a00:3005:b0:82c:67aa:804])
 (user=wyihan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:a0b:b0:81f:852b:a925
 with SMTP id d2e1a72fcca58-82d0da4594cmr21368656b3a.1.1775669174393; Wed, 08
 Apr 2026 10:26:14 -0700 (PDT)
Date: Wed, 08 Apr 2026 17:24:44 +0000
In-Reply-To: <20260408-memory-failure-mf-delayed-fix-rfc-v3-v3-0-718f45eb7c75@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260408-memory-failure-mf-delayed-fix-rfc-v3-v3-0-718f45eb7c75@google.com>
X-Developer-Key: i=wyihan@google.com; a=ed25519; pk=cRi0fKzS5BMxlHyHY2pJv3w/1zcgfYKr6EYGYppdMYc=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775669168; l=1598;
 i=wyihan@google.com; s=20260319; h=from:subject:message-id;
 bh=sG0P7RhWvhPfeqHAnDvFiL/wdpauzKoG7D3X6bRIOBg=; b=HYYjhlQyURswF6uipGoryLPDVw7e6x7xLSDi6B5Ls1j0ivGRToHWOQGxxy9K2uu5HWYRcsBPt
 EKIp8P5HwgPAwc24TnV56V+kv3ClUL+8+ATdyRnYAbdQ0knKeaLNQGa
X-Mailer: b4 0.14.3
Message-ID: <20260408-memory-failure-mf-delayed-fix-rfc-v3-v3-3-718f45eb7c75@google.com>
Subject: [PATCH RFC v3 3/7] mm: shmem: Update shmem handler to the MF_DELAYED definition
From: Lisa Wang <wyihan@google.com>
To: Miaohe Lin <linmiaohe@huawei.com>, Naoya Horiguchi <nao.horiguchi@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Cc: rientjes@google.com, seanjc@google.com, ackerleytng@google.com, 
	vannapurve@google.com, michael.roth@amd.com, jiaqiyan@google.com, 
	tabba@google.com, dave.hansen@linux.intel.com, Lisa Wang <wyihan@google.com>
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

Signed-off-by: Lisa Wang <wyihan@google.com>
---
 mm/shmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index b40f3cd48961..fd8f90540361 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -5207,7 +5207,7 @@ static void __init shmem_destroy_inodecache(void)
 static int shmem_error_remove_folio(struct address_space *mapping,
 				   struct folio *folio)
 {
-	return 0;
+	return MF_DELAYED;
 }
 
 static const struct address_space_operations shmem_aops = {

-- 
2.53.0.1213.gd9a14994de-goog

