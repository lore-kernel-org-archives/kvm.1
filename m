Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8EB47DD50
	for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 16:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787070593; cv=none; b=YNmLyVHbFyP9LP5yddTm8CL54qrllF8aIidYNTMKuHj0HyWuHZtjYFZBLOhFeIt+YhbxiJiUNg8uKaJDDeFig9cAwBJWbjVnFS5AxQN1Z6/LsqwbVJXUtP0BqDGLipiLGDzWGg8jr10muaS+Y9/LJg1eUFNdq4N3NVcEEZaPy7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787070593; c=relaxed/simple;
	bh=vC2RlolhkLS2+1s4l2UramjQAZbiE9X0zYRFDEG/2wo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cHA1A9H7LOQL1gwT0Vx/U7zsQnpcPWGbFKYDYBvm5NV/QUKy2+ne0yEYR04MgsjHJdt+VYi94OGz03ohlFxigXfvs/cyOxyWJOJ9sDql3tmBNkPJ5E5dY0wKmgLyMwZ9tYQhz4hmUonJqIYEHW4GY6eSVuhxfPu9Vf6g+EhMiZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=alIWfv8o; arc=none smtp.client-ip=209.85.208.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="alIWfv8o"
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-6a0a4a22bf0so43397a12.0
        for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 09:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787070590; x=1787675390; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/eyzaZNjJLEyd0fKbeRAuoUQBuqF6sdPIInoyVaJmj0=;
        b=alIWfv8obtNxF/dFCsPGwQF6yl0IAtic7uyJY45RPXxmzItjOHsoTnLvTOqjQG4lQ1
         jYLvbizt+0iYvVb7OtsJuO1WN9r4gUc+sBNwhn4D3Aya108cgty6TMhGypazo08HdU6B
         DILCRbQFLZt+BJZZZC+yAnJrcgQ3lgOyholMTzXb/rqQUeZVC5vCRXAStYO5VOWwrr6w
         8c1KLdeNVwVwENb5fRr6ohDFZOvaNmdRr2eRsixg6dCl6PZRown8FQpck6Sz2i3jvZ2R
         fs9W/RGurCKuf5ohfhDwyCvCEnQvnmQhzxbA6VsB4y7URBQNtpxa0beiOdfp8hWnsafN
         FJYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787070590; x=1787675390;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/eyzaZNjJLEyd0fKbeRAuoUQBuqF6sdPIInoyVaJmj0=;
        b=Sek+tY0ziLDkJ3lKZXYtmB4b4KKfcdOBmepzvq7y1ZpTZch9k9JGdySQMxIIomWRFM
         MftMDZw0UGCFgCJgpdtNFbNK+4zPgqI7lhQXq+FFxJZ3F6U0N/Ywb0VYpAX465m118qO
         Zoq/L6+7tiNN+/F3d+/vlBrEiSfjlTmD9JFWj4LvhwrS0RGUxP+bmVtIrXqJbEnywCRI
         U2geHaU47Nj0V1eDTVxYBWxk64qq/aY8FOZZyAhevNBF0S3Vcp4CUeJNzDw3Ia9juS9c
         V5tKMy8LzPNQjAqKHPNPWQDQ8IE7H4LgXLL4cpsf1Bn04ZSH00nXDscExdBtFuXJVgAS
         vhjg==
X-Forwarded-Encrypted: i=1; AHgh+RqeaofrE+VNMWwoEiPirp5oVuVte/yNFjxYIWrC1VlHK5dh9Cyizqm0o3stTtAmpUX0p3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv5PvIjDZPAXGMAk8oMgBJvS4yRd03bXyCc1BwIon+tiBi/W6p
	Lhqy44QVil41KRmRUfpzPJorHCVUyT1Fc2S5gRp5/6xtJqyvh0aMuR6bY6Cn2fm/F0Tk07/Iw2g
	BJM8lsHn8VPbRbjmAtw==
X-Received: from edts26.prod.google.com ([2002:aa7:cb1a:0:b0:6a1:f410:2ec5])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:e85:b0:6a3:edb6:2228 with SMTP id 4fb4d7f45d1cf-6a3edb6285cmr3681617a12.17.1787070589499;
 Tue, 18 Aug 2026 09:29:49 -0700 (PDT)
Date: Tue, 18 Aug 2026 16:29:48 +0000
In-Reply-To: <anpdYD1UaO0ffQgi@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260728121138.1103610-1-tarunsahu@google.com>
 <20260728121138.1103610-5-tarunsahu@google.com> <anpdYD1UaO0ffQgi@google.com>
Message-ID: <9huzik57v1c3.fsf@tarunix.c.googlers.com>
Subject: Re: [PATCH v4 04/11] KVM: Track weak reference to vm_file in struct kvm
From: tarunsahu@google.com
To: Sean Christopherson <seanjc@google.com>
Cc: ackerleytng@google.com, fuad.tabba@linux.dev, 
	Andrew Morton <akpm@linux-foundation.org>, dmatlack@google.com, 
	Shuah Khan <skhan@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>, david@redhat.com, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, sagis@google.com, 
	Paolo Bonzini <pbonzini@redhat.com>, Mike Rapoport <rppt@kernel.org>, Alexander Graf <graf@amazon.com>, 
	linux-kselftest@vger.kernel.org, andre.przywara@arm.com, michael.roth@amd.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, will@kernel.org, 
	vannapurve@google.com, maz@kernel.org, fvdl@google.com, kvm@vger.kernel.org, 
	oliver.upton@linux.dev, kvmarm@lists.linux.dev, alexandru.elisei@arm.com, 
	skhawaja@google.com, aneesh.kumar@kernel.org, linux-doc@vger.kernel.org, 
	David Hildenbrand <david@kernel.org>, yan.y.zhao@intel.com, kexec@lists.infradead.org, 
	suzuki.poulose@arm.com
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

> On Tue, Jul 28, 2026, Tarun Sahu wrote:
>> - Add a weak reference 'vm_file' in struct kvm under
>
> "vm_file" is effectively already claimed by vm_area_struct.vm_file.  *If* we go
> this route, I would very strongly prefer to take a dependency on "vfio: Use
> file-based reference counting for KVM"[*].  I'll poke that thread, we really
> should land that one particular patch long before the s390-is-arm64
> insanity.

[*] Seem interesting way to solve this. So we will also have vm_file
directly in guest_memfd instead of struct kvm and refcounting on vm_file
instead struct kvm?

struct gmem_file {
-	struct kvm *kvm;
+	struct file *vm_file;
	struct xarray bindings;
	struct list_head entry;
};

>
> Empashish on "if" because this all feels backwards.

> It's not at all clear to
> me why liveupdate goes directly to guest_memfd, but then requires a token associated
> with the VM.

guest_memfd can be recreated without having the struct kvm, Which there
is no way to pass it on retrieval path. So the function
kvm_gmem_luo_retrieve() gets this VM token, find the vm_file (hence
struct kvm) associated with the preserved guest_memfd. Now it create a
fresh guest_memfd by calling kvm_gmem_create(..., kvm). And populate
preserved flags and folios to this guest_memfd.

>
> https://lore.kernel.org/all/20260731130902.654679-2-seiden@linux.ibm.com
