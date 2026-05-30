Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCCA3A3E78
	for <kvm@vger.kernel.org>; Sat, 30 May 2026 10:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780136803; cv=none; b=nsD4IsRnN2Zz0BeSuqCm3CST3NkRac57fgs9T5ro0nIUYsxp76qT4KFcq65e1Y1E45relcR/18sL99e09TVSInZLVV3AdPWcU9coCeigAA+kUurLp/qKMf+0hvwKSsn/2fnH56DdMqf9Wi8yLyn6k9ud7hIp3wy+tWiGgO+x4yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780136803; c=relaxed/simple;
	bh=N4THDbJpEV/8hnNekojx0O/f9LO2ZvArPZsbPr6kWAg=;
	h=Content-Type:Message-ID:Date:MIME-Version:From:Subject:To:Cc:
	 References:In-Reply-To; b=PS1zr3FiT3r8x2ZDoR4bzInD7DvHTufZm2Ha8RNLYnpFY40E3qx3ylnmz3vtOVeHkTcnPG9hWE5H31UbjTkmaXqE0Stl1gWpGCJ+3ul9QjE8iug/su0t+17MYBrtqV13PyNnFJfUw+knVwnDkXw1aybw8SIshMj9/IVhUebs8ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H3eBIENL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H3eBIENL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780136795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=k+iWErnEbGUPPRzc4Is8Fwp8fdR7scNr8yplwhh9fEY=;
	b=H3eBIENLYluz7/spxmJTkl0wKBpshaGCP2XKgNHKetQZxHJ6AQB99lJuImhKvjJJ6mpo9L
	iMujPqWcm5XpdBSRWDQtcpAblUgHR9Aa6O+cX4WQHEMiDwE1aY8o4zdZbupeleb0F0tJZd
	CSHO5c6xcHTal+4vM7wcwtQyZtNO0sI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-251-DjUJI_1UM1GXFK8KKwmt7A-1; Sat,
 30 May 2026 06:26:29 -0400
X-MC-Unique: DjUJI_1UM1GXFK8KKwmt7A-1
X-Mimecast-MFC-AGG-ID: DjUJI_1UM1GXFK8KKwmt7A_1780136787
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A3C701956089;
	Sat, 30 May 2026 10:26:26 +0000 (UTC)
Received: from [10.44.32.11] (unknown [10.44.32.11])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E134D19560A3;
	Sat, 30 May 2026 10:26:21 +0000 (UTC)
Content-Type: multipart/mixed; boundary="------------Z3eQGNDYOG7MJacqJi7Ula9k"
Message-ID: <1c3b224f-2780-4347-b72b-783586a9b0e1@redhat.com>
Date: Sat, 30 May 2026 12:26:20 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 01/20] locking/rt: Use raw_spin_lock_irqsave() in
 __rwbase_read_unlock()
To: Sean Christopherson <seanjc@google.com>,
 Peter Zijlstra <peterz@infradead.org>
Cc: David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>,
 Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Waiman Long <longman@redhat.com>,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 David Woodhouse <dwmw@amazon.co.uk>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 syzbot+208f7f3e5f59c11aeb90@syzkaller.appspotmail.com,
 Carsten Stollmaier <stollmc@amazon.com>
References: <20260529165114.748639-1-seanjc@google.com>
 <20260529165114.748639-2-seanjc@google.com>
 <20260529193214.GN3493090@noisy.programming.kicks-ass.net>
 <20260529193437.GB3568911@noisy.programming.kicks-ass.net>
 <ahnxfACTGeVFbJMk@google.com>
 <20260529201335.GP3493090@noisy.programming.kicks-ass.net>
 <20260529203841.GC3568911@noisy.programming.kicks-ass.net>
 <aho1M7fvK1Qzmiai@google.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <aho1M7fvK1Qzmiai@google.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

This is a multi-part message in MIME format.
--------------Z3eQGNDYOG7MJacqJi7Ula9k
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/30/26 02:54, Sean Christopherson wrote:
> On Fri, May 29, 2026, Peter Zijlstra wrote:
>> On Fri, May 29, 2026 at 10:13:35PM +0200, Peter Zijlstra wrote:
>>
>>> It is somewhat possible to do an RT aware read-write spinlock thing, but
>>> it is definitely non-trivial and this would be the only user.
>>
>> Furthermore, it is fundamentally one of the worst possible lock types.
>>
>> It really isn't something you *want* to have -- arguably even for !RT.
>>
>> They scale like ass; per them being a spinlock type, the critical
>> sections must be short, but this means there is nothing to amortize the
>> cost of bouncing the shared lock around -- which is the 'saving' grace
>> of the rwsem.
>>
>> For short sections the cost of the shared access will dominate. I'm sure
>> Paul has a bunch of graphs to illustrate this point :-)
> 
> Hrm.  We might be able to do an SRCU-based implementation.  Full RCU would be
> too unpredictable on the update side.

Yeah, I think so.

The write side needs kvm->srcu so it would have to be yet another SRCU. 
I initially thought that sucks for the code that calls kvm_gpc_check(), 
but maybe not because it simply replaces read_lock/read_unlock.

By using a seqcount for the data, SRCU only needs to be synchronized in 
gpc_unmap().  So, something like this:

struct kvm_cached_gva_map {
	struct kvm_memory_slot *memslot;
	void *khva;
	unsigned long uhva;
	unsigned long idx;
};

/* snapshot is the new check */
bool kvm_gpc_snapshot(struct gfn_to_pfn_cache *gpc, unsigned long len,
		      struct kvm_cached_gva_map *ret)
{
	struct kvm_memslots *slots = kvm_memslots(gpc->kvm);
	unsigned seq;
	u64 generation;
	gpa_t gpa;

	/* The data is protected by the seqcount, the khva by SRCU.  */
	ret->idx = srcu_read_lock(&gpc->kvm->gpc_srcu);
	/* A seqcount_spinlock_t, but see below - there's a bug!  */
	if (!raw_seqcount_try_begin(&gpc->sc, seq))
		goto out_fail;

	if (!gpc->active || !gpc->valid)
		goto out_fail;

	ret->uhva = gpc->uhva;
	ret->khva = gpc->khva;
	ret->memslot = gpc->memslot;
	gpa = gpc->gpa;
	generation = gpc->generation;
	if (read_seqcount_retry(&gpc->sc, seq))
		goto out_fail;

	/*
	 * Now do all the validity checks on a stable copy.
	 * If the page was cached from a memslot, make sure the
	 * memslots have not been re-configured.
	 */
	if (!kvm_is_error_gpa(gpa) && generation != slots->generation)
		goto out_fail;

	if (kvm_is_error_hva(ret->uhva))
		goto out_fail;

	if (!kvm_gpc_is_valid_len(gpa, ret->uhva, len))
		goto out_fail;

  	return true;

out_fail:
	srcu_read_unlock(&gpc->kvm->gpc_srcu, ret->idx);
	return false;
}

static inline
void kvm_gpc_snapshot_release(struct gfn_to_pfn_cache *gpc,
			      struct kvm_cached_gva_map *ret)
{
	srcu_read_unlock(&gpc->kvm->gpc_srcu, ret->idx);
}

Introducing snapshot as a replacement for check (while still leaving it 
to the caller to take the rwlock) can even be a separate patch.

There is a bug in raw_seqcount_try_begin() though.  It must not do the 
lock/unlock dance or it won't be usable in atomic context.  See attached 
patch.

> The big hiccup is when KVM needs to reclaim memory in response to mmu_notifier
> events from the OOM killer, which don't allow sleeping.  I'll stare at this a
> bit next week.  I'm not exactly thrilled about the idea of ripping apart this
> code, but there's a known performance bottleneck with mmu_notifier events,
> maybe we can kill two birds with one stone.

There was a pending patch to allow the MMU notifiers to disable 
themselves while still in sleepable context.

https://lore.kernel.org/kvm/20260429222548.25475-1-shaikhkamal2012@gmail.com/

It really needs to be split in multiple parts, and the allocation needs 
to be removed.  Looking at it.

Otherwise, calling synchronize_srcu() from gpc_unmap(), which is within 
the kvm->srcu read side, is also a bit unpredictable.  But the read 
sides are super short so you can make it expedited.

Or can you just skip the synchronize_srcu() from OOM via 
check_stable_address_space()?  Maybe pretend I didn't suggest that.

Paolo
--------------Z3eQGNDYOG7MJacqJi7Ula9k
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-seqcount-allow-raw_seqcount_try_begin-in-atomic-cont.patch"
Content-Disposition: attachment;
 filename*0="0001-seqcount-allow-raw_seqcount_try_begin-in-atomic-cont.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSBmMmM2MDRhOTRjZGVhOWJiOTZiYjIxYzhhMjkyODhlYWU2Y2JhYzY3IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBQYW9sbyBCb256aW5pIDxwYm9uemluaUByZWRoYXQu
Y29tPgpEYXRlOiBTYXQsIDMwIE1heSAyMDI2IDEwOjU0OjM2ICswMjAwClN1YmplY3Q6IFtQ
QVRDSF0gc2VxY291bnQ6IGFsbG93IHJhd19zZXFjb3VudF90cnlfYmVnaW4gaW4gYXRvbWlj
IGNvbnRleHQKCldoZW4gcmF3X3NlcWNvdW50X3RyeV9iZWdpbigpIGlzIHVzZWQsIHRoZSB0
eXBpY2FsIGFjdGlvbiB3aGVuCnRoZSBzZXFjb3VudCBpcyBidXN5IGlzIHRvIHRha2UgdGhl
IHNhbWUgbG9jayB0aGF0IHRoZSB3cml0ZXIgdXNlcy4KQW5vdGhlciBwb3NzaWJpbGl0eSwg
Zm91bmQgaW4ga2VybmVsL2V2ZW50cy91cHJvYmVzLmMsIGlzIHRvIGRlbGF5CnRoZSB3b3Jr
IHRvIGEgc2FmZSBwb2ludCB1c2luZyBSQ1UuICBFaXRoZXIgd2F5IHRoZXJlIGlzIG5vIG5l
ZWQKdG8gZ3VhcmFudGVlIHByb2dyZXNzIG9mIHRoZSB3cml0ZXIgdW5kZXIgQ09ORklHX1BS
RUVNUFRfUlQsCmJlY2F1c2UgdGhlIGNhbGxlciBpcyBub3QgZ29pbmcgdG8gY2FsbCByYXdf
c2VxY291bnRfdHJ5X2JlZ2luKCkgaW4gYSBsb29wLgoKSG93ZXZlciwgcmF3X3NlcWNvdW50
X3RyeV9iZWdpbigpIGN1cnJlbnRseSB1c2VzIHNlcXByb3Bfc2VxdWVuY2UoKQp2aWEgcmF3
X3JlYWRfc2VxY291bnQoKSwgYW5kIHRoZXJlZm9yZSBkb2VzIGEgbG9jay91bmxvY2sgb2Yg
dGhlCndyaXRlLXNpZGUgbG9jayBvbiBQUkVFTVBUX1JUIGtlcm5lbC4gIFRoaXMgcHJldmVu
dHMgaXQgZnJvbSBiZWluZwp1c2VkIGluIGF0b21pYyBjb250ZXh0LiAgVXNlIF9fc2VxcHJv
cF9zZXF1ZW5jZSgpIGluc3RlYWQgb2YKcmF3X3JlYWRfc2VxY291bnQoKSB0byBhbGxvdyBp
dC4KCkNjOiBQZXRlciBaaWpsc3RyYSA8cGV0ZXJ6QGluZnJhZGVhZC5vcmc+CkNjOiBTZWFu
IENocmlzdG9waGVyc29uIDxzZWFuamNAZ29vZ2xlLmNvbT4KU2lnbmVkLW9mZi1ieTogUGFv
bG8gQm9uemluaSA8cGJvbnppbmlAcmVkaGF0LmNvbT4KLS0tCiBpbmNsdWRlL2xpbnV4L3Nl
cWxvY2suaCB8IDUgKysrKy0KIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDEg
ZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3NlcWxvY2suaCBiL2lu
Y2x1ZGUvbGludXgvc2VxbG9jay5oCmluZGV4IDVhNDAyNTJiODMzNC4uOWFkYmY1ZDk2Njdj
IDEwMDY0NAotLS0gYS9pbmNsdWRlL2xpbnV4L3NlcWxvY2suaAorKysgYi9pbmNsdWRlL2xp
bnV4L3NlcWxvY2suaApAQCAtMzM4LDcgKzMzOCwxMCBAQCBTRVFDT1VOVF9MT0NLTkFNRSht
dXRleCwgICAgICAgIHN0cnVjdCBtdXRleCwgICAgdHJ1ZSwgICAgIG11dGV4KQogICovCiAj
ZGVmaW5lIHJhd19zZXFjb3VudF90cnlfYmVnaW4ocywgc3RhcnQpCQkJCVwKICh7CQkJCQkJ
CQkJXAotCXN0YXJ0ID0gcmF3X3JlYWRfc2VxY291bnQocyk7CQkJCQlcCisJc3RhcnQgPSBf
X3NlcXByb3Bfc2VxdWVuY2Uocyk7CQkJCQlcCisJCQkJCQkJCQlcCisJaWYgKCEoc3RhcnQg
JiAxKSkJCQkJCQlcCisJCWtjc2FuX2F0b21pY19uZXh0KEtDU0FOX1NFUUxPQ0tfUkVHSU9O
X01BWCk7CQlcCiAJIShzdGFydCAmIDEpOwkJCQkJCQlcCiB9KQogCi0tIAoyLjU0LjAKCg==


--------------Z3eQGNDYOG7MJacqJi7Ula9k--

