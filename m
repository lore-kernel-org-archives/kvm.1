Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8313A3E16A1
	for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 23:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786404194; cv=none; b=JK04fPV+YPsSza598VDZqzuexm/wUOcagizhykEr7XR3tFibswAnrQTq5EK84smzSdAPnZkYZUAmku8bXDVsR9Q/9ooqagkqWQONg9yu6IgWdxZ3T1t4IkQZiNAUwQRKtR9GLql5Hlz/Tpy5G2+BfKGKOn8u4dXE7doAwoNP2C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786404194; c=relaxed/simple;
	bh=6riWePLyH2qYVpMlK+T7n9ft2OfONf7BSNufpXaF5IY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LVgAxmV6eSfOzAQDzRwfNjISoYfghHjRYeVoiCkFj3wjHm3IVUD6Z4la8yv60PEuE42GTFKIcXWzIGgX0JgdXR3fzZKQ6mnCXK8HkQevmAhvoCRkXqMpWsrkUQ+gzhrmd4y0J7WeK7RdAnTF8lB1AqwTDt6MPFFuimaqIRoDlMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i5QQIT6K; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i5QQIT6K"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cc5faecf01so4534915ad.1
        for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 16:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786404193; x=1787008993; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FpMqKDZdeqkAxP+HMbo4Vf8RyrsMvHYCAM3HPa8Xz3s=;
        b=i5QQIT6KOO80pdis5TMSEZl5JDgS0kyM22Ryt0UJqA7PHuGWVGn52ej9OAYgHAvW4E
         VYeCD9t/Fwz2lxuoIMYjUKQlbF1j6gAN+nJIsCsj5F7cvqqolk5bD7INvJ+FO3z8rALA
         KNgslamz3nRwE2JviGqRyMqKUFAFOyX17ky18RQ4DahFZoNbyxzyrVmGYjS9VS8jR+vu
         AAI1QnBEnXdqi6ooZLn0OondriMyyGy+qUefTgcUyxzvQfkA01dnpWBPVAEOnBCC9Cy4
         V3EMP8eMs1jVW15UBOEiAxtUNjCSM8LenlR0GnMxOF9c42n3xNhSF+3F12uQc1MH7HQY
         O0eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786404193; x=1787008993;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FpMqKDZdeqkAxP+HMbo4Vf8RyrsMvHYCAM3HPa8Xz3s=;
        b=pD+kDlmaIjrAqwgKf/C7T8tiUnSiUsIconnkgHYu3/3AyRnxO2IFjynArKHlJaSJZf
         Fm0WGC+dqCnKOAGInw3o1jJ6/AJIINPfvob1UQE04WwHGv3/X0XTOULE66+hK4XLGM49
         n4BqlbsfruDh1jJgITuLkAmPWX5dJqisJSdvdeL0mR/Xtwx8Ys69KFrFIslwfIk8cm/U
         Vxbq3dbGVGWU4aaPoFR+/v9GA0clx1lNAjSMQWVDoBR8iROJGfMq0zwNWC/WIEoHD0Kz
         aHfdFgWEhGpbxX1l4I1WbyZIx3Doz4G2J+nrJ8imL70+CqSk7IkuIBJvg54Y64lr170S
         cJnQ==
X-Forwarded-Encrypted: i=1; AHgh+RoEVSq3l4DCQYPKReaOHx4qN/Cf6PQtre+F4Zt6ena1O9bzn+o95v64XaQOb+2aK0GaD/U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvWSrKYCemIRm7VAyyLN/545onwW5ssEDWiq1EouK7LKzAqCVP
	HC5csaZDCH/GS4JMNGa3WlgncebRk2Rnk1SB77+77haNhNs+0NrnIEWLUjiZcNsPz8wgJl5tm7p
	uCRc5dw==
X-Received: from plkb4.prod.google.com ([2002:a17:903:fa4:b0:2c0:a516:2c2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:fdad:b0:2bf:9760:b94d
 with SMTP id d9443c01a7336-2d0ca7fd072mr611571635ad.15.1786404192685; Mon, 10
 Aug 2026 16:23:12 -0700 (PDT)
Date: Mon, 10 Aug 2026 16:23:12 -0700
In-Reply-To: <20260728121138.1103610-5-tarunsahu@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260728121138.1103610-1-tarunsahu@google.com> <20260728121138.1103610-5-tarunsahu@google.com>
Message-ID: <anpdYD1UaO0ffQgi@google.com>
Subject: Re: [PATCH v4 04/11] KVM: Track weak reference to vm_file in struct kvm
From: Sean Christopherson <seanjc@google.com>
To: Tarun Sahu <tarunsahu@google.com>
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
Content-Type: text/plain; charset="us-ascii"

On Tue, Jul 28, 2026, Tarun Sahu wrote:
> - Add a weak reference 'vm_file' in struct kvm under

"vm_file" is effectively already claimed by vm_area_struct.vm_file.  *If* we go
this route, I would very strongly prefer to take a dependency on "vfio: Use
file-based reference counting for KVM"[*].  I'll poke that thread, we really
should land that one particular patch long before the s390-is-arm64 insanity.

Empashish on "if" because this all feels backwards.  It's not at all clear to
me why liveupdate goes directly to guest_memfd, but then requires a token associated
with the VM.

https://lore.kernel.org/all/20260731130902.654679-2-seiden@linux.ibm.com
